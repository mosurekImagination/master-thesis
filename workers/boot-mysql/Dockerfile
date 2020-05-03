FROM maven:3-openjdk-14-slim AS MAVEN_BUILD

WORKDIR /build/
COPY pom.xml /build/
RUN mvn dependency:go-offline
COPY src /build/src/
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:14-jdk-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/ /app/
COPY ./lib/ServerAgent/ /serverAgent/
COPY entrypoint.sh /app/entrypoint.sh
EXPOSE 4444
ENTRYPOINT ["/app/entrypoint.sh"]