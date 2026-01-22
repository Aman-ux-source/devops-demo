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
                    // Login to Docker Hub non-interactively
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    
                    // Push image
                    sh 'docker push amanuxsource/devops-demo:latest'
                }
            }
        }
    }
    
    post {
        success {
            echo "Docker image built and pushed successfully! 🚀"
        }
        failure {
            echo "Pipeline failed. Check logs! ❌"
        }
    }
}
