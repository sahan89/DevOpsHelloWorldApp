pipeline {
    agent any
    tools {
        maven 'M2_Home'
        jdk 'Java_Home'
    }

    environment {
        registry = "sahan89/DevOpsHelloWorldApp"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }

     stages {
         stage ('Initialize') {
            steps {
                echo "PATH = ${PATH}"
                echo "M2_HOME = ${M2_HOME}"
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

	 stage ('SonarQube Analysis Stage') {
         steps {
            withSonarQubeEnv('sonarqube-server'){
            sh 'mvn sonar:sonar'
            }
            echo "######### SonarQube Analysis Stage Done #########"
         }
     }

     stage ('Deploy Stage') {
         	steps {
         		sh 'cp /home/sahan/.jenkins/workspace/HelloWorldPipeline/target/DevOpsHelloWorldApp.war /opt/apache-tomcat-8/webapps/ '
                echo "######### Deploy Stage Done #########"
            }
      }

	 stage ('Build Docker Image Stage') {
            steps {
                script {
                        docker.build registry + ":$BUILD_NUMBER"
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
