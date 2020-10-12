pipeline{
    agent any
    environment {
        app_version = 'v3'
        rollback = 'false'
    }
    stages{
//         stage('Build Containers'){
//             steps{
//                 script{
//                     if (env.rollback == 'false'){
//                           withCredentials([file(credentialsId: 'Private-key', variable: 'key')]){
//                             load "Ansible/.envvars/tf_db.groovy"
//                             load "Ansible/.envvars/tf_ansible.groovy"
//                             sh """
//                                ssh -tt -o "StrictHostKeyChecking=no" -i '${key}' ${env.testvm_user} << EOF
//
//                                 git clone https://github.com/DKhan1998/cne-sfia2-project.git
//                                 cd cne-sfia2-project
//
//                                 # Export variables to build project
//                                 export MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD}
//                                 export DB_PASSWORD=${env.DB_PASSWORD}
//                                 export TEST_DATABASE_URI=${env.TEST_DATABASE_URI}
//                                 export DATABASE_URI=${env.DATABASE_URI}
//                                 export SECRET_KEY=${env.SECRET_KEY}
//
//                                 # build project using docker-compose and environment variables
//                                 sudo -E MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD} DB_PASSWORD=${env.DB_PASSWORD} TEST_DATABASE_URI=${env.TEST_DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker-compose build
//
//                                 docker-compose push
//
//                                 exit
//
//                                 >> EOF
//                              """
//                          }
//                     }
//                 }
//             }
//         }
        stage('Build Containers'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        sh 'docker logout'
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                            load "Ansible/.envvars/tf_db.groovy"
                            load "Ansible/.envvars/tf_ansible.groovy"
                            sh """

                                # Export variables to build project
                                export MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD}
                                export DB_PASSWORD=${env.DB_PASSWORD}
                                export TEST_DATABASE_URI=${env.TEST_DATABASE_URI}
                                export DATABASE_URI=${env.DATABASE_URI}
                                export SECRET_KEY=${env.SECRET_KEY}

                                # build project using docker-compose and environment variables
                                sudo -E MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD} DB_PASSWORD=${env.DB_PASSWORD} DATABASE_URI=${env.DATABASE_URI} TEST_DATABASE_URI=${env.TEST_DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker-compose build

                                docker logout

                             """
                            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                                 sh """

                                    sudo -E MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD} DB_PASSWORD=${env.DB_PASSWORD} DATABASE_URI=${env.DATABASE_URI} TEST_DATABASE_URI=${env.TEST_DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker-compose push

                                 """
                            }
                        }
                    }
                }
            }
        }
        stage('SSH Connect | Run | Test application in testing-vm'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                            withCredentials([file(credentialsId: 'Private-key', variable: 'key')]){
                                load "./Ansible/.envvars/tf_ansible.groovy"
                                load "./Ansible/.envvars/tf_db.groovy"
                                sh """
                                    # SSH into testing-vm
                                    ssh -tt -o "StrictHostKeyChecking=no" -i '$key' ${env.jenkins_user} << EOF

                                    sudo -E MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD} DB_PASSWORD=${env.DB_PASSWORD} DATABASE_URI=${env.DATABASE_URI} TEST_DATABASE_URI=${env.TEST_DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker-compose pull && docker-compose up -d

                                    exit

                                    >> EOF
                                 """
                            }
                        }
                    }
                }
            }
        }
        stage('Testing'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        withCredentials([file(credentialsId: 'Private-key', variable: 'key')]){
                        load "./Ansible/.envvars/tf_ansible.groovy"
                        load "./Ansible/.envvars/tf_db.groovy"
                        sh """
                            # SSH into testing-vm
                            ssh -tt -o "StrictHostKeyChecking=no" -i '${key}' ${env.testvm_user} << EOF

                            # Export variables to build project
                            export MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD}
                            export DB_PASSWORD=${env.DB_PASSWORD}
                            export TEST_DATABASE_URI=${env.TEST_DATABASE_URI}
                            export DATABASE_URI=${env.DATABASE_URI}
                            export SECRET_KEY=${env.SECRET_KEY}

                            sudo -E TEST_DATABASE_URI=${env.DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker exec front pytest  --cov-report term --cov=application
                            sudo -E TEST_DATABASE_URI=${env.TEST_DATABASE_URI} SECRET_KEY=${env.SECRET_KEY} docker exec back pytest  --cov-report term --cov=application

                            exit

                            >> EOF
                        """
                        }
                    }
                }
            }
        }
    }
}
