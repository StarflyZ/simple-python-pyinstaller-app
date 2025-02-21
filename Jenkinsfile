pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:2-alpine'
                }
            }
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'qnib/pytest'
                }
            }
            steps {
                sh 'py.test --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sh './jenkins/scripts/deliver.sh'  // Menjalankan aplikasi
                echo 'Aplikasi berjalan selama 1 menit...'
                sh 'sleep 60'  // Menunggu 1 menit sebelum melanjutkan
                echo 'Waktu habis, aplikasi akan dihentikan...'
                sh './jenkins/scripts/kill.sh'  // Menghentikan aplikasi
            }
        }
    }
}
