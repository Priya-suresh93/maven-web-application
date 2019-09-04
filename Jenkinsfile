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
      sh "docker build -t priya93/tomcatimg ."
    }
    stage('push docker image')
    {
      withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')]) {
        sh "docker login -u priya93 -p ${Docker_password}"
    }
        sh "docker push priya93/tomcatimg"
    }
   stage('Copy Docker-compose in swarm')
  {
    sshagent(['swarm-manager']) {
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.36.57"
        withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')]) {
        sh "docker login -u priya93 -p ${Docker_password}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.36.57 docker service create --name tomcatservice -d -p 8080:8080 --replicas 2 priya93/tomcatimg"
        }  
    }
}
}
