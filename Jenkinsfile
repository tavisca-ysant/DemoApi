pipeline {
    agent any
	environment {
    registry = "yatharthsant/test-repo"
    registryCredential = 'dockerhub'
  }
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
			       defaultValue: 'Yatharth123@')
			string(name: 'docker-hub-credentials', defaultValue: 'localhost:8080')
		    
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
                sh 'dotnet publish -c Release -o publish' 
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
			    sh 'docker build -t ${DOCKER_FILE} -f Dockerfile .'
				sh 'docker run --name ${DOCKER_CONTAINER_NAME} -d -p 65208:65208/tcp ${DOCKER_FILE}:latest'
				sh 'docket tag ${DOCKER_FILE} ${USERNAME}/test-repo:latest'
				sh 'docker login -u ${USERNAME} -p ${PASSWORD}'
				sh 'docker push ${USERNAME}/test-repo:latest'
				sh 'docker image rm -f ${DOCKER_FILE}:latest'
			 }
		}
		
    }
	post{
	  always{
	      deleteDir()
	  }
	}
}