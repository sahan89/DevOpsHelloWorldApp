#FROM openjdk:8-jre-alpine
## copy WAR into image
#COPY target/DevOpsHelloWorldApp.war /app.war
## run application with this command line
#CMD ["/usr/bin/java", "-jar", "-Dspring.profiles.active=default", "/app.war"]

#FROM java:8-jdk-alpine
#EXPOSE 8085
#ADD /target/DevOpsHelloWorldApp.war /app.war
#ENTRYPOINT ["java","-jar","/app.war"]

#https://www.youtube.com/watch?v=gnBgyAs5qb4

FROM ubuntu:latest
MAINTAINER sahan.ekanayake@explipro.com

RUN apt-get update
RUN apt install default-jdk
RUN java -version

RUN git apt install git
RUN git --version

RUN apt install maven
RUN mvn --version

RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN pwd
RUN curl -O http://apache.mirrors.spacedump.net/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.47.tar.gz/* /opt/tomcat/.

RUN mkdir /opt/sahan/
RUN git clone https://github.com/sahan89/DevOpsHelloWorldApp.git
RUN cd /opt/sahan/DevOpsHelloWorldApp
RUN mvn clean install

WORKDIR /opt/tomcat/webapps
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]