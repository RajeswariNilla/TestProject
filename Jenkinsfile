pipeline {
    agent any
    environment {
        APP_DIR = '/var/www/html'       // Adjust this to your httpd web root folder
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                withCredentials([string(credentialsId: 'github-tok', variable: 'GIT_TOKEN')]) {
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
                // Copy the built WAR or files to the httpd directory
                sh '''
                    sudo cp target/*.war ${APP_DIR}/
                    # If your app needs to be exploded, you can unzip or copy files accordingly
                '''

                // Restart httpd service to load the new app
                sh 'sudo systemctl restart httpd'
            }
        }
    }
}
