# Base Image - ubuntu latest
FROM ubuntu

RUN apt-get -y upgrade && apt-get -y update
RUN apt install -y openjdk-11-jre-headless
RUN java --version

WORKDIR /codesign

COPY ./codesign-tool/ /codesign

ENTRYPOINT ["java", "-cp", ".:/codesign/jar/*", "com.ssl.code.signing.tool.CodeSignTool"]
