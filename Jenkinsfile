pipeline {
  agent {
    label 'flutter' // matches the agent label in Docker Compose
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

    stage('Flutter Build APK') {
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
