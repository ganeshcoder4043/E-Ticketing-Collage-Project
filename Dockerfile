# Dockerfile for BharatDarshan - Java/JSP Project

# 1. Base image - Tomcat 10 with Java 21
FROM tomcat:10.1-jdk21-temurin

# 2. Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. Copy WAR file to Tomcat webapps
COPY target/BharatDarshan.war /usr/local/tomcat/webapps/ROOT.war

# 4. Expose port (Tomcat default)
EXPOSE 8080

# 5. Start Tomcat
CMD ["catalina.sh", "run"]