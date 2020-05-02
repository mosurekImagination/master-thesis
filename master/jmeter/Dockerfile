FROM openjdk:8-jdk-alpine
WORKDIR /jmeter/
COPY /jmeter-5.2.1/ /jmeter/
COPY /test-scenarios/ /jmeter/test-scenarios/
COPY entrypoint.sh /jmeter/
CMD ["chmod", "+x", "entrypoint.sh"]
ENTRYPOINT [ "/jmeter/entrypoint.sh" ]
