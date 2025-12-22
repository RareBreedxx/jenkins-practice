pipeline {
    agent any

    stages {

        stage('Checkout Info') {
            steps {
                echo 'Starting Docker build pipeline'
                sh 'docker --version'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t jenkins-system-check .'
            }
        }

        stage('List Docker Images') {
            steps {
                sh 'docker images | head -10'
            }
        }

    }

    post {
        success {
            echo 'Docker build pipeline succeeded ✅'
        }
        failure {
            echo 'Docker build pipeline failed ❌'
        }
    }
}

