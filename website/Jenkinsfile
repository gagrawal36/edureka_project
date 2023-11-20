pipeline {
    agent any

    stages {
        stage('Install and configure Puppet agent on slave node') {
            steps {
                script {
                    // Replace 'your-slave-node' with the actual name or IP address of your slave node
                    def slaveNode = '172.31.1.182'

                    // Install Puppet agent on the slave node
                    sh "ssh ${slaveNode} 'curl -O https://apt.puppetlabs.com/puppet6-release-bionic.deb'"
                    sh "ssh ${slaveNode} 'sudo dpkg -i puppet6-release-bionic.deb'"
                    sh "ssh ${slaveNode} 'sudo apt-get update'"
                    sh "ssh ${slaveNode} 'sudo apt-get install -y puppet-agent'"

                    // Configure Puppet agent on the slave node
                    sh "ssh ${slaveNode} 'sudo /opt/puppetlabs/bin/puppet config set server your-puppet-server'"
                    sh "ssh ${slaveNode} 'sudo /opt/puppetlabs/bin/puppet agent --enable'"
                }
            }
        }

        stage('Push Ansible configuration for Docker installation on test server') {
            steps {
                script {
                    // Replace 'your-test-server' with the actual name or IP address of your test server
                    def testServer = '172.31.1.182'

                    // Create the /home/php-web-app directory on the test server
                    sh "ssh ${testServer} 'mkdir -p /home/php-web-app'"

                    // Copy Ansible playbook to the test server
                    sh "scp /home/php-web-app/docker-installation.yml ${testServer}:/home/php-web-app/docker-installation.yml"

                    // Run Ansible playbook on the test server
                    sh "ssh ${testServer} 'ansible-playbook /home/php-web-app/docker-installation.yml'"
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
                        sh "ssh 172.31.1.182 'docker stop php-container && docker rm php-container'"
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
                      to: "rohit.chavan060898@gmail.com",
                      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        }

        failure {
            // Send email on failure
            emailext subject: "Job Failed: ${currentBuild.fullDisplayName}",
                      body: "The build of ${currentBuild.fullDisplayName} failed.",
                      to: "rohit.chavan060898@gmail.com",
                      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        }
    }
}
