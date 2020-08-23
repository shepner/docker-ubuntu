#!/bin/sh
# https://docs.linuxserver.io/images/docker-jackett

NAME=jackett
BASEDIR=/mnt/nas/data2/docker/$NAME

sudo -u docker mkdir -p $BASEDIR/config
sudo -u docker mkdir -p $BASEDIR/downloads

sudo docker run --detach \
  --name $NAME \
  --cpus=2 \
  --cpu-shares=1024 \
  --env PUID=1003 \
  --env PGID=1000 \
  --env TZ="America/Chicago" \
  --env AUTO_UPDATE=true \
  --publish published=9117,target=9117,protocol=tcp,mode=ingress \
  --mount type=bind,src=$BASEDIR/config,dst=/config \
  --mount type=bind,src=$BASEDIR/downloads,dst=/downloads \
  linuxserver/jackett
  
  # --cpu-shares=1024 # default job priority
