# Base Image - ubuntu latest
FROM openjdk:11.0.12-jdk-slim

# RUN apt-get -y upgrade && apt-get -y update
# RUN apt install -y openjdk-11-jre-headless
# RUN java --version

WORKDIR /codesign

COPY ./codesign-tool/ /codesign
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
