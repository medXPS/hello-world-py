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
                    // Set up Python virtual environment
                    sh 'python3 -m venv venv'
                    sh 'source venv/bin/activate'

                    // Install project dependencies (if any)
                    sh 'pip install -r hello-world-py/requirements.txt'

                    // Run the Python executable file (hello.py)
                    sh 'python hello-world-py/hello.py'
                }
            }
        }
    }
}
