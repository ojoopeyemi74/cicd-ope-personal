pipeline{
    agent any


    stages{
        stage('clean and test: maven'){
            steps{
                sh 'mvn clean test'
            }
        }
    }
}