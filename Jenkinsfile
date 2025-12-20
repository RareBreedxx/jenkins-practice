pipeline {
    agent any

    environment {
        IMAGE_NAME = "rarebreedxx/jenkins-system-check:latest"
    }

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

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    docker tag jenkins-system-check $IMAGE_NAME
                    docker push $IMAGE_NAME
                '''
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

