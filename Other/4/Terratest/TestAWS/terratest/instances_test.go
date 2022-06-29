package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestInstances(t *testing.T) {
	fmt.Println("Start testing.........................")
	// Deploy the example
	terraformFolder := "../terraform"
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, terraformFolder)
		terraform.Destroy(t, terraformOptions)

		keyPair := test_structure.LoadEc2KeyPair(t, terraformFolder)
		aws.DeleteEC2KeyPair(t, keyPair)
	})

	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions, keyPair := configureTerraformOptions(t, terraformFolder)

		// Save the options and key pair so later test stages can use them
		test_structure.SaveTerraformOptions(t, terraformFolder, terraformOptions)
		test_structure.SaveEc2KeyPair(t, terraformFolder, keyPair)

		// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, terraformFolder)
		keyPair := test_structure.LoadEc2KeyPair(t, terraformFolder)

		testSSHToPublicHost(t, terraformOptions, keyPair)
	})
}

func testSSHToPublicHost(t *testing.T, terraformOptions *terraform.Options, keyPair *aws.Ec2Keypair) {
	// Run `terraform output` to get the value of an output variable
	publicInstanceIP := [2]string{terraform.Output(t, terraformOptions, "AWS_App_Server"), terraform.Output(t, terraformOptions, "AWS_Db_Server")}

	// We're going to try to SSH to the instance IP, using the Key Pair we created earlier, and the user "ubuntu",
	// as we know the Instance is running an Ubuntu AMI that has such a user

	publicHost := []ssh.Host{
		{
			Hostname:    publicInstanceIP[0],
			SshKeyPair:  keyPair.KeyPair,
			SshUserName: "ubuntu",
		},
		{
			Hostname:    publicInstanceIP[1],
			SshKeyPair:  keyPair.KeyPair,
			SshUserName: "ec2-user",
		},
	}

	for i := 0; i <= 1; i++ {

		// It can take a minute or so for the Instance to boot up, so retry a few times
		maxRetries := 30
		timeBetweenRetries := 5 * time.Second
		description := fmt.Sprintf("SSH to public host %s", publicInstanceIP[i])

		// Run a simple echo command on the server
		expectedText := "Host is ready . . ."
		command := fmt.Sprintf("echo -n '%s'", expectedText)

		// Verify that we can SSH to the Instance and run commands
		retry.DoWithRetry(t, description, maxRetries, timeBetweenRetries, func() (string, error) {
			actualText, err := ssh.CheckSshCommandE(t, publicHost[i], command)

			if err != nil {
				return "", err
			}

			if strings.TrimSpace(actualText) != expectedText {
				return "", fmt.Errorf("Expected SSH command to return '%s' but got '%s'", expectedText, actualText)
			}

			return "", nil
		})

		// Run a command on the server that results in an error,
		expectedText = "Host is ready . . ."
		command = fmt.Sprintf("echo -n '%s' && exit 1", expectedText)
		description = fmt.Sprintf("SSH to public host %s with error command", publicInstanceIP[i])

		// Verify that we can SSH to the Instance, run the command and see the output
		retry.DoWithRetry(t, description, maxRetries, timeBetweenRetries, func() (string, error) {

			actualText, err := ssh.CheckSshCommandE(t, publicHost[i], command)

			if err == nil {
				return "", fmt.Errorf("Expected SSH command to return an error but got none")
			}

			if strings.TrimSpace(actualText) != expectedText {
				return "", fmt.Errorf("Expected SSH command to return '%s' but got '%s'", expectedText, actualText)
			}

			return "", nil
		})
	}
}

func configureTerraformOptions(t *testing.T, exampleFolder string) (*terraform.Options, *aws.Ec2Keypair) {
	// A unique ID we can use to namespace resources so we don't clash with anything already in the AWS account or
	// tests running in parallel
	uniqueID := random.UniqueId()

	// Give this EC2 Instance and other resources in the Terraform code a name with a unique ID so it doesn't clash
	// with anything else in the AWS account.
	//instanceName := fmt.Sprintf("terratest-ssh-example-%s", uniqueID)

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	//awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsRegion := "eu-north-1"

	// Some AWS regions are missing certain instance types, so pick an available type based on the region we picked
	//instanceType := aws.GetRecommendedInstanceType(t, awsRegion, []string{"t2.micro", "t3.micro"})

	// Create an EC2 KeyPair that we can use for SSH access
	keyPairName := fmt.Sprintf("terratest-ssh-%s", uniqueID)
	keyPair := aws.CreateAndImportEC2KeyPair(t, awsRegion, keyPairName)

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: exampleFolder,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			//"aws_region":    awsRegion,
			//"instance_name": instanceName,
			//"instance_type": instanceType,
			"key_pair_name": keyPairName,
		},
	})

	return terraformOptions, keyPair
}
