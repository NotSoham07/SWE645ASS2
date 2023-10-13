pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "soham0711/student-survey:${env.BUILD_ID}"
        KUBECONFIG_CREDENTIALS_ID = 'myKubeconfigID'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("$DOCKER_IMAGE")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DockerHubCredentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push $DOCKER_IMAGE"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "$KUBECONFIG_CREDENTIALS_ID", variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl config use-context swe645ass2

                        kubectl set image deployment/studentsurvey nginx=$DOCKER_IMAGE
                    '''
                }
            }
        }
    }
}