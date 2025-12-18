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
                sh '''
                    mkdir -p logs
                    chmod 777 logs
                    docker run --rm -v "$WORKSPACE/logs:/logs" jenkins-system-check
                '''
            }
        }

        stage('Use Jenkins Secret') {
            steps {
                withCredentials([string(credentialsId: 'demo-secret', variable: 'MY_SECRET')]) {
                    sh '''
                        echo "The secret exists (but value is hidden)"
                        echo "Secret length: ${#MY_SECRET}"
                    '''
                }
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'logs/system_check.log', fingerprint: true
            }
        }

    }

    post {
        always {
            sh 'docker image prune -f'
        }
        success {
            echo 'Pipeline succeeded ✅'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
    }
}

