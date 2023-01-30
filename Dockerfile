# Fetching latest version of Java
FROM openjdk:8

# Exposing port 8080
EXPOSE 8080

# Copy the jar file into our app
ADD target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar  app.jar

# Starting the application
ENTRYPOINT ["java","-jar","/app.jar"]