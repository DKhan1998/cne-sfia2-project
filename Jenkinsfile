pipeline{
        agent any
        environment {
            app_version = 'v2'
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
                    sh "sudo -E DATABASE_URI=${DATABASE_URI} MYSQL_ROOT_PASSWORD=${SECRET_KEY} MYSQL_DATABASE=database SECRET_KEY=${SECRET_KEY}"
                    sh "docker-compose pull && docker-compose up -d --remove-orphans"
                    sh "docker-compose logs"
                }
            }
        }
}