FROM ubuntu:16.04
MAINTAINER Jay Chawda <jay@phonepe.com>

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    wrk curl inetutils-ping

ADD request.lua /root/request.lua


CMD wrk -c $CONNECTIONS -d $DURATION -t $THREADS -s /root/request.lua $ENDPOINT