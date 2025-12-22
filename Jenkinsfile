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
                    docker run --rm \
                      -v "$WORKSPACE/logs:/logs" \
                      jenkins-system-check
                '''
            }
        }

        stage('Verify Logs') {
            steps {
                sh 'ls -l logs'
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'logs/*', fingerprint: true
            }
        }

    }

    post {
        success {
            echo 'Container ran successfully and logs archived ✅'
        }
        failure {
            echo 'Container run failed ❌'
        }
        always {
            sh 'docker image prune -f'
        }
    }
}

