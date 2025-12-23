pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Quality Checks (Parallel)') {
            parallel {

                stage('Lint Check') {
                    steps {
                        timeout(time: 1, unit: 'MINUTES') {
                            sh 'echo "Running lint check..."'
                        }
                    }
                }

                stage('Unit Tests') {
                    steps {
                        retry(2) {
                            timeout(time: 2, unit: 'MINUTES') {
                                sh 'echo "Running unit tests..."'
                            }
                        }
                    }
                }

                stage('Security Scan (Non-Critical)') {
                    steps {
                        sh 'echo "Security scan failed but continuing..." || true'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                retry(2) {
                    sh 'docker build -t jenkins-system-check .'
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run --rm jenkins-system-check'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully'
        }

        unstable {
            echo '⚠️ Pipeline unstable but not failed'
        }

        failure {
            echo '❌ Pipeline failed'
        }

        always {
            sh 'docker image prune -f || true'
        }
    }
}

