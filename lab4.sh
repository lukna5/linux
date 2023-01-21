#!/bin/bash

#1
dnf groupinstall "Development Tools"

#2
tar -xzvf /mnt/share/bastet-0.43.tgz
sudo yum install boost-devel
sudo yum install ncurses-devel
cd bastet-0.43
make

nano Makefile
#install:
#	cp bastet /usr/bin
#	chmod -R 777 /usr/bin/

make install

#3
dnf list installed > ~/task3.log

#4 
dnf deplist gcc > ~/task4_1.log
rpm -q --whatrequires libgcc > ~/task4_2.log

#5
yum install createrepo
mkdir -p localrepo
cp checkinstall-1.6.2-3.el6.1.x86_64.rpm localrepo/
cd localrepo
yum install createrepo
createrepo ~/localrepo
touch /etc/yum.repos.d/localrepo.repo
echo -e "[localrepo]\nname=localrepo\nbaseurl=file:///root/localrepo/\nenabled=1\ngpgcheck=0" > localrepo.repo

#6
dnf repolist all > ~/task6.log

#7
mkdir repos
mv /etc/yum.repos.d/* allrepos
mv repos/localrepo.repo /etc/yum.repos.d/
dnf list available
dnf -enablerepo=localrepo install checkinstall

#8
cp ~/../linux/fortunes-ru_1.52-2_all.deb ~/fortunes-ru_1.52-2_all.deb

alien -r fortunes-ru_1.52-2_all.deb
rpm -i fortunes-ru-1.52-3.noarch.rpm
dnf list installed | grep "fortunes"

#9
dnf install 'dnf-command(download)'
dnf download nano
dnf install rpmrebuild
rpmrebuild -epn nano #меняем название на newnano

mv /usr/bin/nano /usr/bin/newnano
rpm -i rpmbuild/RPMS/X86_64/newnano-2.3.1-10.el7.x86_64
#newnano работает
