pipeline{
    agent any
    environment {
        app_version = 'v1'
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
    //             stage('Test') {
    //                 steps {
    //                     script{
    //                         if (env.rollback == 'false'){
    //                             sh "pytest"
    //                             sh "pytest --cov cne-sfia2-project"
    //                         }
    //                     }
    //                 }
    //             }
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
    //             def remote = [:]
    //             remote.name = 'deploy-vm'
    //             remote.host = '3.11.13.180'
    //             remote.user = 'root'
    //             remote.password = 'password'
    //             remote.allowAnyHosts = true
        stage('Remote SSH'){
            steps{
                script{
                    docker.withRegistry('ubuntu@ec2-18-130-127-82.eu-west-2.compute.amazonaws.com', 'aws-development-credentials'){
                        sh "docker-compose pull"
                        sh "export DATABASE_URI=${DATABASE_URI}"
                        sh "export MYSQL_ROOT_PASSWORD=${SECRET_KEY}"
                        sh "export MYSQL_DATABASE=database"
                        sh "export SECRET_KEY=${SECRET_KEY}"
                        sh "docker-compose up -d --remove-orphans"
                        sh "docker-compose logs"
                    }
                }
            }
        }
    }
}