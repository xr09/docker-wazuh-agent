FROM debian:stretch-slim

LABEL maintainer "NoEnv"
LABEL version "3.13.2"
LABEL description "Wazuh Agent"

RUN apt-get update && apt-get install -y \
  procps curl apt-transport-https gnupg2 inotify-tools python-docker && \
  curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
  echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list && \
  apt-get update && \
  apt-get install -y wazuh-agent=3.13.2-1 && \
  rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY ossec.conf /var/ossec/etc/

ENTRYPOINT ["/entrypoint.sh"]
