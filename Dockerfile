FROM ubuntu:16.04

ARG AntMediaServer

RUN apt-get update 
RUN apt-get install -y libx11-dev
RUN apt-get install -y wget
RUN apt-get update && apt-get install -y net-tools telnet vim

ADD ./${AntMediaServer} /home

RUN cd home \
    && pwd \
    && wget https://raw.githubusercontent.com/ant-media/Scripts/master/install_ant-media-server.sh \
    && chmod 755 install_ant-media-server.sh

RUN cd home \
    && pwd \
    && ./install_ant-media-server.sh ${AntMediaServer}

WORKDIR /usr/local/antmedia

# COPY ./conf custom/conf
# RUN cat custom/conf/WebAppRTC/red5-web.properties > /usr/local/antmedia/webapps/WebRTCApp/WEB-INF/red5-web.properties
# RUN cd webapps && ls -al
# ENTRYPOINT service antmedia start
RUN ["./start.sh"]

EXPOSE 1935 5080
# EXPOSE 1935 5080 5443 5554