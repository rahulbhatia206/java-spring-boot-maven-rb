# our base build image
FROM maven:3.8.6-jdk-8 as maven

# copy the project files
COPY ./pom.xml ./pom.xml

# build all dependencies
RUN mvn dependency:go-offline -B

# copy your other files
COPY ./ ./

## build for release
RUN mvn clean




