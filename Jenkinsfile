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
                sh 'maven package'
            }
        }
    }
}