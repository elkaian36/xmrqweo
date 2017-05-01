FROM ubuntu:16.04
MAINTAINER G.T. F.O <gtfo@gtfo.com>

RUN apt-get update && apt-get -y -q install \
   software-properties-common \
   libmicrohttpd-dev \
   libssl-dev \ 
   cmake \ 
   build-essential \
   unzip \
   wget \ 
   dos2unix

ARG WALLET_ADDRESS=42jF56tc85UTZwhMQc6rHbMHTxHqK74qS2zqLyRZxLbwegsy7FJ9w4T5B69Ay5qeMEMuvVDwHNeopAxrEZkkHrMb5phovJ6
ARG POOL_ADDRESS=monerohash.com:3333
ARG POOL_PASSWORD=x

RUN wget https://github.com/fireice-uk/xmr-stak-cpu/archive/v1.2.0-1.4.1.zip 
RUN unzip /v1.2.0-1.4.1.zip
RUN cd /xmr-stak-cpu-1.2.0-1.4.1 && \
  cmake . && \
  make install

ADD config.txt /config.txt
ADD entrypoint.sh /entrypoint.sh

RUN dos2unix /config.txt
RUN dos2unix /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080


RUN cp -v /config.txt /xmr-stak-cpu-1.2.0-1.4.1/bin/config.txt

ENTRYPOINT ["/entrypoint.sh"]