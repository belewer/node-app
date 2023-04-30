
pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: node
            image: node:14-alpine
            command:
            - cat
            tty: true
          - name: docker
            image: docker:latest
            command:
            - cat
            tty: true
            volumeMounts:
             - mountPath: /var/run/docker.sock
               name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock    
        '''
    }
  }
  stages {
    // stage('Clone') {
    //   steps {
    //     container('node') {
    //       git branch: 'main', url: 'https://github.com/belewer/node-app.git'
    //     }
    //   }
    // }  
    stage('Build dependencies') {
      steps {
        container('node') {
          sh 'npm install'
        }
      }
    }
    stage('Build Image') {
      steps {
        container('docker') {
          sh 'docker build -t jovilon/node-app:v2 .'
        }
      }
    }
    stage('Publish Image') {
      steps {
        container('docker') {
            withCredentials([usernamePassword(credentialsId: 'github-jovi', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                sh 'docker login -u $USER -p $PASS'
                sh 'docker push jovilon/node-app:v2'
            }            

      }
    }
    }
  }
    post {
      always {
        container('docker') {
          sh 'docker logout'
        }
      }
    }
}