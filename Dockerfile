FROM maven:3.9.8-amazoncorretto-17 AS builder
WORKDIR /app
COPY . /app/
RUN mvn clean package -DskipTests

FROM openjdk:17-slim
WORKDIR /app
COPY --from=builder /app/target/example-auth-jwt-custom-0.0.0-E.jar /opt/app.jar
RUN mkdir -p /opt/key
COPY --from=builder /app/src/main/resources/key/ES512.json /opt/key/ES512.json
EXPOSE 8080
CMD ["java", "-jar", "/opt/app.jar"]
