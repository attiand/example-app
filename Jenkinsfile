#!groovy

node (){
   stage 'SCM'

   checkout scm

   stage 'Build and Test'
  
   withEnv(["PATH+MAVEN=${tool 'maven3'}/bin",
            "PATH+JAVA=${tool 'java1.8'}/bin",
            "JAVA_HOME=${tool 'java1.8'}"]) {
            
      sh 'mvn clean -Dmaven.test.failure.ignore --batch-modeRun verify'
   }   
      
   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
 }