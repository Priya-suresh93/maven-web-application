FROM tomcat:8.0.20-jre8
copy tomcat-users.xml /usr/local/tomcat/webapps/
COPY target/*.war /usr/local/tomcat/webapps/
