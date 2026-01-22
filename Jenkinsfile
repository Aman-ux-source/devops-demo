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
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'USER',
          passwordVariable: 'PASS'
        )]) {
          sh '''
          echo  | docker login -u ubuntu --password-stdin
          docker push <DOCKERHUB_USERNAME>/devops-demo:latest
          '''
        }
      }
    }
  }
}
