pipeline {
   agent {
    	node {
        	label 'Java'
        	customWorkspace '/home/ec2-user/Jenkins/'
   	 }
   }

    environment {
        registry = "sahan89/hello-world-app"
        registryCredential = 'dockerhub'
        dockerImage = ''
        def uploadSpec = """{
           "files": [
               {
               "pattern": "target/*.war",
                "target": "generic-local/sahan/DevOpsHelloWorldApp/war/"
               }
           ]
        }"""
    }

     stages {
         stage ('Initialize') {
            steps {
		        sh '''
                     echo "PATH = ${PATH}"
                     echo "M2_HOME = ${M2_HOME}"
		        '''
	        echo "######### Initialize Stage Done #########"
            }
        }

     stage ('Checkout Stage') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/sahan89/DevOpsHelloWorldApp.git']]])
		        echo "######### Checkout Stage Done #########"
            }
        }

	 stage ('Build Stage') {
	        steps {
		        sh 'mvn clean install -DskipTests'
                echo "######### Build Stage Done #########"
            }
		}

    stage ('Deploy Stage') {
         	steps {
                	sh 'mv target/DevOpsHelloWorldApp.war target/hello-world-app.${BUILD_NUMBER}.war'
                echo "######### Deploy Stage Done #########"
            }
    }

    stage('Upload Artifact') {
            steps {
                 script {
                          def server = Artifactory.server 'Artifactory-1'
                          def buildInfo = server.upload spec: uploadSpec
                  }     
            }
    }

	 stage ('Build Docker Image Stage') {
            steps {
                script {
                       dockerImage = docker.build registry + ":$BUILD_NUMBER"
                      }
                echo "######### Build Docker Image Stage #########"
		  }
       }

     stage('Deploy Docker Image Stage') {
             steps{
                script {
                   docker.withRegistry( '', registryCredential ) {
                   dockerImage.push()
                 }
               }
               echo "######### Deploy Docker Image Stage #########"
           }
       }
    }
}
