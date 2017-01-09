#!groovy

node (){
   stage 'SCM'

   load 'constant.groovy'

   checkout scm

   stage 'Build and Test'

   docker.image(MAVEN_BUILD_IMAGE).inside {
      sh 'mvn clean -Dmaven.test.failure.ignore -B verify'
   }

   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
 }
