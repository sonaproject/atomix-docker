# Configure Java 8 runtime environment
FROM anapsix/alpine-java:8_server-jre
MAINTAINER Jian Li <gunine@sk.com>

# Set the environment variables
ENV HOME /root
ENV BUILD_NUMBER docker
ENV ATOMIX_VERSION 3.0.11

# Copy in the binary
RUN mkdir -p /root/atomix
RUN wget -O atomix-dist.tar.gz https://oss.sonatype.org/content/repositories/releases/io/atomix/atomix-dist/${ATOMIX_VERSION}/atomix-dist-${ATOMIX_VERSION}.tar.gz
RUN tar -xvf atomix-dist.tar.gz -C /root/atomix
RUN rm -rf atomix-dist.tar.gz

WORKDIR /root/atomix

EXPOSE 5678
EXPOSE 5679

# Get ready to run command
ENTRYPOINT ["./bin/atomix-agent","-c","./config/atomix.json","--ignore-resources"]
