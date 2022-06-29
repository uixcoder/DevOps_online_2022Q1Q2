## Limks
https://github.com/gruntwork-io/terratest/blob/36cc06080c85316fc46a26ed1aa473b762dc77cb/test/terraform_ssh_example_test.go#L63

https://www.infracloud.io/blogs/testing-iac-terratest/

https://blog.gruntwork.io/open-sourcing-terratest-a-swiss-army-knife-for-testing-infrastructure-code-5d883336fcd5

https://blog.octo.com/test-your-infrastructure-code-with-terratest/

## Executing tests

Switch your directory to the location where you have cloned the repository. Navigate to the location where you have test files located.

Initialize Go modules, and download the dependencies. Take a look at Setting up your project section of Terratest documentation for more details.

`$ go mod init ec2_instance`

`$ go mod tidy`

```
$ export AWS_ACCESS_KEY_ID=**************
$ export AWS_SECRET_ACCESS_KEY=**************************************
$ export AWS_DEFAULT_REGION=*******
```

And finally execute test:

`$ go test -v`
