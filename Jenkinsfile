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
    }
}