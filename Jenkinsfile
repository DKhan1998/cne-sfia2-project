pipeline{
    agent any
    environment {
        app_version = 'v2'
        rollback = 'false'
    }
    stages{
        stage('SSH Connect'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        withCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key')]) {
                            sh '''
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-132-45-38.eu-west-2.compute.amazonaws.com
                            '''
                        }
                    }
                }
            }
        }
        stage('Install Packages'){
            steps{
                script{
                    if (env.rollback == 'false'){
                        sh '''

                        curl https://get.docker.com | sudo -n bash

                        sudo usermod -aG docker $(whoami)

                        exit
                        '''
                        ithCredentials([file(credentialsId: 'Authentication', variable: 'AWS_EU_Key')]) {
                            sh '''
                                ssh -tt -o "StrictHostKeyChecking=no" -i $AWS_EU_Key ubuntu@ec2-18-132-45-38.eu-west-2.compute.amazonaws.com

                                sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

                                sudo chmod +x /usr/local/bin/docker-compose

                                sudo usermod -aG docker jenkins
                            '''
                        }
                    }
                }
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
        stage('Remote SSH'){
            steps{
                script{
                    sh '''
                    export DATABASE_URI=${DATABASE_URI}
                    export MYSQL_ROOT_PASSWORD=${SECRET_KEY}
                    export MYSQL_DATABASE=database
                    export SECRET_KEY=${SECRET_KEY}
                    docker-compose up -d
                    docker-compose logs
                    '''
                }
            }
        }
    }
}