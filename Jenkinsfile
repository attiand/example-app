#!groovy

node (){
   stage 'SCM'

   checkout scm

   stage 'Build and Test'
  
   docker.image('maven:3.3.3-jdk-8').inside {            
      sh 'mvn clean -Dmaven.test.failure.ignore -B verify'
   }   
      
   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
 }