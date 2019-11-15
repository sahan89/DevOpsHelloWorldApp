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

#FROM ubuntu:latest

FROM java:8-jdk-alpine
MAINTAINER sahan.ekanayake@explipro.com

RUN apt-get update
#RUN apt install default-jdk
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get install -y wget && \
    apt-get clean;

RUN java -version

RUN apt-get install git -y
RUN git --version

RUN apt install maven -y
RUN mvn --version

RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN pwd
RUN apt-get remove tomcat8

RUN wget http://apache.mirrors.spacedump.net/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47.tar.gz

#RUN apt-get -y install tomcat8
#RUN service tomcat8 start
#RUN service tomcat8 status
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.47/* /opt/tomcat/.
RUN ls
RUN ls /opt/tomcat/
#RUN tomcat8 --version


RUN mkdir /opt/sahan/
WORKDIR /opt/sahan/
RUN git clone https://github.com/sahan89/DevOpsHelloWorldApp.git
WORKDIR /opt/sahan/DevOpsHelloWorldApp/
RUN pwd
RUN ls -al
RUN mvn clean install
RUN cp /opt/sahan/DevOpsHelloWorldApp/target/DevOpsHelloWorldApp.war /opt/tomcat/webapps/

WORKDIR /opt/tomcat/webapps/
RUN ls -al
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]