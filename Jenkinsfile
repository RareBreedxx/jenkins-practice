pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t jenkins-system-check .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run --rm jenkins-system-check'
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'system_check.log', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully 🎉'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
    }
}

