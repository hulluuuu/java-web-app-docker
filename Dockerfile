FROM tomcat:8.0.27-jre8
# Dummy text to test 1
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
