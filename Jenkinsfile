pipeline {
  agent any
  environment {
    WEB_HOST = '23.20.30.30' 
    WEB_USER = 'deploy'
  }
  stages {
    stage('Checkout') {
      steps {
        withCredentials([string(credentialsId: 'github-pat', variable: 'GIT_TOKEN')]) {
          git branch: 'main', url: "https://${GIT_TOKEN}@github.com/RajeswariNilla/TestProject.git"
        }
      }
    }

    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
      post {
        success {
          archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
      }
    }

    stage('Deploy') {
      steps {
        sshagent (credentials: ['deploy-ssh']) {
          sh '''
            scp -o StrictHostKeyChecking=no target/*.war ${WEB_USER}@${WEB_HOST}:/opt/tomcat/webapps/
            ssh -o StrictHostKeyChecking=no ${WEB_USER}@${WEB_HOST} "sudo systemctl restart tomcat"
          '''
        }
      }
    }
  }
}

