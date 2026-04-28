FROM eclipse-temurin:17-jdk
WORKDIR /app
RUN apt-get update && apt-get install -y maven
COPY . .
RUN mvn clean package -DskipTests
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "target/eauction-1.0.0.war"]
