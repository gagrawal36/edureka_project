# project_edureka

AppleBiteCo. is using Cloud for one of their products. The project uses modular components, multiple frameworks and want the components to be developed by different teams or by 3rd-party vendors. The company’s goal is to deliver the product updates frequently to production with High quality & Reliability. They also want to accelerate software delivery speed, quality and reduce feedback time between developers and testers. As development progressed, they are facing multiple problems, because of various technologies involved in the project. Following are the problems:•Building Complex builds is difficult•Incremental builds are difficult to manage, and deployTo solve these problems, they need to implement Continuous Integration & Continuous Deployment with DevOps using following tools: Git–For version control for tracking changes in the code filesJenkins–For continuous integration and continuous deploymentDocker–For deploying containerized applicationsAnsible-Configuration management toolsThis project will be about how to do deploy code to dev/stage/prod etc, just on a click of button. Link for the sample PHP application: https://github.com/edureka-devops/projCert.git

Business challenge/requirement:

As soon as the developer pushes the updated code on the GIT master branch, a new test server should be provisioned with all the required software. Post this, the code should be containerized and deployed on the test server. The deployment should then be builtand pushed to the prod server.All this should happen automatically and should be triggered from a push to the GitHub master branch.  

Edureka Project
Problem statement 1
1. Creating Jenkins master ec2 instance
 

2. Login using SSH, to install jenksins pre-requesite: 
# To install Java:
sudo apt update
sudo apt install openjdk-11-jre
# To install Jenkins:
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \ /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \ https://pkg.jenkins.io/debian binary/ | sudo tee \  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
systemctl status jenkins
sudo usermod -s /bin/bash Jenkins

 
3. Open Jenkins dashboard
Using public ip and port 8080, visit dashboard.
 
Save Jenkins password using above path and save for later.
Install suggested plugins.

 

4. Use the Master VM for Jenkins, Ansible, GIT etc.

#Ansible installation:
sudo apt-get install -f
sudo apt-get install software-propeties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

ssh-keygen -t rsa
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh localhost
sudo vi /etc/ansible/hosts

#Docker installation:
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker $USER
 (After making this change, log out and log back in for the group changes to take effect.)
docker –version

#Command to stop/kill containers:
docker kill $(docker container ls -q)
docker rm php-container
docker exec -it php-container /bin/bash

5. Install python, openssh-server and git on the slave node manually.
python3 -V
sudo apt install openssh-server
ssh -V



6. Create Dockerfile, Jenkinsfile and docker-installtion.yml (ansible file) and add to the repository in github

 
 
 
 
 
 

 
 









7. Configuration on Jenkins slave
#Create jenkins directory and give permission
sudo mkdir jenkins
sudo chmod 777 -R jenkins/

#Go to jenkins dashboard -> manage jenkins -> add node
 

# Jenkins slave is successfully connected with jenkins master
 
8. Let’s check our pipeline is working or not with simple “Hello World”.
 
9. Now the pipeline is working, let’s configure ansible sudo vi /etc/ansible/hosts to install docker on jenkins-slave machine
 
10.Lets create pipeline project
 

 
 

11.Click on build now

 
 
On public ip address and port 8000 of jenkins-slave machine we can visit our php website.

 

Github link : https://github.com/rohitchavan2/project_edureka.git



Thank you !!!
