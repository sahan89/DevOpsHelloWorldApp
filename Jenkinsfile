pipeline {
    agent any
    tools {
        maven 'M2_Home'
        jdk 'Java_Home'
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

    stage ('Deploy Stage') {
    	        steps {
    		        sh 'cd /home/sahan/.jenkins/workspace/HelloWorldPipeline/target/'
    		        sh 'cp DevOpsHelloWorldApp.war /opt/apache-tomcat-8/webapps/'
                    echo "######### Deploy Stage Done #########"
                }
    		}

	 stage ('SonarQube Analysis Stage') {
         steps {
            withSonarQubeEnv('sonarqube-server'){
            sh 'mvn sonar:sonar'
            }
            echo "######### SonarQube Analysis Stage #########"
         }
     }

	 stage ('Build Docker Image Stage') {
            steps {
                //dir("/var/jenkins_home/gitClone/SampleDevOpsApplication") {
                //sh "pwd"
                //}
                //docker build -t sample_devops_app .
                echo "######### Deployment Stage Done #########"
		  }
       }
    }
}
