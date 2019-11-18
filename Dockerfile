FROM java:8-jdk-alpine
MAINTAINER sahan.ekanayake@explipro.com
RUN apt-get update
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get install -y wget && \
    apt-get clean;

RUN java -version
WORKDIR /opt/sahan/DevOpsHelloWorldApp/
RUN pwd
RUN apt-get install git -y
RUN git --version

RUN apt install maven -y
RUN mvn --version

#ONBUILD RUN mvn clean install
RUN mvn clean install
RUN ls
RUN cp /home/sahan/DevOpsHelloWorldApp/target/DevOpsHelloWorldApp.war /opt/tomcat/webapps/
EXPOSE 8085
#ADD /target/simple-game-0.0.1-SNAPSHOT.war simple-game-0.0.1-SNAPSHOT.war
ENTRYPOINT ["java","-jar","DevOpsHelloWorldApp.war"]