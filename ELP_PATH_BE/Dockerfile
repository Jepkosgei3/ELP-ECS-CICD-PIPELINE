# Stage 1: Build the Java application using Maven
FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /build

# Copy the Maven project files first to utilize Docker layer caching
COPY pom.xml .
COPY src ./src

# Build the application, skipping tests for faster builds
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot application with OpenJDK
FROM openjdk:17-slim

WORKDIR /app

# Copy the built JAR file from the Maven build stage
COPY --from=build /build/target/*.jar app.jar

# Expose the port used by the application
EXPOSE 8081

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
