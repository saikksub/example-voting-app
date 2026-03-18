pipeline {
    agent {
        label 'Jenkins-agent'
    }

    tools {
        // Ensure these match your "Manage Jenkins > Tools" names exactly
        jdk 'java17'
        maven 'maven3'
    }

    stages {
        stage('Checkout from SCM') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', 
                    credentialsId: 'github', 
                    url: 'https://github.com/sandeepaksm/example-voting-app.git'
                
                // This command helps us debug by showing the file structure
                sh 'ls -F'
            }
        }

        stage('Build Maven Application') {
            steps {
                script {
                    // We check if the 'worker' directory exists before entering
                    if (fileExists('worker/pom.xml')) {
                        dir('worker') {
                            sh 'mvn clean install -DskipTests'
                        }
                    } else {
                        error "Could not find pom.xml in the worker directory. Check the file structure in the Checkout stage log."
                    }
                }
            }
        }

        stage('Maven Test') {
            steps {
                dir('worker') {
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and Test completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs above.'
        }
        cleanup {
            echo 'Cleaning up workspace for the next run...'
            cleanWs()
        }
    }
}
