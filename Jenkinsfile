pipeline {
    agent any
	
	parameters {		
			string(	name: 'GIT_SSH_PATH',
					defaultValue: "https://github.com/tavisca-ysant/DemoApi.git",
					description: '')
			string(name: 'DOCKER_IMAGE_FILE',
			       defaultValue: 'demoapi',
				   description: 'This will be the name of Docker image generated. This should be in lowercase')
		    string(name: 'DOCKER_CONTAINER_NAME',
			       defaultValue: 'demoapi-container',
				   description: 'This is the named docker container. <Docker_image_name>-container or <Project_name>-container is the suggested naming
				   convention for this parameter')
			string(name: 'USERNAME',
			       defaultValue: 'yatharthsant',
				   description: 'Enter your docker hub username here')
			string(name: 'DOCKER_REPOSITORY',
			       defaultValue: 'test-repo',
				   description: 'This is the docker repository where docker image (artifact) will be posted. If the specified name does not exist, a 
				   new repository with the specified name gets generated')
			string(name: 'APPLICATION_PORT',
			       defaultValue: '65208',
				   description: 'This is the port on which your application will listen')
		    string(name: 'DOCKER_CONTAINER_PORT',
			       defaultValue: '65208',
				   description: 'This is the port on which the docker container listens')
			string(name: 'APP_NAME',
			       defaultValue: 'DemoApi',
				   description: 'This is your project/application name')
			string(name: 'DOCKER_HUB_CREDENTIALS_ID',
			       defaultValue: 'docker-hub-credentials'
				   description: 'This field is used to reference docker hub credentials')
			string(name: 'TAG_NAME',
			       defaultValue: 'latest'
				   description: 'This field is used to associate a tag to the docker image')
		    
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
				
			    sh 'docker build -t ${DOCKER_IMAGE_FILE} --build-arg APPLICATION=${APP_NAME} .'
				sh 'docker run --name ${DOCKER_CONTAINER_NAME} -e HOSTED_APP="${APP_NAME}" -d -p ${APPLICATION_PORT}:${DOCKER_CONTAINER_PORT} ${DOCKER_IMAGE_FILE}'
				sh 'docker tag ${DOCKER_IMAGE_FILE} ${USERNAME}/${DOCKER_REPOSITORY}:${TAG_NAME}'
				sh 'docker image rm -f ${DOCKER_FILE}:${TAG_NAME}'
				
				script{
				  docker.withRegistry('https://www.docker.io/',"${DOCKER_HUB_CREDENTIALS_ID}"){
				    sh 'docker push ${USERNAME}/${DOCKER_REPOSITORY}:${TAG_NAME}'
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