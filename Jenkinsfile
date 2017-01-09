#!groovy

node (){
   stage('SCM') {
   checkout scm
   checkout changelog: true,
   scm: [$class: 'GitSCM',
      extensions: [
           [$class: 'CleanBeforeCheckout'],
           [$class: 'hudson.plugins.git.extensions.impl.RelativeTargetDirectory', relativeTargetDir: 'repo'],
           [$class: 'BuildChooserSetting', buildChooser: [$class: 'GerritTriggerBuildChooser']]
       ],
      userRemoteConfigs: [
           [url: 'https://github.com/eplatti/my-app.git']
      ]]
   }

   load 'repo/constant.groovy'

   stage 'Build and Test'

   docker.image(MAVEN_BUILD_IMAGE).inside {
      sh 'mvn clean -Dmaven.test.failure.ignore -B verify'
   }

   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
 }
