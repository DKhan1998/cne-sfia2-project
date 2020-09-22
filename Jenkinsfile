pipeline{
        agent any
        stages{
            stage('Build Image'){
                steps{
                    sh "sudo docker build -t cne-sfia2-project ."
                }
            }
            stage('Clean'){
                steps{
                    sh label: '', script: '''if [ "$(sudo docker ps -aq -f name=cne-sfia2-project)" ]; then
                        sudo docker rm -f cne-sfia2-project
                    fi'''
                    }
                }
            stage('Run Container'){
                steps{
                    sh "sudo docker run -d --name cne-sfia2-project -p 80:80 cne-sfia2-project"
                }
            }
        }
}
