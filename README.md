# docker-ubuntu

install ubuntu 20.04 the usual way.

provide a static IP address

install OpenSSH

Setup ssh keys
Do this from the local workstation:

``` shell
DHOST=d01
ssh-copy-id -i ~/.ssh/shepner_rsa.pub $DHOST

scp ~/.ssh/shepner_rsa $DHOST:.ssh/shepner_rsa
scp ~/.ssh/shepner_rsa.pub $DHOST:.ssh/shepner_rsa.pub
scp ~/.ssh/config $DHOST:.ssh/config
ssh $DHOST "chmod -R 700 ~/.ssh"
```
