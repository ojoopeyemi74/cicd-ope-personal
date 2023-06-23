pipeline{
    agent any
     
    tools{
        maven 'maven3'
    }

    stages{
        stage('clean and test: maven'){
            steps{
                sh 'mvn clean test'
            }
        }
        stage(' maven package'){
            steps{
                sh 'mvn package'
            }
        }
        stage('sonarqube analysis'){
            steps{
                withSonarQubeEnv(installationName: 'sonarqube-server', credentialsId: 'sonarqube-auth') {
                       sh 'mvn sonar:sonar'
                }
            }
        }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        stage("upload jar file to nexus"){
            steps{
               nexusArtifactUploader artifacts: 
               [[artifactId: 'springboot', 
               classifier: '', 
               file: 'target/Uber.jar', 
               type: 'jar']], 
               credentialsId: 'nexus-auth', 
               groupId: 'com.example', 
               nexusUrl: '18.130.78.129:8081', 
               nexusVersion: 'nexus3', 
               protocol: 'http', 
               repository: 'maven-releases', 
               version: '3.0.0'
            }
        }
    }
}