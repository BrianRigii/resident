pipeline {
   agent {
    docker {
      image 'cirrusci/flutter:stable'
    }
  }

  options {
    timestamps()
    timeout(time: 30, unit: 'MINUTES')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Flutter build APK') {
      steps {
        sh '''
          flutter --version
          flutter pub get
          flutter build apk --debug
        '''
      }
    }
  }

  post {
    success {
      archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
    }
    always {
      cleanWs()
    }
  }
}
