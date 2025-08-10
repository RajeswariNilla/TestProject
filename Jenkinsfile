pipeline {
  agent any
  environment {
    WEB_HOST = 'WEB_EC2_PUBLIC_IP_OR_DNS'  // replace
    WEB_USER = 'deploy'
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'git@github.com:YOURUSER/sample-webapp.git', credentialsId: 'github-ssh-creds'
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
