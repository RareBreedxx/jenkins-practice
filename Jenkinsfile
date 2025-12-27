pipeline {
    agent any

    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t jenkins-demo .'
            }
        }

        stage('Run Image') {
            steps {
                sh 'docker run --rm jenkins-demo'
            }
        }
    }
}

