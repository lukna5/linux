#!/bin/bash
rm -rf ~/test
rm -r ~/list*
rm man.txt
rm -rf ~/man.dir

cd ~

#1
mkdir test

cd test/

#2
numDir=0;
numHideDir=0
for NEXT in /etc/*; do
	if [[ -d "$NEXT" ]]; then
		echo "$NEXT/" >> list.txt
		let numDir=$numDir+1
	else
		echo "$NEXT" >> list.txt
	fi;
done;

for NEXT in /etc/.*; do
	if [[ -d "$NEXT" && "$NEXT" != "/etc/." && "$NEXT" != "/etc/.." ]]; then
		echo "$NEXT/" >> list.txt
	else
		echo "$NEXT" >> list.txt
		let numHideDir=$numHideDir+1
	fi;
done;

#3
echo $numDIr >> list.txt
echo $numHideDir >> list.txt

#4
cd ~/test/
mkdir links

#5
cd links/
ln ~/test/list.txt list_hlink

#6
ln -s ~/test/list.txt list_slink

#7
echo "hlink"
ls -l ~/test/links/list_hlink | cut -d " " -f2
echo "list.txt"
ls -l ~/test/list.txt | cut -d " " -f2
echo "slink"
ls -l ~/test/links/list_slink | cut -d " " -f2

#8
wc -l ~/test/list.txt | cut -d " " -f1 >> ~/test/links/list_hlink

#9
if cmp ~/test/links/list_hlink ~/test/links/list_slink;
then
	echo "YES"
else
	echo "NO"
fi;

#10
cd ~/test/
mv list.txt list1.txt

#11
if cmp ~/test/links/list_hlink ~/test/links/list_slink;
then
	echo "YES"
else
	echo "NO"
fi;

#12
cd ~/
ln ~/test/list1.txt list_link

#13
find /etc/ -name "*.conf" > ~/list_conf

#14
find /etc/ -maxdepth 1 -name "*.d" -type d > ~/list_d

#15
cat ~/list_conf ~/list_d > ~/list_conf_d

#16
mkdir ~/test/.sub/

#17
cp ~/list_conf_d ~/test/.sub/

#18
cp -b ~/list_conf_d ~/test/.sub/

#19
find ~/test/ -name "*"

#20
man man > ~/man.txt

#21
split -b 1024 ~/man.txt "man.txt_copy_"

#22
mkdir ~/man.dir

#23
mv man.txt_copy_* man.dir

#24
cat ~/man.dir/man.txt_copy_* > ~/man.dir/man.txt
rm ~/man.dir/man.txt_copy_*

#25
if cmp ~/man.txt ~/man.dir/man.txt;
then
	echo "YES"
else
	echo "NO"
fi;

#26
echo "SomethingStart" >> ~/temp.txt
cat ~/man.txt >> ~/temp.txt
cat ~/temp.txt > ~/man.txt
echo "TextEnd" >> ~/man.txt
rm ~/temp.txt

#27
diff -u ~/man.txt ~/man.dir/man.txt > ~/man_diff.txt

#28
mv ~/man_diff.txt ~/man.dir/

#29
patch ~/man.dir/man.txt ~/man.dir/man_diff.txt

#30
if cmp ~/man.txt ~/man.dir/man.txt;
then
	echo "YES"
else
	echo "NO"
fi;
