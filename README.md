# proxmox-docker

Docker host running as a Proxmox VM

run the following

``` shell
bash <(curl -s https://raw.githubusercontent.com/shepner/proxmox-docker/master/proxmox/create_vm.sh)
```

install Ubuntu 20.04 the usual way.

provide a static IP address

DNS: 10.0.0.5,208.67.222.222,208.67.220.220

Do NOT setup disk as LVM group

install OpenSSH

## Fix the UID

First set the permissions of the home dir:

``` shell
sudo chown -R 1001 /home/`id -un`
```

Then change the UID accodingly in the passwd files:

``` shell
sudo vipw
```

Finally, logout and back in again

## Setup ssh keys

Do this from the local workstation:

``` shell
DHOST=plex
ssh-copy-id -i ~/.ssh/shepner_rsa.pub $DHOST

scp ~/.ssh/shepner_rsa $DHOST:.ssh/shepner_rsa
scp ~/.ssh/shepner_rsa.pub $DHOST:.ssh/shepner_rsa.pub
scp ~/.ssh/config $DHOST:.ssh/config
ssh $DHOST "chmod -R 700 ~/.ssh"
```

## Configure the system

``` shell
bash <(curl -s https://raw.githubusercontent.com/shepner/proxmox-docker/master/update-scripts.sh)

~/update.sh

~/scripts/setup/userConfig.sh
~/scripts/setup/systemConfig.sh
~/scripts/setup/nfs.sh
~/scripts/setup/smb.sh
~/scripts/setup/docker.sh
```

-----




# docker-ubuntu

## Installation

VM setup in Proxmox:

[10.12. Managing Virtual Machines with qm](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#_managing_virtual_machines_with_span_class_monospaced_qm_span)

``` shell
# Create the VM

VMID=100
qm create $VMID \
  --name d01 \
  --sockets 1 \
  --cores 20 \
  --ostype l26 \
  --memory 1024000 \
  --ide2 nas-data1-iso:iso/ubuntu-20.04.1-live-server-amd64.iso,media=cdrom \
  --scsi0 nas-data1-vm:$VMID/vm-$VMID-disk-0.qcow2,discard=on,size=256G,ssd=1 \
  --scsihw virtio-scsi-pci \
  --bootdisk scsi0 \
  --net0 virtio,bridge=vmbr0,firewall=1 \
  --onboot 1 \
  --numa 0

# shrink the resulting image
# https://pve.proxmox.com/wiki/Shrink_Qcow2_Disk_Files
mv /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2 /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig
qemu-img convert -O qcow2 -c /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2
rm /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig
```

install Ubuntu 20.04 the usual way.

provide a static IP address

install OpenSSH

## Fix the UID

First set the permissions of the home dir:

``` shell
sudo chown -R 1001 /home/`id -un`
```

Then change the UID accodingly in the passwd files:

``` shell
sudo vipw
```

Finally, logout and back in again

## Setup ssh keys

Do this from the local workstation:

``` shell
DHOST=d01
ssh-copy-id -i ~/.ssh/shepner_rsa.pub $DHOST

scp ~/.ssh/shepner_rsa $DHOST:.ssh/shepner_rsa
scp ~/.ssh/shepner_rsa.pub $DHOST:.ssh/shepner_rsa.pub
scp ~/.ssh/config $DHOST:.ssh/config
ssh $DHOST "chmod -R 700 ~/.ssh"
```

## Configure the system

``` shell
git clone https://github.com/shepner/docker-ubuntu.git

cd ~/docker-ubuntu/setup
chmod 774 *.sh

./userConfig.sh
./systemConfig.sh
./nfs.sh
./docker.sh
```
