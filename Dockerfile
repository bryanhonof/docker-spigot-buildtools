ARG JAVA_VERSION=12

# The spigot jar has to be compiled from the BuildTools.
FROM openjdk:$JAVA_VERSION-alpine AS buildtools

# The link to get the BuildTools.jar from.
ENV BUILDTOOLS_URL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
# Version that has to be compiled.
ENV SPIGOT_REV 1.14.1

# Working directory.
WORKDIR /tmp/build

# Install git and curl to fetch the depencencies.
# Build the spigot.jar file with the BuildTools.
RUN    apk --no-cache update                              \
    && apk --no-cache add --virtual dependencies git curl \
    && curl -o BuildTools.jar $BUILDTOOLS_URL             \
    && java -jar BuildTools.jar --rev $SPIGOT_REV         \
    && apk del dependencies

CMD ["/bin/sh"]

