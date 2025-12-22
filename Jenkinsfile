pipeline {
    agent any

    stages {

        stage('Hello Jenkins') {
            steps {
                echo 'Jenkins is running this pipeline'
            }
        }

        stage('Workspace Check') {
            steps {
                sh 'pwd'
                sh 'ls -la'
            }
        }

        stage('Simple Shell Command') {
            steps {
                sh 'echo "I understand pipeline structure now"'
            }
        }

    }

    post {
        success {
            echo 'Basic pipeline succeeded ✅'
        }
        failure {
            echo 'Basic pipeline failed ❌'
        }
    }
}

