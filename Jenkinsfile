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
            agent {
                docker {
                    image 'docker:24.0.2' // Gunakan versi terbaru sesuai kebutuhan
                    args '--privileged -v /var/run/docker.sock:/var/run/docker.sock' // Akses Docker Host
                }
            }
            steps {
                script {
                    echo 'Starting Deployment...'
                    
                    // Build Docker Image untuk aplikasi
                    sh '''
                    docker build -t my_app_image .
                    '''

                    // Hentikan container jika sudah berjalan
                    sh '''
                    docker stop my_app_container || true
                    docker rm my_app_container || true
                    '''

                    // Jalankan container di port 8081 (agar tidak bentrok dengan Jenkins)
                    sh '''
                    docker run -d --name my_app_container -p 8081:80 my_app_image
                    '''
                }
            }
            post {
                success {
                    echo 'Deployment successful! App is running on port 8081'
                }
                failure {
                    echo 'Deployment failed!'
                }
            }
        }
    }
}
