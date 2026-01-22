pipeline {
    agent any

    environment {
        IMAGE_NAME = "amanuxsource/devops-demo"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Aman-ux-source/devops-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl apply -f devops-demo-deployment.yaml
                kubectl apply -f service.yaml
                kubectl rollout status deployment/devops-demo -n default
                """
