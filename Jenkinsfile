pipeline {
    agent any

    environment {
        IMAGE_NAME = "rarebreedxx/jenkins-system-check"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t $IMAGE_NAME:latest .
                '''
            }
        }

        stage('Run Container (Non-Critical Check)') {
            steps {
                sh '''
                  mkdir -p logs
                  docker run --rm -v "$WORKSPACE/logs:/logs" $IMAGE_NAME:latest || true
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh '''
                  docker push $IMAGE_NAME:latest
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'logs/**', fingerprint: true
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

