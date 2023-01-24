# our base build image
FROM maven:3.8.6-jdk-8 as maven

# copy the project files
COPY ./pom.xml ./pom.xml

# build all dependencies
RUN mvn dependency:go-offline -B

# copy your other files
COPY ./ ./

## build for release
#RUN mvn clean package

# Install Zip
RUN apt-get update -qqy \
    && apt-get -qqy install zip unzip

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

RUN unzip awscliv2.zip \
    && ./aws/install