## Jenkins Deploy petclinic application pipeline

### 1. Manually add credentials to Jenkins for AWS access and future database access

![a1](img/a1.png)

### 2. Create and configure Pipeline that creates,  configures infrastructure, deploys application

Create new pipeline

![a3](img/a3.png)

Add [code](Jenkins1.txt) to pipeline

```
pipeline {
    agent {label 'agent1'}
    environment{
       AWS_ACCESS_KEY_ID=credentials('jenkins-aws-access-key-id')
       AWS_SECRET_ACCESS_KEY=credentials('jenkins-aws-secret-access-key')
       AWS_REGION=credentials('jenkins-aws-default-region')
       DB_NAME=credentials('petdbname')
       DB_USER=credentials('petdbuser')
       DB_PASSWORD=credentials('petdbpassword')       
    }

    tools {
        maven "M3"
    }

    stages {
        stage ('Get Project from repository'){
            steps {
                git branch: 'master', url: 'https://github.com/uixcoder/spring-framework-petclinic.git'
                dir ('Deploy_AWS_EC2_PostgerSQL') {
                    git branch: 'master', url: 'https://github.com/uixcoder/Deploy_AWS_EC2_PostgerSQL.git'
                }
            }
        }
        stage ('Create AWS infrastructure'){
            steps {
              sh script: '''
                    chdir Deploy_AWS_EC2_PostgerSQL/Terraform
                    terraform init -reconfigure
                    terraform apply --auto-approve
              ''' 
            }
        }  
        stage ('Fix error / Preconfigure Project'){
           steps {
                sh "chmod u+x Deploy_AWS_EC2_PostgerSQL/Ansible/app/fix"
                sh "./Deploy_AWS_EC2_PostgerSQL/Ansible/app/fix"
                sh "find . -type f -name 'pom.xml' -exec sed -i 's/db_name_template/$DB_NAME/g' {} +"
                sh "find . -type f -name 'pom.xml' -exec sed -i 's/db_user_template/$DB_USER/g' {} +"
                sh "find . -type f -name 'pom.xml' -exec sed -i 's/db_password_template/$DB_PASSWORD/g' {} +"
                sh "find ./Deploy_AWS_EC2_PostgerSQL/Ansible/ -type f -name 'configDbServer.yml' -exec sed -i 's/db_name_template/$DB_NAME/g' {} +"
                sh "find ./Deploy_AWS_EC2_PostgerSQL/Ansible/ -type f -name 'configDbServer.yml' -exec sed -i 's/db_user_template/$DB_USER/g' {} +"
                sh "find ./Deploy_AWS_EC2_PostgerSQL/Ansible/ -type f -name 'configDbServer.yml' -exec sed -i 's/db_password_template/$DB_PASSWORD/g' {} +"                   
            }
        }        
        stage ('Config AWS infrastructure'){
            steps {
                sh "rm -f Deploy_AWS_EC2_PostgerSQL/config/ATC.pem"
                withCredentials([file(credentialsId: 'SSH_APP_KEY', variable: 'appsshkey')]) {
                    sh "cp \$appsshkey Deploy_AWS_EC2_PostgerSQL/config/"
                }   
                sh "ansible --version"
                sh script: '''
                    chdir Deploy_AWS_EC2_PostgerSQL/Ansible
                    ansible-playbook configAppServer.yml
                    ansible-playbook configDbServer.yml
                    
                '''                 
                sh "rm -f Deploy_AWS_EC2_PostgerSQL/config/ATC.pem"
            }
        }    
        stage('Validate') {
            steps {
                sh "mvn validate"
            }
        }
        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }          
        //stage('Test Project') {
        //    steps {
        //        sh "mvn test"
        //    }
        //}          
        stage('Build') {
           steps {
                sh "mvn package -Dmaven.test.skip=true"
            }
        }
        stage('Deploy') {
            steps {
                sh "pwd"
                sh "[ ! -f target/petclinic.war ] || mv -f target/petclinic.war target/ROOT.war"
                sh "rm -f Deploy_AWS_EC2_PostgerSQL/config/ATC.pem"
                withCredentials([file(credentialsId: 'SSH_APP_KEY', variable: 'appsshkey')]) {
                    sh "cp \$appsshkey Deploy_AWS_EC2_PostgerSQL/config/"
                }   
                sh script: '''
                    chdir Deploy_AWS_EC2_PostgerSQL/Ansible
                    ansible-playbook deployApp.yml
                '''
                sh "rm -f Deploy_AWS_EC2_PostgerSQL/config/ATC.pem"                
            }
        }
    }
}

```

### 3. Build Application

![a5](img/a5.png)

### 4. Deployed App

![a6](img/a6.png)

### 5. Add GithHub Webhook for auto start build after git changes

Add WebHook for Repository Settings

![a8](img/a8.png)

Add Listener to Jenkins Pipeline

![a9](img/a9.png)

Build starts automatically after pushing to repository

![a7](img/a7.png)

![a7_0](img/a7_0.png)

### 6. Test Load of Docker/Jenkins EC2 instance 

![ai0](img/ai0.png)

