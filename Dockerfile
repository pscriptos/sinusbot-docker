FROM ubuntu:22.04

ENV SINUSBOT_VERSION=current \
    TS3_VERSION=3.5.6 \
    TS3_ARCH=amd64 \
    BOT_USER=sinusbot \
    BOT_HOME=/opt/sinusbot

# Pakete installieren
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget bzip2 ca-certificates curl dbus iproute2 less screen xvfb \
    libasound2 libegl1-mesa libfontconfig libglib2.0-0 libnss3 libpci3 \
    libxcomposite-dev libxcursor1 libxdamage1 libxi6 libxkbcommon0 \
    libxkbcommon-x11-0 libxss1 libxslt1.1 libxtst6 x11-xkb-utils \
    libpulse0 espeak-ng mbrola mbrola-de6 \
    fonts-dejavu fonts-liberation fonts-freefont-ttf \
    && update-ca-certificates && \
    useradd -m -d /home/${BOT_USER} -s /bin/bash ${BOT_USER} && \
    mkdir -p ${BOT_HOME} && \
    chown -R ${BOT_USER}:${BOT_USER} ${BOT_HOME}

# SinusBot
WORKDIR /tmp
RUN wget -q https://www.sinusbot.com/dl/sinusbot.${SINUSBOT_VERSION}.tar.bz2 && \
    tar -xjf sinusbot.${SINUSBOT_VERSION}.tar.bz2 -C ${BOT_HOME} && \
    rm sinusbot.${SINUSBOT_VERSION}.tar.bz2

# TS3 Client
RUN wget https://files.teamspeak-services.com/releases/client/${TS3_VERSION}/TeamSpeak3-Client-linux_${TS3_ARCH}-${TS3_VERSION}.run && \
    chmod +x TeamSpeak3-Client-linux_${TS3_ARCH}-${TS3_VERSION}.run && \
    mkdir /tmp/ts3 && \
    yes y | ./TeamSpeak3-Client-linux_${TS3_ARCH}-${TS3_VERSION}.run --target /tmp/ts3 && \
    mkdir -p ${BOT_HOME}/teamspeak3-client && \
    cp -r /tmp/ts3/* ${BOT_HOME}/teamspeak3-client/ && \
    rm -rf /tmp/ts3 *.run

# Plugin verlinken
RUN mkdir -p ${BOT_HOME}/teamspeak3-client/plugins && \
    cp ${BOT_HOME}/plugin/libsoundbot_plugin.so ${BOT_HOME}/teamspeak3-client/plugins/

# config.ini
COPY ./data/config.ini ${BOT_HOME}/config.ini

# Kopieren der Standard-Skripte
RUN cp -a ${BOT_HOME}/scripts ${BOT_HOME}/scripts.dist

# Rechte setzen
RUN chown -R ${BOT_USER}:${BOT_USER} ${BOT_HOME} && \
    chmod +x ${BOT_HOME}/sinusbot

# entrypoint.sh ins Image kopieren
COPY ./data/bin/entrypoint.sh /opt/sinusbot/entrypoint.sh
RUN chmod +x /opt/sinusbot/entrypoint.sh

# Rechte setzen
RUN chown -R ${BOT_USER}:${BOT_USER} ${BOT_HOME} && \
    chmod +x ${BOT_HOME}/sinusbot

WORKDIR ${BOT_HOME}
USER ${BOT_USER}

EXPOSE 8087

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]
CMD ["./sinusbot"]
