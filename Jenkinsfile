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
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                            sh 'docker build -t dkhan20/cne-sfia2-project'
                        }
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
                    } master
                }
            }
        }
        stage('SSH Connect | Run | Test application in testing-vm'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        withCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key'),
                                       string(credentialsId: 'DATABASE_URI', variable: 'uri'),
                                       string(credentialsId: 'TEST_DATABASE_URI', variable: 'tUri'),
                                       string(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'pwd'),
                                       string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                            sh '''
                                # SSH into testing-vm
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-134-133-25.eu-west-2.compute.amazonaws.com << EOF

                                # Pull project from docker-hub
                                docker-compose pull cne-sfia2-project

                                # build project using docker-compose and environment variables
                                sudo -E MYSQL_ROOT_PASSWORD=$pwd DB_PASSWORD=$pwd TEST_DATABASE_URI=$uri SECRET_KEY=$key docker-compose up -d --build
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
                        withCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key'),
                                       string(credentialsId: 'TEST_DATABASE_URI', variable: 'uri'),
                                       string(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'pwd'),
                                       string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                            sh '''
                                # SSH into testing-vm
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-134-133-25.eu-west-2.compute.amazonaws.com << EOF

                                cd cne-sfia2-project

                                sudo -E DATABASE_URI=$uri SECRET_KEY=$pwd docker exec -it front pytest

                                sudo -E DATABASE_URI=$uri SECRET_KEY=$pwd docker exec -it front pytest

                                exit

                                >> EOF
                            '''
                        }
                    }
                }
            }
        }
    }
}