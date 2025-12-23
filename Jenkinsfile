pipeline {
    agent any

    environment {
        IMAGE_NAME = "rarebreedxx/jenkins-system-check"
    }

    stages {

        stage('Build Image') {
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

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login \
                          -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    docker tag jenkins-system-check ${IMAGE_NAME}:latest
                    docker push ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'logs/*', fingerprint: true
            }
        }
    }
	stage('Non-Critical check') {
	    steps {
		catchError(buildResult: 'SUCCESS', StageResult: 'FAILURE') {
		sh '''
		   echo "Running a non-critical check..."
		   exit 1
		  '''
	     }
	}
    }
    post {
        success {
            echo 'CI/CD pipeline completed successfully 🚀'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
        always {
            sh 'docker image prune -f'
        }
    }
}

