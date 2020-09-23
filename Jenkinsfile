pipeline{
        agent any
        environment {
            app_version = 'v2   '
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
//                             withPythonEnv('python') {
//                                 sh 'pip install pytest'
//                                 sh 'pytest test_frontend.py'
//                                 sh 'pytest test_backend.py'
//                             }
//                         }
//                     }
//                 }
//                 post {
//                    always {junit 'test-reports/*.xml'}
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
                    sh "docker-compose pull && docker-compose up -d"
                }
            }
        }
}