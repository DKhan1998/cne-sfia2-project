pipeline{
    agent any
    environment {
        app_version = 'v2'
        rollback = 'false'
    }
    stages{
        stage('Build Image'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        image = docker.build("dkhan20/cne-sfia2-project")
                    }
                }
            }
        }
        stage('Tag & Push Image'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                            image.push("${env.app_version}")
                        }
                    }
                }
            }
        }
        stage('SSH Connect'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        withCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key'),
                                       string(credentialsId: 'TEST_DATABASE_URI', variable: 'uri'),
                                       string(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'pwd'),
                                       string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                            sh '''
                                # SSH into testing-vm
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-130-230-68.eu-west-2.compute.amazonaws.com << EOF

                                docker-compose pull

                                sudo -E MYSQL_ROOT_PASSWORD=$pwd DB_PASSWORD=$pwd DATABASE_URI=$uri SECRET_KEY=$key docker-compose up -d --build

                                exit

                                >> EOF
                             '''
                        }
                    }
                }
            }
        }
        stage('Testing'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        withPythonEnv('python3') {
                            sh '''

                            pytest frontend/tests/test_frontend.py

                            pytest backend/tests/test_backend.py

                            pytest --cov application

                            '''
                        }
                    }
                }
            }
        }
    }
}