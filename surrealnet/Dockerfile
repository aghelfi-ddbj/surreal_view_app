FROM openjdk:11

RUN mkdir -p /opt/shinyproxy/

COPY application.yml /opt/shinyproxy/application.yml
COPY shinyproxy-3.0.1.jar /opt/shinyproxy/shinyproxy.jar

WORKDIR /opt/shinyproxy/

CMD ["java", "-jar", "/opt/shinyproxy/shinyproxy.jar"]

