pipeline {
    agent any

    environment {
        KEY_PATH = '/var/lib/jenkins/devopskey.pem'
    }

    stages {

        stage('checkout code') {
            steps {
                git branch: 'main', url: 'https://github.com/jewleprince-course/tf-jenk-ans-game.git'
            }
        }

        stage('terraform init') {
            steps {
                dir(terraform) {
                    sh 'terraform init'
                }
            }
        }

        stage('terraform apply') {
            steps {
                dir(terraform) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('wait for ec2') {
            steps {
                sh 'sleep 120'
            }
        }

        stage('Get ec2 public ip') {
            steps {
                script {
                    env.SERVER_IP = sh (
                        script: 'terraform output -raw game_server_public_ip',
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('run playbook') {
            steps {
                dir('ansible') {
                    sh """
                    echo "[web]" >> inventory.ini
                    echo "${SERVER_IP}" >> inventory.ini
                    ansible-playbook -i inventory.ini playbook/site.yml -u ubuntu --private-key ${KEY_PATH}
                    """
                }
            }
        }

    }

    post {
        success {
            echo "pipeline success"
        }
        failure {
            echo "pipeline failed. View logs"
        }
    }
}