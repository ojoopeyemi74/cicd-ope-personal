pipeline{
    agent any
     
    // tools{
    //     maven 'maven3'
    // }

    stages{
    //     stage('clean and test: maven'){
    //         steps{
    //             sh 'mvn clean test'
    //         }
    //     }
    //     stage(' maven package'){
    //         steps{
    //             sh 'mvn package'
    //         }
    //     }
    //     stage('sonarqube analysis'){
    //         steps{
    //             withSonarQubeEnv(installationName: 'sonarqube-server', credentialsId: 'sonarqube-auth') {
    //                    sh 'mvn sonar:sonar'
    //             }
    //         }
    //     }
    //     stage("Quality Gate") {
    //         steps {
    //           timeout(time: 1, unit: 'HOURS') {
    //             waitForQualityGate abortPipeline: true
    //           }
    //         }
    //     }
    //     stage("upload jar file to nexus"){
    //         steps{
    //           script{
    //            def readPomVersion = readMavenPom file: 'pom.xml'

    //            def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "springboot-snapshot" : "springboot-release"
               
    //            nexusArtifactUploader artifacts: 
    //            [
    //                 [artifactId: 'springboot', 
    //                     classifier: '', 
    //                     file: 'target/Uber.jar', 
    //                     type: 'jar']
    //             ], 
    //                 credentialsId: 'nexus-auth', 
    //                 groupId: 'com.example', 
    //                 nexusUrl: '18.130.78.129:8081', 
    //                 nexusVersion: 'nexus3', 
    //                 protocol: 'http', 
    //                 repository: nexusRepo, 
    //                 version: "${readPomVersion.version}"
    //         }
    //     }
    // }
    stage('build docker image'){
        steps{
            sh " docker image build -t $JOB_NAME:v1.$BUILD_ID ."
            sh " docker image tag $JOB_NAME:v1.$BUILD_ID opeyemiojo/$JOB_NAME:v1.$BUILD_ID"
            sh " docker image tag $JOB_NAME:v1.$BUILD_ID opeyemiojo/$JOB_NAME:latest"
        }
    }
    stage('push image to dockerhub'){
        steps{
            withCredentials([string(credentialsId: 'dockerhub-api-token', variable: 'DOCKERHUB_CRED')]) {
                 sh 'docker login -u opeyemiojo -p $DOCKERHUB_CRED'
                 sh 'docker image push opeyemiojo/$JOB_NAME:v1.$BUILD_ID'
                 sh 'docker image push opeyemiojo/$JOB_NAME:latest'
           }
        }
    }
}
}