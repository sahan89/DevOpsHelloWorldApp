#FROM openjdk:8-jre-alpine
## copy WAR into image
#COPY target/DevOpsHelloWorldApp.war /app.war
## run application with this command line
#CMD ["/usr/bin/java", "-jar", "-Dspring.profiles.active=default", "/app.war"]

FROM java:8-jdk-alpine
EXPOSE 8085
ADD /target/DevOpsHelloWorldApp.war /app.war
ENTRYPOINT ["java","-jar","/app.war"]

#https://www.youtube.com/watch?v=gnBgyAs5qb4