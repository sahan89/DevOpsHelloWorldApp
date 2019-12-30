pipeline {
   agent {
    	node {
        	label 'Java'
        	customWorkspace '/home/mchathur/Jenkins/'
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
                   "target": "libs-snapshot-local/war/"
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
                          def server = Artifactory.Artifactory-1
                          server.bypassProxy = true
                          def buildInfo = server.upload spec: uploadSpec
                          }
                
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

        /* stage ('Artifactory configuration') {
                   steps {
                       rtServer (
                           id: "Artifactory-1",
                           url: SERVER_URL,
                           credentialsId: CREDENTIALS
                       )

                       rtMavenDeployer (
                           id: "MAVEN_DEPLOYER",
                           serverId: "ARTIFACTORY_SERVER",
                           releaseRepo: "libs-release-local",
                           snapshotRepo: "libs-snapshot-local"
                       )

                       rtMavenResolver (
                           id: "MAVEN_RESOLVER",
                           serverId: "ARTIFACTORY_SERVER",
                           releaseRepo: "libs-release",
                           snapshotRepo: "libs-snapshot"
                       )
                   }
               }

               stage ('Exec Maven') {
                   steps {
                       rtMavenRun (
                           tool: MAVEN_TOOL, // Tool name from Jenkins configuration
                           pom: 'maven-example/pom.xml',
                           goals: 'clean install',
                           deployerId: "MAVEN_DEPLOYER",
                           resolverId: "MAVEN_RESOLVER"
                       )
                   }
               }

               stage ('Publish build info') {
                   steps {
                       rtPublishBuildInfo (
                           serverId: "ARTIFACTORY_SERVER"
                       )
                   }
               } */
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
