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
//                     sh "source ~/.aws/credentials"
//                     withCredentials([file('AWS_EU_Key.pem', 'aws-development-credentials')]){
//                        export aws-development-credentials=${AWS_EU_Key}
//                        chmod 400 AWS_EU_Key.pem
//                        ssh -i '${aws-development-credentials}' ubuntu@ec2-35-178-187-65.eu-west-2.compute.amazonaws.com
                        sh '''
                        docker-compose pull
                        export DATABASE_URI=${DATABASE_URI}
                        export MYSQL_ROOT_PASSWORD=${SECRET_KEY}
                        export MYSQL_DATABASE=database
                        export SECRET_KEY=${SECRET_KEY}"
                        docker-compose up -d --remove-orphans
                        docker-compose logs
                        '''
                    }
                }
            }
        }
    }
}