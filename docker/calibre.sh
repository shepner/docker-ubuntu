#!/bin/sh
# https://docs.linuxserver.io/images/docker-calibre

# 6080(8080) Calibre desktop gui. ctrl-alt-shift to access the clipboard
# 6081(8081) Calibre webserver gui.

# [Customizing calibre](https://manual.calibre-ebook.com/customize.html)
# Environment variables
# CALIBRE_CONFIG_DIRECTORY - sets the directory where configuration files are stored/read.
# CALIBRE_OVERRIDE_DATABASE_PATH - allows you to specify the full path to metadata.db. Using this variable you can have metadata.db be in a location other than the library folder. Useful if your library folder is on a networked drive that does not support file locking.



NAME=calibre
CONFIGDIR=/mnt/nas/data2/docker/$NAME/config
mkdir -p $CONFIGDIR

sudo docker run --detach \
  --name $NAME \
  --hostname $NAME \
  --env PUID=1003 \
  --env PGID=1000 \
  --env TZ="America/Chicago" \
  --env CALIBRE_CONFIG_DIRECTORY="/config" \
  --env CALIBRE_OVERRIDE_DATABASE_PATH="/config" \
  --mount type=bind,src=$CONFIGDIR,dst=/config \
  --mount type=bind,src=/mnt/nas/data1/media,dst=/media \
  --publish published=6080,target=8080,protocol=tcp,mode=ingress \
  --publish published=6081,target=8081,protocol=tcp,mode=ingress \
  linuxserver/calibre


#  -e GUAC_USER=abc `#optional` \
#  -e GUAC_PASS=900150983cd24fb0d6963f7d28e17f72 `#optional` \
#  -e UMASK_SET=022 `#optional` \
#  -e CLI_ARGS= `#optional` \
#  
