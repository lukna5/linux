#!/bin/bash
rm -f UUID_sda3

#1
fdisk /dev/sda
	n - New
	p - Primary
	3 - Partition
	Default - First section
	+300Mib - Size
	w - Save and esc
#2
sudo blkid /dev/sda3 | cut -d "\"" -f2 > UUID_sda3

#3
mkfs.ext4 -b 4096 /dev/sda3

#4
dumpe2fs -h /dev/sda3

#5
tune2fs -i 2m -C 2 /dev/sda3

#6
mkdir /mnt/newdisk
mount -t ext4 /dev/sda3 /mnt/newdisk

#7
ln -s /mnt/newdisk ~/newdisk_slink

#8
mkdir ~/newdisk_slink/test

#9
dev/sda3 /mnt/newdisk ext4 noexec,noatime 0 0

#10
umount /dev/sda3
fdisk /dev/sda
	d
	3
	n
	p
	3
	default
	+350M
	Dont delete ext4
	w
reboot
resize2fs /dev/sda3
df -h

#11
fsck -n /dev/sda3

#12
mkfs.ext4 /dev/sda4
umount /dev/sda3
mke2fs -o journal_dev /dev/sda4
mke2fs -t ext4 -J device=/dev/sda4 /dev/sda3

#13
umount /dev/sda3
umount /dev/sda4
fdisk /dev/sda
	d
	3
	d
	4
	n
	e
	default
	default
	n
	l 5
	+100M
	l 6
	+100M
	w

#14
pvcreate /dev/sda3 /dev/sda4
vgcreate vg01 /dev/sda3/ /dev/sda4
lvcreate -L190 -n lv01 vg01
mkfs.extr4 /dev/vg01/lv01
mkdir /mnt/supernewdisk
mount /dev/vg01/lv01 /mnt/supernewdisk

#15
mkdir /mnt/share
mount.cifs //10.0.0.212/share /mnt/share -o guest

#16
/root/.smbclient
	username=guest
	password
	domain=WORKGROUP
/etc/fstab
	//10.0.0.212/_share /mnt/share cifs user,ro,credentials=/root/.smbclient 0 0
