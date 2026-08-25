# Dockerfile for BharatDarshan - Tomcat 9 (Compatible with your code)

# 1. Base image - Tomcat 9 with Java 17
FROM tomcat:9.0-jdk17-temurin

# 2. Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. Copy WAR file to Tomcat webapps
COPY target/BharatDarshan.war /usr/local/tomcat/webapps/ROOT.war

# 4. Expose port
EXPOSE 8080

# 5. Start Tomcat
CMD ["catalina.sh", "run"]