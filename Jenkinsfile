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
                sh 'dotnet publish ${APP_NAME} -c Release -o ${OutputDirectory}' 
            }
        }

		stage('Setting up environment for docker'){
		  steps{
		     sh 'mv Dockerfile ${APP_NAME}/${OutputDirectory}'
		  }
		}
		
		stage('Deploy'){
		     
		     steps{
			    sh '''
				if(docker inspect -f {{.State.Running}} ${DOCKER_CONTAINER_NAME})
				then
					docker container rm -f ${DOCKER_CONTAINER_NAME}
				fi
			    '''
				script
				{
				dir("${APP_NAME}/${OutputDirectory}"){
			    sh 'docker build -t ${USERNAME}/${DOCKER_REPOSITORY}:latest --build-arg APPLICATION=${APP_NAME} .'
				sh 'docker run --name ${DOCKER_CONTAINER_NAME}  -p ${APPLICATION_PORT}:${DOCKER_CONTAINER_PORT} ${USERNAME}/${DOCKER_REPOSITORY}:latest'
				}
				}
				
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