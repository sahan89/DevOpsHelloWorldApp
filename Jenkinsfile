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
                git (credentialsId: 'git-credentials', url: 'https://github.com/sahan89/DevOpsHelloWorldApp.git', branch: 'master')
                echo pwd
                echo "######### Checkout Stage Done #########"
            }
        }

	stage ('Build Stage') {
	    steps {
		sh 'mvn clean install -DskipTests'
                echo "######### Build Stage Done #########"
            }
		}

	stage ('Testing Stage') {
            steps {
                echo "######### Testing Stage Done #########"
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
