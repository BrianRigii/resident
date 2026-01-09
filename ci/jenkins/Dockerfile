FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl unzip zip xz-utils libglu1-mesa openjdk-17-jdk sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download Flutter artifacts
RUN flutter doctor -v

# Create Jenkins user
RUN useradd -m jenkins && echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER jenkins
WORKDIR /home/jenkins
