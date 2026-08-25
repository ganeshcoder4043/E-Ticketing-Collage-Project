# Dockerfile for BharatDarshan - Java/JSP Project

# 1. Base image - Java 21 (Eclipse Temurin)
FROM eclipse-temurin:21-jdk-alpine

# 2. Working directory set karein
WORKDIR /app

# 3. Project ki saari files copy karein
COPY . .

# 4. Maven install karein aur project build karein
RUN apk add --no-cache maven && \
    mvn clean package -DskipTests

# 5. Port expose karein (Tomcat default port)
EXPOSE 8080

# 6. Application run karein
CMD ["java", "-jar", "target/BharatDarshan.war"]