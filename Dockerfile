FROM ubuntu:16.04

ARG AntMediaServer

RUN apt-get update 
RUN apt-get install -y libx11-dev
RUN apt-get install -y wget
RUN apt-get update && apt-get install -y net-tools telnet

ADD ./${AntMediaServer} /home

RUN cd home \
    && pwd \
    && wget https://raw.githubusercontent.com/ant-media/Scripts/master/install_ant-media-server.sh \
    && chmod 755 install_ant-media-server.sh

RUN cd home \
    && pwd \
    && ./install_ant-media-server.sh ${AntMediaServer}

WORKDIR /usr/local/antmedia


# ENTRYPOINT service antmedia start
CMD ["./start.sh"]

EXPOSE 1935 5080
# EXPOSE 1935 5080 5443 5554