pipeline {
    agent any

    environment {
        IMAGE_NAME = "amanuxsource/devops-demo"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Clone') {
            steps {
                git 'https://github.com/Aman-ux-source/devops-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                      docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                  # Create deployment if not exists
                  kubectl apply -f devops-demo-deployment.yaml
                  kubectl apply -f service.yaml

                  # Update image (main magic ✨)
                  kubectl set image deployment/devops-demo-website \
                    devops-demo-container=${IMAGE_NAME}:${IMAGE_TAG} || true

                  # Wait for rollout
                  kubectl rollout status deployment/devops-demo-website
                '''
            }
        }
    }

    post {
        success {
            echo '✅ CI/CD Pipeline completed successfully'
        }
        failure {
            echo '❌ CI/CD Pipeline failed'
        }
    }
}
