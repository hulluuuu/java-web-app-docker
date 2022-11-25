node
{
   def buildNumber = BUILD_NUMBER
   stage("Git CheckOut"){
        git url: 'https://github.com/vinothaws/java-web-app-docker.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
    } 
   stage("Build Dokcer Image") {
         sh "docker build -t vinothaws/java-web-app-docker:${buildNumber} ."
   }  
    stage("Docker login and Push"){
    withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
    sh "docker login -u vinothaws -p ${docker} " 
           }
        sh "docker push vinothaws/java-web-app-docker:${buildNumber}"
    }
    stage("Deploy to dockercontinor in docker deployer"){
        sshagent(['Docker-dev-ssh']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.15.107 docker rm -f my1stproject22 || true"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.15.107 docker run -d -p 8080:8080 --name my1stproject vinothaws/java-web-app-docker:${buildNumber}"
    } 
}

}
