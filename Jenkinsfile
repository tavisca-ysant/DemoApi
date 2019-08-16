pipeline {
    agent any
	parameters {		
			string(	name: 'GIT_SSH_PATH',
					defaultValue: "https://github.com/tavisca-ysant/DemoApi.git",
					description: '')

			string(	name: 'SOLUTION_FILE_PATH',
					defaultValue: "DemoApi.sln", 
					description: '')

			string(	name: 'TEST_PROJECT_PATH',
					defaultValue: "DemoApi.Tests/DemoApi.Tests.csproj", 
					description: '')
		    
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
			    sh 'docker build -t DemoApi -f Dockerfile .'
				sh 'docker run --rm -p 65208:65208/tcp DemoApi:latest'

			 }

		}
    }
}