# # Stage 1: Build the Java application using Maven
# FROM maven:3.8.4-openjdk-17-slim AS build

# WORKDIR /ELP_PATH_BE

# # Copy the Maven files first (pom.xml), then the source code to take advantage of Docker layer caching
# COPY pom.xml . 
# COPY src ./src

# # Run Maven to build the application
# RUN mvn clean package -DskipTests

# # Stage 2: Run the Spring Boot application with OpenJDK
# FROM openjdk:17-slim

# # Set working directory in the container
# WORKDIR /app

# # Copy the Spring Boot .jar file from the build stage (the actual JAR file should be in the target directory)
# # You might need to update the file name if your .jar file is named differently
# COPY --from=build /ELP_PATH_BE/target/*.jar app.jar

# # Expose the port your Spring Boot application will run on
# EXPOSE 8080

# # Define the command to run your Spring Boot application
# ENTRYPOINT ["java", "-jar", "app.jar"]


# Stage 1: Build the Java application using Maven
FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /build

# Copy Maven files for caching
COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .

# Copy source code
COPY src ./src
RUN chmod +x mvnw
# Run Maven to build the application
RUN ./mvnw clean package -DskipTests && rm -rf /root/.m2/repository

# Stage 2: Run the Spring Boot application with OpenJDK
# Stage 2: Run the Spring Boot application with OpenJDK
FROM openjdk:17-slim

# Set working directory in the container
WORKDIR /app

# Copy the built .jar file from the build stage
COPY --from=build /build/target/*.jar app.jar

# Expose the port Spring Boot runs on
EXPOSE 8080

# Optional: Add a health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:8080/actuator/health || exit 1

# Define the command to run your Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]


