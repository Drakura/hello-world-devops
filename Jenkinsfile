pipeline {
    agent any
    
    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        IMAGE_NAME = 'hello-world-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        CONTAINER_NAME = 'hello-world-application'
        CONTAINER_PORT = '80'
        APPLICATION_PORT = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh '''
                    git --version
                    docker version
                    terraform version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build \
                    -t ${IMAGE_NAME}:${IMAGE_TAG} \
                    -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Terraform Format') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check'
                }
            }
        }

        stage('Terraform Initialize') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform plan -input=false \
                        -out=tfplan \
                        -var="image_name=${IMAGE_NAME}:${IMAGE_TAG}" \
                        -var="container_name=${CONTAINER_NAME}" \
                        -var="app_port=${APPLICATION_PORT}" \
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    sleep 10
                    curl -f http://localhost:${APPLICATION_PORT}
                '''
            }
        }
    }
}