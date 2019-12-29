FROM java:8-jdk-alpine
EXPOSE 8085
ADD /target/DevOpsHelloWorldApp.jar DevOpsHelloWorldApp.jar
ENTRYPOINT ["java","-jar","DevOpsHelloWorldApp.jar"]