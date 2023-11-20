pipeline {
    agent {
        label 'env-test'
    }

    stages {
        stage('Install and Configure Puppet Agent') {
            steps {
                script {
                    // Install Puppet Agent
                    sh 'curl -O https://apt.puppetlabs.com/puppet6-release-bionic.deb'
                    sh 'sudo dpkg -i puppet6-release-bionic.deb'
                    sh 'sudo apt-get update'
                    sh 'sudo apt-get install -y puppet-agent'

                    // Configure Puppet Agent
                    sh 'echo "server = puppetmaster.example.com" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf'
                    sh 'sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true'
                }
            }
        }

        stage('Push Ansible configuration for Docker installation on test server') {
            steps {
                script {
                    // Replace 'your-test-server' with the actual name or IP address of your test server
                    def testServer = 'ubuntu@ip-172-31-1-182'

                    // Use withCredentials to handle SSH key
                    withCredentials([sshUserPrivateKey(credentialsId: 'your-ssh-credentials-id', keyFileVariable: 'SSH_KEY_FILE')]) {
                        // Create the /home/php-web-app directory on the test server
                        sh "ssh -i $SSH_KEY_FILE ${testServer} 'mkdir -p /home/php-web-app'"

                        // Copy Ansible playbook to the test server
                        sh "scp -i $SSH_KEY_FILE /home/php-web-app/docker-installation.yml ${testServer}:/home/php-web-app/docker-installation.yml"

                        // Run Ansible playbook on the test server
                        sh "ssh -i $SSH_KEY_FILE ${testServer} 'ansible-playbook /home/php-web-app/docker-installation.yml'"
                    }
                }
            }
        }

        stage('Build and deploy PHP Docker container') {
            steps {
                script {
                    // Replace 'https://github.com/rohitchavan2/project_edureka.git' with your Git repository URL
                    def gitRepo = 'https://github.com/rohitchavan2/project_edureka.git'

                    try {
                        // Clone the Git repository
                        sh "git clone ${gitRepo}"

                        // Move to the directory with PHP website source code and Dockerfile
                        sh "cd website"  // Adjust this line based on your directory structure

                        // Build the Docker image
                        sh "docker build -t php-web-app ."

                        // Run the Docker container on port 8000
                        sh "docker run -d --name php-container -p 8000:80 php-web-app"
                    } catch (Exception e) {
                        // Handle failure: Delete the running Docker container on the test server
                        echo "Job 3 failed. Deleting the running Docker container."
                        // Replace 'your-test-server' with the actual name or IP address of your test server
                        sh "ssh -i $SSH_KEY_FILE ubuntu@ip-172-31-1-182 'docker stop php-container && docker rm php-container'"
                        error "Job 3 failed."
                    }
                }
            }
        }
    }

   post {
    success {
        // Send email on success
        emailext subject: "Job Succeeded: ${currentBuild.fullDisplayName}",
                  body: "The build of ${currentBuild.fullDisplayName} succeeded.",
                  to: "rohit.chavan060898@gmail.com"
    }

    failure {
        // Send email on failure
        emailext subject: "Job Failed: ${currentBuild.fullDisplayName}",
                  body: "The build of ${currentBuild.fullDisplayName} failed.",
                  to: "rohit.chavan060898@gmail.com"
    }
}
