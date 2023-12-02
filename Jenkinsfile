pipeline {
    agent any

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
                      sh 'python3 hello.py'
                }
            }
        }
    }
}
