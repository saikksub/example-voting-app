pipeline {
    agent { label 'Jenkins-Agent' } // Matches your hyphenated label

    environment {
        // We define the variable here so the echo command can find it
        REPO_URL = 'https://github.com/sandeepaksm/example-voting-app.git'
    }

    tools {
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
                // Now REPO_URL is defined, so this won't crash
                echo "Fetching code from: ${REPO_URL}"
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('3. Unit Testing') {
            steps {
                echo 'Executing Maven tests...'
                sh 'mvn test'
            }
        }

        stage('4. Build & Package') {
            steps {
                echo 'Compiling code and creating artifact...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('5. Archive Artifacts') {
            steps {
                echo 'Saving the build results in Jenkins...'
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            }
        }
    }

    post {
        failure {
            echo 'Build failed! Check the Console Output for Maven errors.'
        }
    }
}
