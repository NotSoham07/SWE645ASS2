# Use an official Tomcat 10.1 runtime as a parent image
FROM tomcat:10.1-jdk11-openjdk


# Copy your WAR file to the Tomcat webapps directory
COPY student-survey.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port (8080)
EXPOSE 8080

