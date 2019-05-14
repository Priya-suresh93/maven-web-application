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
      sh "docker build -t priya93/mavenimg1 ."
    }
    stage('push docker image')
    {
       withCredentials([string(credentialsId: 'docker_pwd', variable: 'docker_pwd')]) {
        sh "docker login -u priya93 -p ${docker_pwd}"
    }
        sh "docker push priya93/mavenimg1"
    }
    stage('deploy into another server')
    {
        def DockerRun = "docker run -d -p 8080:8080 --name mavencontainer1 priya93/mavenimg1"
        sshagent(['node1_server_auth']) {
         sh "ssh -o StrictHostKeyChecking=no ubuntu@1172.31.3.22 docker stop mavencontainer1 || true"
         sh "ssh ubuntu@172.31.3.22 docker rm mavencontainer1 || true"
         sh "ssh ubuntu@172.31.3.22 docker rmi -f ${docker images -q} || true"
         sh "ssh ubuntu@172.31.3.22 ${DockerRun}"
        }
    }
}
