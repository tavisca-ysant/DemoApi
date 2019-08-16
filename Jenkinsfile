pipeline {
    agent any
	parameters {		
			string(	name: 'GIT_SSH_PATH',
					defaultValue: "https://github.com/tavisca-ysant/DemoApi.git",
					description: '')

			string(name: 'DOCKER_FILE',
			       defaultValue: 'demoapi')
		    string(name: 'DOCKER_CONTAINER',
			       defaultValue: 'demoapi-container')
		    
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
			    sh 'docker build -t ${DOCKER_FILE} -f Dockerfile .'
				sh 'docker run --name ${DOCKER_CONTAINER} -p 65208:65208/tcp ${DOCKER_FILE}:latest'
				sh 'docker image rm -f ${DOCKER_FILE}:latest'
			 }
		}
		
    }
	post{
	  success{ 
	    sh 'docker container stop ${DOCKER_CONTAINER}'
	  }
	}
}