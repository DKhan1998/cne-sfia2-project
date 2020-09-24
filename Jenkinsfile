pipeline{
        agent any
        environment {
            app_version = 'v1'
            rollback = 'false'
        }
        stages{
            stage('Configure VM'){
                steps{
                    sh ""
                }
            }
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
            stage('Deploy App'){
                steps{
                    sh "docker-compose pull"
                    sh "export DATABASE_URI=${DATABASE_URI}"
                    sh "MYSQL_ROOT_PASSWORD=${SECRET_KEY}"
                    sh "MYSQL_DATABASE=database"
                    sh "SECRET_KEY=${SECRET_KEY}"
                    sh "docker-compose up -d --remove-orphans"
                    sh "docker-compose logs"
                }
            }
        }
}