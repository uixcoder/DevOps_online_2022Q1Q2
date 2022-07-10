# PetClinic Project AWS Deployments

The project [**spring-framework-petclinic**](https://github.com/spring-petclinic/spring-framework-petclinic) was selected as sample project for AWS Deployment.

![d1](img/d1.png)

[My forked version of project](https://github.com/uixcoder/spring-framework-petclinic) has some small changes (related to default database selection) in **pom.xml** file as i done 2 variants of deployment.

## Main Stages on working with Deployments:

### 1. Manual deployment of PetClinic Project on Virtualbox VM (Ubuntu 18.04)
    
1. Gathering info about needed software  
Well works on soft:
    - Git 3.8.6
    - Open JDK 11
    - Maven 3.8.6
    - Tomcat 9.0.64
         

2. Manual testing App run with Built-in Database ([Test run app](img/0_1.png))  
**Problem:** Error on Bootstrap / jQuery versions  
**Solution:** change Bootstrap version 3.3.6 to 3.4.1 in all project files

3. Manual testing App run with MySQL Database (local Docker)  
Works normally...

4. Manual testing App run with PostgreSQL Database (local Docker)  
**Problem:** 8 Built-in Tests Fail, but application works.
**Solution:** Disable testing up to the app code fixing (app used too old variant of PostgreSQLl for testing). **Testing for PostgreSQL are disabled in deployment.**

### 2. Deployment variants

   1. Tomcat + PostgreSQL 
      - EC2 Instance (Ubuntu 18.04 + Open JDK 11 + Tomcat 9.0.64)
      - EC2 Instance (RHEL 8 + PostgreSQL 10.21)

   2. Tomcat + MySQL
      - EC2 Instance (Ubuntu 18.04 + Open JDK 11 + Tomcat 9.0.64)
      - RDS MySQL 8.0.28

### 3. Terraform scripts for creating infrastructure

   1. [Tomcat + PostrgreSQL](https://github.com/uixcoder/Deploy_AWS_EC2_PostgerSQL/tree/master/Terraform)
   2. [Tomcat + MySQL](https://github.com/uixcoder/Deploy_AWS_EC2_RDS_MySQL/tree/master/Terraform)

### 4. Ansible playbooks for configuring infrastructure

   1. [Tomcat + PostrgreSQL](https://github.com/uixcoder/Deploy_AWS_EC2_PostgerSQL/tree/master/Ansible)
   2. [Tomcat + MySQL](https://github.com/uixcoder/Deploy_AWS_EC2_RDS_MySQL/tree/master/Ansible)

### 5. Configure Jenkins EC2 Instance (Jenkins and agents as Docker container) with public DNS name

   1. [Configuration details](JenkinsConfig.md)
   2. [Update DNS (Route 53) record for EC2 Instance (Jenkins) on VM Startup](UpdateZoneForEC2.md)

### 6. Create Jenkins pipelines for deployments

   1. Tomcat + PostrgreSQL [pipeline codes](https://github.com/uixcoder/Deploy_AWS_EC2_PostgerSQL/tree/master/Jenkins) 
    - [Create and manage infrastrtucture](Deploy1Application.md)
    - [Destroy infrastructure](Destroy1Deployment.md)

   2. Tomcat + MySQL [pipeline codes](https://github.com/uixcoder/Deploy_AWS_EC2_RDS_MySQL/tree/master/Jenkins)
    - [Create and manage infrastrtucture](Deploy2Application.md)
    - [Destroy infrastructure](Destroy2Deployment.md)

### 7. Testing and fixing bugs

### 8. Writing runbooks

