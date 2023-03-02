FROM --platform=$TARGETPLATFORM ubuntu:20.04

ARG TARGETPLATFORM
ARG SPARK_VERSION=3.3.2
RUN printf "I'm building for TARGETPLATFORM=${TARGETPLATFORM}"

SHELL ["/bin/bash", "-c"]
RUN apt update -y && apt upgrade -y
RUN apt -y install curl wget unzip zip

RUN curl -s https://get.sdkman.io | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"

RUN source "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install java 17.0.0-tem \
    && sdk install scala 2.12.15 \
    && sdk install sbt 1.8.2

# Download and extract Spark
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 /usr/local/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Set environment variables
ENV PATH=/root/.sdkman/candidates/java/current/bin:$PATH
ENV PATH=/root/.sdkman/candidates/scala/current/bin:$PATH
ENV PATH=/root/.sdkman/candidates/sbt/current/bin:$PATH
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$SPARK_HOME/bin:$PATH

CMD ["/bin/bash"]
