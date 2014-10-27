FROM debian:jessie
MAINTAINER Yves Serrano <y@yas.ch>

RUN apt-get update && apt-get install -yq \
        autoconf \
        build-essential \
        libssl-dev \
        curl \
        libdb-dev \
        libavahi-compat-libdnssd-dev \
        libgcrypt20-dev \
        libacl1-dev \
        libcrack2-dev \
        libwrap0-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lq -o /usr/local/src/netatalk-3.1.6.tar.bz2 \
    "http://downloads.sourceforge.net/project/netatalk/netatalk/3.1.6/netatalk-3.1.6.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fnetatalk%2Ffiles%2Fnetatalk%2F3.1.6%2Fnetatalk-3.1.6.tar.bz2%2Fdownload%3Fuse_mirror%3Dsoftlayer-ams%26download%3D&ts=1413963476&use_mirror=switch" && \
    cd /usr/local/src && tar xjvf netatalk-3.1.6.tar.bz2

WORKDIR /usr/local/src/netatalk-3.1.6
RUN ./configure --enable-debian --enable-zeroconf --with-acls --enable-tcp-wrappers --with-init-style=debian-sysv && \
    make && make install
EXPOSE 548
