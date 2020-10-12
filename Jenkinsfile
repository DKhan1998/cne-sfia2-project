pipeline{
    agent any
    environment {
        app_version = 'v3'
        rollback = 'false'
    }
    stages{
        stage('Build Containers'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        sh '''
                            load ".envvars/tf_ansible.groovy"

                            # Export variables to build project
                            export MYSQL_ROOT_PASSWORD=$env.MYSQL_ROOT_PASSWORD
                            export DB_PASSWORD=$env.DB_PASSWORD
                            export TEST_DATABASE_URI=$env.TEST_DATABASE_URI
                            export DATABASE_URI=$env.DATABASE_URI
                            export SECRET_KEY=$env.SECRET_KEY

                            # build project using docker-compose and environment variables
                            sudo -E MYSQL_ROOT_PASSWORD=$env.MYSQL_ROOT_PASSWORD=$env.DB_PASSWORD TEST_DATABASE_URI=$env.TEST_DATABASE_URI SECRET_KEY=$env.SECRET_KEY docker-compose build

                            exit

                            >> EOF
                         '''
                    }
                }
            }
        }
        stage('SSH Connect | Run | Test application in testing-vm'){
            steps{
                script{
                    if (env.rollback == 'false'){
                            readProperties(file: "Ansible/roles/common/vars/tf_ansible_vars.yml").each {key, value -> env[key] = value }
                            sh '''
                                # SSH into testing-vm
                                ssh -tt -o "StrictHostKeyChecking=no" -i $env.tf_EC2_private_key $env.tf_jenkins_user << EOF

                                docker-compose pull nginx

                                docker-compose run -d

                                exit

                                >> EOF
                             '''
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
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key $ << EOF

                                cd cne-sfia2-project

                                export MYSQL_ROOT_PASSWORD=$pwd
                                export DB_PASSWORD=$pwd
                                export TEST_DATABASE_URI=$tUri
                                export DATABASE_URI=$uri
                                export SECRET_KEY=$key

                                sudo -E TEST_DATABASE_URI=$tUri SECRET_KEY=$pwd docker exec front pytest  --cov-report term --cov=application
                                sudo -E TEST_DATABASE_URI=$tUri SECRET_KEY=$pwd docker exec back pytest  --cov-report term --cov=application

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
