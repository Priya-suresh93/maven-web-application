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
       withCredentials([string(credentialsId: 'Docker-hub-pwd', variable: 'Docker-hub-pwd')]) {
     
            sh "docker login -u priya93 -p ${Docker-hub-pwd}"
          }
        sh "docker push priya93/mavenimg1"
    }
    
   stage('emailNotification')
    {
    emailext body: '', subject: 'pipeline script', to: 'bhavanilukka@gmail.com,pripriya248@gmail.com'
    }
}
