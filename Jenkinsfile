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
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl set image deployment/devops-demo-website \
                devops-demo-container=${IMAGE_NAME}:${IMAGE_TAG}
                """
                sh 'kubectl rollout status deployment/devops-demo-website'
            }
        }
    }

    post {
        success {
            echo '✅ Image built, pushed & deployed successfully'
        }
        failure {
            echo '❌ Pipeline Failed'
        }
    }
}
