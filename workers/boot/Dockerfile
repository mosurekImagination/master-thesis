FROM maven:3-openjdk-14-slim AS MAVEN_BUILD

WORKDIR /build/
COPY pom.xml /build/
RUN mvn dependency:go-offline
COPY src /build/src/
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:14-jdk-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/ /app/
ENTRYPOINT ["java", "-jar", "mosur-thesis-worker-boot-0.0.1-SNAPSHOT.jar"]