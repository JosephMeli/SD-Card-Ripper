#!/bin/bash

for each in /dev/disk/by-path/*-usb-*; do
	if [[ $each == *-part1 ]]; then
		continue
	fi
	echo; echo; echo;
	echo "$each"
	#new partition table, new full size partition, ntfs/exfat type
	echo -en "o\nn\np\n1\n\n\nt\n7\n" | fdisk "$each"
	mkfs.exfat "$each"-part1
	
	if [[ $? != 0 ]]; then
		echo Failed. 
		echo "$each" $?
	fi
done
