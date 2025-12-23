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

    stage('Non-Critical Check') {
        steps {
            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                sh '''
                    echo "Running a non-critical check..."
                    exit 1
                '''
            }
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
                docker tag jenkins-system-check rarebreedxx/jenkins-system-check:latest
                docker push rarebreedxx/jenkins-system-check:latest
            '''
        }
    }
}

