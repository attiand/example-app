#!groovy

node (){
  stage('scm') {
    def co = checkout subPath: 'repos', scm
    echo "checkout info: " + co
  }

  stage('Build and Test') {
    docker.image('maven:3.3.3-jdk-8').inside {
      sh 'mvn clean --file repos/pom.xml -Dmaven.test.failure.ignore -B verify'
    }

    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
  }
}
