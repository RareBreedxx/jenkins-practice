pipeline {
    agent any

    stages {

        stage('Critical Check') {
            steps {
                sh 'echo "Critical check passed"'
            }
        }

        stage('Non-Critical Check') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                    sh 'echo "Simulating failure" && exit 1'
                }
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Build continues even if non-critical failed"'
            }
        }
    }

    post {
        success {
            echo '✅ SUCCESS'
        }
        unstable {
            echo '⚠️ UNSTABLE (non-critical issue)'
        }
        failure {
            echo '❌ FAILURE'
        }
    }
}

