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
      sh "docker build -t priya93/maventest1 ."
      sh "docker build -t priya93/maventest2 . -f Dockerfile2"  
    }
    stage('push docker image')
    {
      withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')]) {
        sh "docker login -u priya93 -p ${Docker_password}"
}
        sh "docker push priya93/maventest1"
        sh "docker push priya93/maventest2"
    }
    stage('Copy Docker-compose in swarm')
    {
sshagent(['swarm-new']) {
    sh "scp ${WORKSPACE}/docker-compose.yaml ubuntu@172.31.40.167:/home/ubuntu"
    }        
    }
    stage('Deleting existing images')
    {
        sh "docker rmi -f ${docker images -q}"
        sh "docker rm -f ${docker ps -aq}"
    }
    stage('deploy into swarm manager')
    {
        sh "ssh ubuntu@172.31.40.167"
        sh "docker service create demoservice -d -p 8080:8080 -replicas 1 priya93/maventest1"
       }
}
