node{
     
    stage('SCM Checkout'){
        git url: 'https://github.com/MithunTechnologiesDevOps/java-web-app-docker.git',branch: 'master'
    }
stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven-3.9.6", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
      
    }     
    
 stage('Build Docker Image'){
        sh 'docker build -t jeedeepak/java-web-app .'
    }   
    
stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
          sh "docker login -u jeedeepak -p ${Docker_Hub_Pwd}"
        }
        sh 'docker push jeedeepak/java-web-app'
       }
        stage('Run Docker Image In Dev Server'){
        
        def dockerRun = ' docker run  -d -p 8080:8080 --name java-web-app jeedeepak/java-web-app'

     sshagent(['Docker_ssh-password']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@35.154.98.111 docker stop java-web-app || true'
          sh 'ssh  ubuntu@35.154.98.111 docker rm java-web-app || true'
          sh 'ssh  ubuntu@35.154.98.111 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ubuntu@35.154.98.111 ${dockerRun}"
       }
       
    }
     
}
