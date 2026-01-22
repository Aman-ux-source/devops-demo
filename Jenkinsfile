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
                // Apply Kubernetes manifests
                sh 'kubectl apply -f k8s/'
                
                // Optional: rollout status to ensure pods are running
                sh 'kubectl rollout status deployment/devops-demo -n default'
            }
        }
    }
    
    post {
        success {
            echo "Docker image built, pushed, and deployed successfully! 🚀"
        }
        failure {
            echo "Pipeline failed. Check logs! ❌"
        }
    }
}
