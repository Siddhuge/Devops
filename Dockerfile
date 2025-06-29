FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ Devops
RUN cd vprofile-project &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Devops"
LABEL "Author"="Siddhant"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE Devops/target/devops-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
