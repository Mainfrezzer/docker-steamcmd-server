FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/mainfrezzer/docker-steamcmd-server"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8


RUN	apt-get -y install --reinstall ca-certificates && \
	apt-get -y install --no-install-recommends lib32gcc-s1 wget && \
	rm -rf /var/lib/apt/lists/*


ENV LANG en_US.UTF-8
ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_PARAMS="template"
ENV GAME_PARAMS_EXTRA="template"
ENV MAP="template"
ENV SERVER_NAME="template"
ENV SRV_PWD="template"
ENV SRV_ADMIN_PWD="template"
ENV GAME_PORT=27015
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770


RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
