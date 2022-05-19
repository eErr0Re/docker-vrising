FROM ubuntu:22.04 
USER root
LABEL maintainer="Tim Chaubet"
VOLUME ["/mnt/vrising/server", "/mnt/vrising/persistentdata"]

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update -y && \
    apt-get upgrade -y && \
    apt-get install -y  apt-utils && \
    apt-get install -y  software-properties-common && \
    add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt update -y && \
    apt-get upgrade -y && \
    useradd -m steam && cd /home/steam && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt purge steam steamcmd && \
    apt install -y steamcmd \
		   wget \
                   mono-complete \
		   wine \
		   wine64 && \
    ln -s /usr/games/steamcmd /usr/bin/steamcmd && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean 


#FROM cm2network/steamcmd:latest AS steamdeploy
#FROM ghcr.io/linuxserver/baseimage-mono:focal
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
