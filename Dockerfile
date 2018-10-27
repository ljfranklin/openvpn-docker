# Smallest base image
FROM alpine:3.8

MAINTAINER John Felten<john.felten@gmail.com>

ADD VERSION .

# Install needed packages
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && apk add ca-certificates openssl openvpn iptables bash && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# install easy-rsa from source as easy-rsa package depends on non-existant openssl1.0
RUN wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.5/EasyRSA-nix-3.0.5.tgz && \
  mkdir /usr/share/easy-rsa && \
  tar xzf EasyRSA-*.tgz --strip-components=1 -C /usr/share/easy-rsa/ && \
  rm EasyRSA-*.tgz

# Configure tun
RUN mkdir -p /dev/net && \
     mknod /dev/net/tun c 10 200
