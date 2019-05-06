node{
    def MavenHome=tool name:'maven-3.6.1', type:'maven'
    stage('checkoutcode')
    {
     git credentialsId: '1dfac5e5-8714-44b4-ade4-01656d29e265', url: 'https://github.com/Priya-suresh93/maven-web-application.git'   
    }
    stage('build')
    {
        sh "${MavenHome}/bin/mvn clean package"
    }
    stage('ExecuteSonarQube')
    {
            sh "${MavenHome}/bin/mvn sonar:sonar"
    }
    stage('deployintotomcat')
    {
    sshagent(['Tomcat-Dev']) {
    sh 'scp -o StrictHostKeyChecking=no $WORKSPACE/target/*.war ec2-user@13.233.71.198:/opt/apache-tomcat-9.0.17/webapps/'
        }
}
}
