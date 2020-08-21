# docker-ubuntu

## Installation

VM setup in Proxmox:

[10.12. Managing Virtual Machines with qm](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#_managing_virtual_machines_with_span_class_monospaced_qm_span)

``` shell
# this is just a placeholder

VMID=200
qm create $VMID -ide0 local-lvm:4 -net0 bridge=vmbr0 -cdrom nas-data1-iso:iso/ubuntu-20.04.1-live-server-amd64.iso
qm set $VMID --name: d01
qm set $VMID --ostype: l26
# CPU
qm set $VMID --sockets: 1
qm set $VMID --cores: 24
qm set $VMID --numa: 0
# RAM
qm set $VMID --memory: 102400
# Disk
qm set $VMID --scsihw: virtio-scsi-pci
qm set $VMID --scsi0: nas-data2-vm:100/vm-$VMID-disk-0.qcow2,discard=on,size=256G,ssd=1
qm set $VMID --bootdisk: scsi0
# Other
qm set $VMID --onboot: 1
qm set $VMID --agent 1

# shrink the resulting image
# https://pve.proxmox.com/wiki/Shrink_Qcow2_Disk_Files
mv /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2 /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig
qemu-img convert -O qcow2 -c /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2
rm /mnt/nas/data2/vm/images/$VMID/vm-$VMID-disk-0.qcow2.orig
```

install Ubuntu 20.04 the usual way.

provide a static IP address

install OpenSSH

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
