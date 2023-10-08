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
   stage('Print helloworld'){
        steps{
         sh '''
         echo "hello"
         echo "world"
            '''
         }
       }

    
}

}
