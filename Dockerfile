FROM debian:jessie

MAINTAINER Deni Bertovic <deni@denibertovic.com>

ENV PID1_VERSION=0.1.2.0
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install \
    build-essential \
    ca-certificates \
    curl \
    gitit \
    less

# Install PID1
RUN curl -sSL "https://github.com/fpco/pid1/releases/download/v${PID1_VERSION}/pid1-${PID1_VERSION}-linux-x86_64.tar.gz" | tar xzf - -C /usr/local && \
    chown root:root /usr/local/sbin && \
    chown root:root /usr/local/sbin/pid1
ENV LANG=en_US.UTF-8

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

COPY gitit.conf /etc/gitit.conf

VOLUME ["/data"]

WORKDIR /data

EXPOSE 5001

CMD ["gitit", "-f", "/etc/gitit.conf"]
