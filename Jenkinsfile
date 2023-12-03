pipeline {
    agent any

    environment {
        registryName = "acr017h3w873rnwuqwuh/scraping-api"
        registryCredential = 'ACR'
        dockerImage = ''
        registryUrl = 'acr017h3w873rnwuqwuh.azurecr.io'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clean workspace before checking out the code
                    deleteDir()

                    // Checkout the code from the specified Git repository and branch
                    checkout([$class: 'GitSCM',
                              branches: [[name: 'main']],
                              doGenerateSubmoduleConfigurations: false,
                              extensions: [[$class: 'CleanBeforeCheckout'], [$class: 'RelativeTargetDirectory', relativeTargetDir: 'hello-world-py']],
                              submoduleCfg: [],
                              userRemoteConfigs: [[url: 'https://github.com/medXPS/hello-world-py.git']]])
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    dir('hello-world-py') {
                        sh 'python3 hello.py'
                    }
                }
            }
        }
        stage('Run SonarQube Analysis') {
    steps {
        script {
            dir('hello-world-py') {
                // Update 'SonarQubeServer' to the name you configured in Jenkins
                withSonarQubeEnv('jenkins-sonar') {
                    sh "${sonarQubeScannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}

        stage('Build Docker image') {
            steps {
                script {
                    dir('hello-world-py') {
                        // Assuming Dockerfile is present in the repository
                        dockerImage = docker.build(registryName, "-f Dockerfile .")
                    }
                }
            }
        }

        stage('Push Image to ACR ') {
            steps {
                script {
                    docker.withRegistry("http://${registryUrl}", registryCredential) {
                        dockerImage.push("latest")
                    }
                }
                slackSend message: 'New Artifact was Pushed to ACR Repo'
            }
        }
    }
}
