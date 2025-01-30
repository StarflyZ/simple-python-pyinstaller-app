pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    environment {
        VENV_DIR = "venv"
    }
    stages {
        stage('Setup') {
            steps {
                sh '''
                    apt-get update
                    apt-get install -y python3 python3-pip python3-venv
                    python3 -m venv ${VENV_DIR}
                    source ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install pytest --break-system-packages
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                    source ${VENV_DIR}/bin/activate
                    python -m py_compile sources/add2vals.py sources/calc.py
                '''
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Test') {
            steps {
                sh '''
                    source ${VENV_DIR}/bin/activate
                    pytest --junit-xml test-reports/results.xml sources/test_calc.py
                '''
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') {
            steps {
                sh '''
                    source ${VENV_DIR}/bin/activate
                    pyinstaller --onefile sources/add2vals.py
                '''
            }
            post {
                success {
                    archiveArtifacts 'dist/add2vals'
                }
            }
        }
    }
}
