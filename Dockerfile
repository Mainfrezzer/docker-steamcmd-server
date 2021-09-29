FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 libsqlite3-0 && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_PARAMS="template"
ENV DEBUG_OUTPUT=""
ENV LOG_OUTPUT=""
ENV LOG_FILE="stn.log"
ENV DELETE_LOG="true"
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
	useradd -d $SERVER_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
COPY /config/ServerConfig.txt /tmp/ServerConfig.txt
RUN chmod -R 770 /opt/scripts/ && \
	chmod -R 744 /tmp

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]