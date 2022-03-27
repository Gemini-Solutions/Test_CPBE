node('maven_runner_java11') {
	stage('backend_checkout') {
		dir('ContriPoint_BackEnd') {
			checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], \
				userRemoteConfigs: [[credentialsId: 'admingithub', url: 'https://github.com/Gemini-Solutions/ContriPoint_BackEnd.git']]])
		}
	}
	stage('Maven_Build') {
		container('mvnbuild') {
			dir('ContriPoint_BackEnd') {
				sh 'rm -rf target'
				sh 'mvn package'
				dir('target'){
					sh 'chmod +x Contripoint*.jar'
				}
			}
		}
	}
}

node('image_builder') {
	try {
		stage('Build_image') {
			dir('ContriPoint_BackEnd') {
				container('dockerbuild') {
					withCredentials([usernamePassword(credentialsId: 'docker_registry', passwordVariable: 'docker_pass', usernameVariable: 'docker_user')]) {
						sh 'docker image build -f DockerFile -t registry.geminisolutions.com/contripoint/contripoint:1.0-$BUILD_NUMBER .'
						sh '''docker login -u $docker_user -p $docker_pass https://registry.geminisolutions.com'''
						sh 'docker push registry.geminisolutions.com/contripoint/contripoint:1.0-$BUILD_NUMBER'
					}
				}
			}
		}
	} finally {
		sh 'echo current_image="registry.geminisolutions.com/contripoint/contripoint:1.0-$BUILD_NUMBER" > build.properties'
		archiveArtifacts artifacts: 'build.properties', onlyIfSuccessful: true
	}
}
