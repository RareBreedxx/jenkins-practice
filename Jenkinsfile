pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run System Check') {
            steps {
                sh 'chmod +x system_check.sh'
                sh './system_check.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t jenkins-system-check .'
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'system_check.log', fingerprint: true
            }
        }
    }
}

