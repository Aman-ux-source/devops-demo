pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/Aman-ux-source/devops-demo.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t amanuxsource/devops-demo:latest .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', 
                                usernameVariable: 'amanuxsource', 
                                passwordVariable: 'Amanpreet#8979')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push amanuxsource/devops-demo:latest'
                }
            }
        }
    }
}
