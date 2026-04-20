pipeline {
    agent { label 'Jenkins-Agent' } 

    environment {
        // Defining your repo URL as a variable to avoid "MissingProperty" errors
        REPO_URL = 'https://github.com/sandeepaksm/example-voting-app.git'
    }

    tools {
        // These MUST match the names in Manage Jenkins -> Tools exactly
        maven 'Maven3' 
        jdk 'jdk17'    
    }

    stages {
        stage('1. Workspace Cleanup') {
            steps {
                echo 'Cleaning up the build environment...'
                cleanWs() 
            }
        }

        stage('2. Checkout from SCM') {
            steps {
                echo "Fetching code from: ${REPO_URL}"
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('3. Unit Testing') {
            steps {
                echo 'Moving into worker directory and executing Maven tests...'
                // dir() is the secret sauce here—it moves the command into the subfolder
                dir('worker') {
                    sh 'mvn test'
                }
            }
        }

        stage('4. Build & Package') {
            steps {
                echo 'Compiling code and creating artifact...'
                dir('worker') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('5. Archive Artifacts') {
            steps {
                echo 'Saving the build results in Jenkins...'
                // This captures the JAR file created in the worker/target folder
                archiveArtifacts artifacts: 'worker/target/*.jar', allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: The application was built and packaged!'
        }
        failure {
            echo 'FAILURE: Check the Console Output for Maven or Directory errors.'
        }
    }
}
