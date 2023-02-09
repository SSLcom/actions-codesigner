# Base Image - ubuntu latest
FROM openjdk:11.0.12-jdk-slim

ENV CODE_SIGN_TOOL_PATH=/codesign

# Install Packages
RUN apt update && apt dist-upgrade -y && apt install -y unzip vim wget curl

# Added CodeSignTool Setup
ADD --chown=root:root CodeSignTool-v1.2.7.zip /tmp/CodeSignTool-v1.2.7.zip

# Install CodeSignTool
RUN unzip "/tmp/CodeSignTool-v1.2.7.zip" -d "/tmp" && mv "/tmp/CodeSignTool-v1.2.7" "/codesign" && \
    chmod +x "/codesign/CodeSignTool.sh" && ln -s "/codesign/CodeSignTool.sh" "/usr/bin/codesign"

COPY ./codesign-tool/ /codesign
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /codesign

ENTRYPOINT ["/entrypoint.sh"]
