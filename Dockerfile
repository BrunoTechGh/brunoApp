FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
<<<<<<< HEAD
RUN mvn clean package -DskipTests && ls -la /app/target

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar /tmp/
RUN ls -la /tmp && cp $(ls /tmp/*.jar | grep -v 'original-' | head -n 1) /app/app.jar && ls -lh /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
=======
RUN mvn clean package -DskipTests && find /app -maxdepth 4 \( -name "*.jar" -o -name "*.war" \) -ls

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/ /tmp/target/
RUN ls -la /tmp/target/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
>>>>>>> 4e6bc77f984256c8b08eddd4b802fac8e3096b9e
