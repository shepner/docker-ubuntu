#!/bin/sh
# https://docs.linuxserver.io/images/docker-sonarr

NAME=sonarr
BASEDIR=/mnt/nas/data1/docker/$NAME

sudo -u docker mkdir -p $BASEDIR/config
#sudo -u docker mkdir -p $BASEDIR/tv
#sudo -u docker mkdir -p $BASEDIR/downloads

sudo docker run --detach \
  --name $NAME \
  --env PUID=1003 \
  --env PGID=1000 \
  --env TZ="America/Chicago" \
  --dns 10.0.0.71 \
  --publish published=8989,target=8989,protocol=tcp,mode=ingress \
  --mount type=bind,src=/etc/localtime,dst=/etc/localtime,readonly=1 \
  --mount type=bind,src=$BASEDIR/config,dst=/config \
  --mount type=bind,src=/mnt/nas/data1/media/Videos,dst=/tv \
  --mount type=bind,src=/mnt/nas/data1/docker/transmission/downloads/complete,dst=/downloads \
  linuxserver/sonarr
  
