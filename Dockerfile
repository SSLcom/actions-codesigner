# Base Image - ubuntu latest
FROM openjdk:17-jdk-alpine3.14

RUN java --version

WORKDIR /codesign

COPY ./codesign-tool/ /codesign
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
