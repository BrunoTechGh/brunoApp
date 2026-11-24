FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests && find /app -maxdepth 4 \( -name "*.jar" -o -name "*.war" \) -ls

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/ /tmp/target/
RUN ls -la /tmp/target/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
