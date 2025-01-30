pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'python3 -m py_compile sources/add2vals.py sources/calc.py'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Test') { 
            steps {
        sh '''
            apt-get update
            apt-get install -y python3-pytest
        '''
        sh 'pytest --junit-xml test-reports/results.xml sources/test_calc.py'
    }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
    }
}
// test poll SCM