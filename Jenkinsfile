pipeline {
    agent {
        label 'Jenkins-agent'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build .NET Worker') {
            steps {
                dir('worker') {
                    echo 'Restoring dependencies...'
                    sh 'dotnet restore'
                    echo 'Building the project...'
                    sh 'dotnet build --configuration Release'
                }
            }
        }

        stage('Test') {
            steps {
                dir('worker') {
                    echo 'Running tests...'
                    // Note: This only runs if you have a test project defined
                    sh 'dotnet test --no-build --configuration Release'
                }
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: .NET Worker built successfully!'
        }
        failure {
            echo 'FAILURE: Check if .NET SDK is installed on the Agent.'
        }
        always {
            cleanWs()
        }
    }
}
