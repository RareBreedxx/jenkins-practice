pipeline {
    agent any

    environment {
        DOCKER_PASS = credentials('dockerhub-password') // Replace with your Jenkins DockerHub credentials ID
    }

    stages {

        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/RareBreedxx/jenkins-practice', branch: 'main'
            }
        }

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
                    docker run --rm -v $PWD/logs:/logs jenkins-system-check
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u rarebreedxx --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    sh '''
                        docker tag jenkins-system-check rarebreedxx/jenkins-system-check:latest
                        docker push rarebreedxx/jenkins-system-check:latest
                    '''
                }
            }
        }

    } // End of stages

    post {
        always {
            sh 'docker image prune -f'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        unstable {
            echo 'Pipeline completed with some warnings (Docker push may have failed).'
        }
        failure {
            echo 'Pipeline failed completely.'
        }
    }
}

