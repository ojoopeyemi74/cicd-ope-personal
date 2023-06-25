pipeline {
    agent any

    parameters{
        choice(name: 'action',  choices: 'create\ndestroy\ndestroycluster', description: 'create or destroy cluster')
        string(name: 'cluster', defaultValue: 'eksdemo1', description: 'eks cluster name')
        string(name: 'region', defaultValue: 'eu-west-2', description: 'eks cluster region')
    }
    environment{

        ACCESS_KEY = credentials("aws_access_key_id")
        SECRET_KEY = credentials("aws_secret_key")

    }

    stages {
        stage("Clean and Test") {
            steps {
                sh 'mvn clean test'
            }
        }

        stage("Maven Package") {
            steps {
                sh 'mvn package'
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube-server', credentialsId: 'sonarqube-token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage("Upload jar file to nexus"){
            steps{
                script{

                    def readPomVersion = readMavenPom file: 'pom.xml'

                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                    
                    nexusArtifactUploader artifacts:
                     [
                        [
                            artifactId: 'springboot', 
                            classifier: '', 
                            file: 'target/Uber.jar', 
                            type: 'jar'
                            ]
                        ], 
                            credentialsId: 'nexus-auth', 
                            groupId: 'com.example', 
                            nexusUrl: '3.8.29.196:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: nexusRepo, 
                            version: "${readPomVersion.version}"
                }
            }
        }
        stage('docker image build'){
            steps{
                script{
                    sh "docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID opeyemiojo/$JOB_NAME:v1.$BUILD_ID "
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID opeyemiojo/$JOB_NAME:latest"
                }
            }
        }
        stage('push image to dockerhub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-cred', variable: 'DOCKERHUB_CREDENTIALS')]){
                       sh 'docker login -u opeyemiojo -p ${DOCKERHUB_CREDENTIALS}'
                       sh 'docker image push opeyemiojo/$JOB_NAME:v1.$BUILD_ID'
                       sh 'docker image push opeyemiojo/$JOB_NAME:latest'
                   }
                }
            }
        }
        stage('EKS connect'){
            steps{
                
                sh """
                aws configure set aws_access_key_id "$ACCESS_KEY"
                aws configure set aws_secret_access_key "$SECRET_KEY"
                aws configure set region ""
                aws eks --region ${params.region} update-kubeconfig --name ${params.cluster}

                """

            }
        }
        stage('eks deployment'){
            when { expression {params.action == 'create'}}
            steps{
                script{
                    def apply = false
                    try{
                        input message: 'please confirm the apply to initiate the deployment', ok: 'Ready to apply the config'
                        apply = true
                    }
                    catch(err){
                        apply = false
                        CurrentBuild.result= 'UNSTABLE'
                    }
                    if(apply){
                        
                        sh 'kubectl apply -f .'
                    }
                }
            }
        }
       
}
}