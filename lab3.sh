#!/bim/bash

#./Lab3Clear.sh

#1
awk -F: '{print  "user " $1 " has id " $3}' /etc/passwd > work3.log

#2
chage -l root | head -1 >> work3.log

#3
awk -F: 'ORS="," {print$1}' /etc/group >> work3.log
echo -e "\n" >> work3.log

#4
echo "Be careful!" > /etc/skel/readme.txt

#5
useradd -p 12345678 u1

#6
groupadd g1

#7
usermod -a -G g1 u1

#8
id u1 >> work3.log

#9
usermod -a -G g1 user

#10
grep '^g1:' /etc/group | cut -d ':' -f4 >> work3.log

#11
usermod -s /usr/bin/mc u1

#12
useradd -p 87654321 u2

#13
mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log

#14
chown -R u1:u2 /home/test13
chmod 640 -R /home/test13
chmod 550 /home/test13

#15
mkdir /home/test14
chmod +t /home/test14
chown u1:u1 /home/test14

#16
cp /bin/nano /home/test14/nano
chown u1:u1 /home/test14/nano
chmod u+s /home/test14/nano
