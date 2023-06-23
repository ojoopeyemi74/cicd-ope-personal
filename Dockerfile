FROM amazoncorretto:11-alpine3.14-jdk

WORKDIR /app

COPY /target/Uber.jar /app/

EXPOSE 9090

CMD [ "java", "-jar", "Uber.jar" ]