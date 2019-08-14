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
				sh 'dotnet restore ${SOLUTION_FILE_PATH} --source https://api.nuget.org/v3/index.json'
                sh 'dotnet build  ${SOLUTION_FILE_PATH} -p:Configuration=release -v:n'
				
            }
        }
        stage('Test') {
            steps {
                sh 'dotnet test ${TEST_PROJECT_PATH}' 
            }
        }
    }
}