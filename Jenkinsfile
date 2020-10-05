pipeline{
    agent any
    environment {
        app_version = 'v2'
        rollback = 'false'
    }
    stages{
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

                                rm -rf cne-sfia2-project
                                git clone https://github.com/DKhan1998/cne-sfia2-project.git
                                cd cne-sfia2-project

                                export MYSQL_ROOT_PASSWORD=$pwd
                                export DB_PASSWORD=$pwd
                                export TEST_DATABASE_URI=$tUri
                                export DATABASE_URI=$uri
                                export SECRET_KEY=$key

                                # build project using docker-compose and environment variables
                                sudo -E MYSQL_ROOT_PASSWORD=$pwd DB_PASSWORD=$pwd TEST_DATABASE_URI=$tUri SECRET_KEY=$key docker-compose up -d --build

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
                        withCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key'),
                                       string(credentialsId: 'DATABASE_URI', variable: 'uri'),
                                       string(credentialsId: 'TEST_DATABASE_URI', variable: 'tUri'),
                                       string(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'pwd'),
                                       string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                            sh '''
                                # SSH into testing-vm
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-134-133-25.eu-west-2.compute.amazonaws.com << EOF

                                cd cne-sfia2-project

                                export MYSQL_ROOT_PASSWORD=$pwd
                                export DB_PASSWORD=$pwd
                                export TEST_DATABASE_URI=$tUri
                                export DATABASE_URI=$uri
                                export SECRET_KEY=$key

                                sudo -E TEST_DATABASE_URI=$uri SECRET_KEY=$pwd docker exec -it pytest  --cov-report=cne-sfi2-project

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
