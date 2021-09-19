FROM ruby:2.6

RUN set -ex && \
    apt update && \
    apt -y full-upgrade && \
    apt install -y cron && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
