#!groovy


pipeline {
    agent{
        label 'node'
    }
 stages{
    stage('Checkout'){
          steps{
            checkout scm
            }
       }

    stage('Docker Build'){
        steps{
         sh 'docker build . -t node-app:latest'
         }
       }


    stage('ECR Login'){
        steps{
        //  sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 427134667329.dkr.ecr.us-east-1.amazonaws.com'
         sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 427134667329.dkr.ecr.us-east-1.amazonaws.com'
         }
       }

       
    stage('Docker Tag'){
        steps{

         sh 'docker tag node-app:latest 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest'
         }
       }

    stage('Docker Push'){
        steps{
         sh 'docker push 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest'
         }
       }


    
}

agent{
        label 'app_node'
    }
stages{
    stage('Checkout'){
          steps{
            checkout scm
            }
    }
    stage('ECR Login'){
        steps{
        //  sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 427134667329.dkr.ecr.us-east-1.amazonaws.com'
         sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 427134667329.dkr.ecr.us-east-1.amazonaws.com'
         }
       }

    stage('Docker Deploy'){
        steps{
         sh '''
            if docker image ls | grep 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app
            then
                if docker ps | grep 026-node-app
                then
                    docker stop 026-node-app
                    docker rm 026-node-app
                    docker rmi 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker pull 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker run --name 026-node-app -p 8080:8081 -d 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                elif docker ps -a | grep 026-node-app
                then
                    docker rm 026-node-app
                    docker rmi 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker pull 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker run --name 026-node-app -p 8080:8081 -d 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                else
                    docker rmi 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker pull 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                    docker run --name 026-node-app -p 8080:8081 -d 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                fi
            else
                docker pull 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
                docker run --name 026-node-app -p 8080:8081 -d 427134667329.dkr.ecr.us-east-1.amazonaws.com/026-node-app:latest
            fi
        '''
         }
       }  
       }       
}
