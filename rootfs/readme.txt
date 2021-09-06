## Building root filesystem

```bash
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-arm64-root.tar.xz
sudo apt-get install qemu-user-static
mkdir -p temp
sudo tar -xpf ./focal-server-cloudimg-arm64-root.tar.xz -C temp
sudo cp -b /etc/resolv.conf temp/etc/resolv.conf
sudo cp /usr/bin/qemu-aarch64-static temp/usr/bin/

sudo chroot temp

apt update
apt full-upgrade
dpkg-reconfigure cloud-init
apt purge plymouth* fwupd* snapd* popularity-contest
apt autoremove

touch /etc/cloud/cloud-init.disabled
echo 'datasource_list: [ None ]' | tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
dpkg-reconfigure -f noninteractive cloud-init
chown root:root /var/spool/cron/*
rm /etc/systemd/system/sysinit.target.wants/multipathd.service
rm /etc/systemd/system/multipath-tools.service
rm /etc/systemd/system/sockets.target.wants/multipathd.socket
rm /usr/lib/systemd/system/systemd-remount-fs.service

# $ sudo nano /etc/rc.local
# #!/bin/bash
# dhclient
# exit 0
# $ sudo chmod 755 /etc/rc.local
# $ sudo systemctl enable rc-local
# $ sudo systemctl restart rc-local
# $ sudo systemctl status rc-local

## OR

# ln -s /lib/systemd/system/systemd-networkd.service /etc/systemd/system/dbus-org.freedesktop.network1.service
# cat /etc/systemd/network/20-dhcp.network
# [Match]
# Name=eth*
# [Network]
# DHCP=ipv4

echo ubuntu-firefly > /etc/hostname
echo "127.0.0.1 ubuntu-firefly" >> /etc/hosts

useradd -s '/bin/bash' -m -G adm,sudo firefly
passwd firefly
passwd root
exit

dd if=/dev/zero of=rootfs.img bs=1973190656 count=1
sudo mkfs.ext4 rootfs.img
mkdir -p rootfs_mnt
sudo mount rootfs.img rootfs_mnt/
sudo cp -rfp temp/*  rootfs_mnt/
sudo umount rootfs_mnt/
e2fsck -p -f rootfs.img
resize2fs  -M rootfs.img
```
