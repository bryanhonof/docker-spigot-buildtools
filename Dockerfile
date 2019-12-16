ARG JAVA_VERSION=8

# The spigot jar has to be compiled from the BuildTools
FROM openjdk:$JAVA_VERSION-alpine AS buildtools

ARG SPIGOT_REV=1.15

LABEL maintainer = "Bryan Honof" \
    maintainer.email = "bryan@bryanhonof.be" \
    maintainer.website = "https://www.bryanhonof.be" \
    version = "1.15" \
    description = "Spigot buildtools in a container!" \
    dockerfile.repo = "https://github.com/bryanhonof/docker-spigot-buildtools"

# The link to get the BuildTools.jar from
ENV BUILDTOOLS_URL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Working directory
WORKDIR /tmp/build

# Install git and curl to fetch the depencencies
# Build the spigot.jar file with the BuildTools
RUN apk --no-cache update \
    && apk --no-cache add --virtual dependencies git curl \
    && curl -o BuildTools.jar $BUILDTOOLS_URL \
    && java -jar BuildTools.jar --rev $SPIGOT_REV \
    && apk del dependencies

CMD ["/bin/sh"]
