#!/bin/sh

#cd ~/scripts/docker/traefik
#sudo docker-compose up -d reverse-proxy

NAME=traefik
IMAGE=traefik:v2.2
CONFIGDIR=/mnt/nas/data2/docker/$NAME/config

sudo -u docker mkdir -p $CONFIGDIR

sudo docker pull $IMAGE
sudo docker stop $NAME
sudo docker rm -v $NAME

sudo docker run --detach --restart=always \
  --name $NAME \
  --cpus=2 \
  --cpu-shares=1024 \
  --env PUID=1003 \
  --env PGID=1000 \
  --publish published=80,target=80,protocol=tcp,mode=ingress \
  --publish published=8080,target=8080,protocol=tcp,mode=ingress \
  --mount type=bind,src=$CONFIGDIR/traefik.toml,dst=/etc/traefik/traefik.toml \
  $IMAGE
  
  # --cpu-shares=1024 # default job priority
