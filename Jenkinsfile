node
{
    def MavenHome=tool name:'maven-3.6.1', type:'maven'
    stage('checkoutcode')
    {
     git credentialsId: '1dfac5e5-8714-44b4-ade4-01656d29e265', url: 'https://github.com/Priya-suresh93/maven-web-application.git'   
    }
    stage('build')
    {
        sh "${MavenHome}/bin/mvn clean package -D maven.test.skip=true"
    }
    stage('build docker image')
    {
      sh "docker build -t priya93/tomcat_image ."
      sh "docker build -t priya93/wildfly_image . -f Dockerfile2"  
    }
    stage('push docker image')
    {
      withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')]) {
        sh "docker login -u priya93 -p ${Docker_password}"
}
        sh "docker push priya93/tomcat_image"
        sh "docker push priya93/wildfly_image"
    }
    stage('Copy Docker-compose in swarm')
    {
        sshagent(credentials: ['Swarm_manager'], ignoreMissing: true) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.47.200"
                sh "scp ${WORKSPACE}/docker-compose.yml ubuntu@172.31.47.200:/home/ubuntu"
        }       
    }
   // stage('Deleting existing images')
 //   {
   //     sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.40.167 docker stop container1 || true"
   //      sh 'ssh ubuntu@172.31.40.167 docker rm container1 || true'
   //     sh 'ssh ubuntu@172.31.40.167 docker rmi -f $(docker images -q) || true'
    // } 
    stage('docker-compose-up')
    {
        sshagent(credentials: ['Swarm_manager'], ignoreMissing: true) {
        sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.47.200 docker-compose up"
         //  sh "docker service create --name nginx --mode global --constraint 'node.role==worker' nginx"
           //sh "docker stack deploy --compose-file docker-compose.yml nginx"
       }
}
}
