#!groovy

node (){
   stage 'Build and Test'
   env.PATH = "${tool 'maven3'}/bin:${env.PATH}"
   checkout scm
   sh 'mvn clean -Dmaven.test.failure.ignore --batch-modeRun verify'
   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
 }