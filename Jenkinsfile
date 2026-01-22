pipeline {
    agent any

    stages {

        stage('Clone') {
            steps {
                git 'https://github.com/Aman-ux-source/devops-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t amanuxsource/devops-demo:latest .'
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
                    sh 'docker push amanuxsource/devops-demo:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f devops-demo-deployment.yaml'
                sh 'kubectl apply -f service.yaml'
                sh 'kubectl rollout status deployment/devops-demo-website'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline Success'
        }
        failure {
            echo '❌ Pipeline Failed'
        }
    }
}
