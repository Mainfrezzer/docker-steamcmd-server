FROM ubuntu

MAINTAINER Mattie

RUN apt-get -y update
RUN apt-get -y install wget
RUN apt-get -y install lib32gcc1

RUN wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz \
  &&  tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz \
  &&  rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz \
  &&  chmod -R 774 ${STEAMCMD_DIR}/steamcmd.sh ${STEAMCMD_DIR}/linux32/steamcmd \
  &&  ln -s ${STEAMCMD_DIR}/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="740"
ENV GAME_NAME="csgo"
ENV GAME_PARAMS="+game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2"

RUN mkdir $DATA_DIR
RUN mkdir $STEAMCMD_DIR
RUN mkdir $SERVER_DIR

EXPOSE 1200/udp
EXPOSE 27000-27045/udp
EXPOSE 27000-27045
VOLUME [${STEAMCMD_DIR}]

ADD /scripts/ /opt/scripts/
RUN chmod -R 774 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start-csgo.sh"]
