#!/bin/sh
# https://docs.linuxserver.io/images/docker-transmission

NAME=transmission
BASEDIR=/mnt/nas/data1/docker/$NAME

sudo -u docker mkdir -p $BASEDIR/config
sudo -u docker mkdir -p $BASEDIR/watch
sudo -u docker mkdir -p $BASEDIR/downloads

sudo docker run --detach \
  --name $NAME \
  --env PUID=1003 \
  --env PGID=1000 \
  --env TZ="America/Chicago" \
  --publish published=9091,target=9091,protocol=tcp,mode=ingress \
  --publish published=51413,target=51413,protocol=tcp,mode=ingress \
  --publish published=51413,target=51413,protocol=udp,mode=ingress \
  --mount type=bind,src=$BASEDIR/config,dst=/config \
  --mount type=bind,src=$BASEDIR/watch,dst=/watch \
  --mount type=bind,src=$BASEDIR/downloads,dst=/downloads \
  linuxserver/transmission
  
