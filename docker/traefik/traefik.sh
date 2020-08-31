#!/bin/sh
# [Traefik v2](https://github.com/DoTheEvo/Traefik-v2-examples#1-traefik-routing-to-various-docker-containers) examples


sudo docker network create traefik_net
#sudo docker network inspect traefik_net

# This will show the docker-compose.yml file with the vars filled in
#sudo docker-compose config

SERVICE=traefik
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/.env pull $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/.env stop $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/.env rm $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/.env up -d $SERVICE

SERVICE=whoami
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ pull $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ stop $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ rm $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ up -d $SERVICE

SERVICE=portainer
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ pull $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ stop $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ rm $SERVICE
sudo docker-compose -f ~/scripts/docker/traefik/$SERVICE-docker-compose.yml --env-file ~/scripts/docker/traefik/ up -d $SERVICE


# To stop all containers
#docker stop $(docker ps -q)

#NAME=traefik
#IMAGE=traefik:v2.2
#CONFIGDIR=/mnt/nas/data2/docker/$NAME/config

#sudo -u docker mkdir -p $CONFIGDIR

#wget -O $CONFIGDIR/traefik.yml https://raw.githubusercontent.com/shepner/proxmox-docker/master/docker/traefik/traefik.yml

#sudo docker pull $IMAGE
#sudo docker stop $NAME
#sudo docker rm -v $NAME

#sudo docker run --detach --restart=always \
#  --name $NAME \
#  --cpus=2 \
#  --cpu-shares=1024 \
#  --env PUID=1003 \
#  --env PGID=1000 \
#  --publish published=80,target=80,protocol=tcp,mode=ingress \
#  --publish published=8080,target=8080,protocol=tcp,mode=ingress \
#  --mount type=bind,src=$CONFIGDIR/traefik.yml,dst=/etc/traefik/traefik.yml \
#  $IMAGE
  
  # --cpu-shares=1024 # default job priority
