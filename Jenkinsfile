pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

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
        always {
            sh 'docker image prune -f'
        }
        success {
            echo 'Pipeline completed successfully 🎉'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
    }
}

