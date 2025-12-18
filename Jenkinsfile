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
		sh '''
		mkdir -p logs
		chmod 777 logs

		docker run --rm \
		 -v $PWD//logs:/logs \
		 jenkins-system-check
               '''
            }
        }

        stage('Archive Logs') {
            steps {
                archiveArtifacts artifacts: 'log/system_check.log', fingerprint: true
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

