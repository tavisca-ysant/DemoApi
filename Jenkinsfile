pipeline {
    agent any
	
	parameters {		
			string(	name: 'GIT_SSH_PATH',
					defaultValue: "https://github.com/tavisca-ysant/DemoApi.git",
					description: '')

			string(name: 'DOCKER_FILE',
			       defaultValue: 'demoapi')
		    string(name: 'DOCKER_CONTAINER_NAME',
			       defaultValue: 'demoapi-container')
			string(name: 'USERNAME',
			       defaultValue: 'yatharthsant')
			string(name: 'PASSWORD',
			       defaultValue: '************')
			string(name: 'DOCKER_REPOSITORY',
			       defaultValue: 'test-repo')
			string(name: 'APPLICATION_PORT',
			       defaultValue: '65208')
		    string(name: 'DOCKER_CONTAINER_PORT',
			       defaultValue: '65208')
			string(name: 'APP_NAME',
			       defaultValue: 'DemoApi')
			string(name: 'DOCKER_HUB_CREDENTIALS_ID', defaultValue: 'docker-hub-credentials')
		    
    }
	environment{

	  OutputDirectory = "out"

	}
    stages {
        stage('Build') {
            steps {
				sh 'dotnet restore'
                sh 'dotnet build -p:Configuration=release -v:n'
				
            }
        }
		
        stage('Test') {
            steps {
                sh 'dotnet test' 
            }
        }
		stage('Publish') {
            steps {
                sh 'dotnet publish ${APP_NAME} -c Release -o ../publish' 
            }
        }

		
		
		stage('Deploy'){
		     
		     steps{
			    sh '''
				if(docker inspect -f '{{.State.Running}}' ${DOCKER_CONTAINER_NAME})
				then
					docker container rm -f ${DOCKER_CONTAINER_NAME}
				fi
			    '''
				
			    sh 'docker build -t ${DOCKER_FILE} --build-arg APPLICATION=${APP_NAME} .'
				sh 'docker run --name ${DOCKER_CONTAINER_NAME} -e HOSTED_APP = ${APP_NAME} -d -p ${APPLICATION_PORT}:${DOCKER_CONTAINER_PORT} ${DOCKER_FILE}'
				sh 'docker tag ${DOCKER_FILE} ${USERNAME}/${DOCKER_REPOSITORY}:latest'
				sh 'docker image rm -f ${DOCKER_FILE}:latest'
				
				script{
				  docker.withRegistry('https://www.docker.io/',"${DOCKER_HUB_CREDENTIALS_ID}"){
				    sh 'docker push ${USERNAME}/${DOCKER_REPOSITORY}:latest'
				  }
				}
				
				
			 }
		}
		
    }
	post{
	  always{
	      deleteDir()
	  }
	}
}