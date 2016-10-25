#!/bin/bash
#************************************************#
#                   rip.sh                       #
#           written by Joseph Meli               #
#             October 21, 2016                   #
#                                                #
#              SD Ripper Script                  #
#************************************************#

FLAGS="$1"
DEST="$2"
mntpoint="mnt/"
srcpath="/DCIM/"
# Run as root, of course.
amIRoot(){
  if [[ "$id -u" != "0" ]]; then
    echo "welcome master."
  else
    echo "you are using a non-privileged account"; exit 1
   fi
}
Mount(){
  for each in /dev/disk/by-path/*-usb-*-part1; do
    echo "MOUNTING -----> $each"\r;
    mntdir="$(basename "$each")"
    mkdir "$mntpoint""$(basename "$each")";
    mount "$each" "$mntpoint""$(basename "$each")";
  done
  echo "Mounting Completed"
}
copy(){
 for each in "$mntpoint"*; do
     echo "COPYING -----> $each"\r;
     echo "$DEST"
     echo "$each"
     rsync -rav "$each""$srcpath"* "$DEST"
     sync
   done
}
unmount(){
  for each in "$mntpoint"*; do
      echo "UNMOUNTING -----> $each"\r;
      umount "$each";
  done
  echo "Unmounting Completed"
}
# will ask user if they are sure then want to delete before rm is called
clean(){
  read -p "Are you sure [y/n]? " -n 1 -r
  echo " "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    for each in "$mntpoint"*; do
         rm -rf "$each";
          echo "removed $each"
    done;
  else
      echo "Wise decsion, can never be too careful"
  fi
}
#check if second cammad line argument is null
if [ "$DEST" == "" ] || [ "$DEST" == " " ]; then
  echo "need an absolute file path for secon command line argument"
  exit 1
elif [ "$FLAGS" == "" ] || [ "$FLAGS" == " " ]; then
  echo DEFAULT: Mount and Copy
  amIRoot; Mount; copy;
#Mount
elif [[ "$FLAGS" == "-m" ]]; then
  echo Mount
  amIRoot; Mount;
#Mount and Copy
elif [ "$FLAGS" == "-mc" ] || [ "$FLAGS" == "-cm" ]; then
  echo Mount and Copy
  amIRoot; Mount; copy;
#Copy
elif [[ "$FLAGS" == "-c" ]]; then
  echo Copy
  amIRoot; copy;
# Unmount
elif [[ "$FLAGS" == "-u" ]]; then
    echo Unmount
    amIRoot; unmount;
# Unmount and Clean
elif [ "$FLAGS" == "-ux" ] ||  [ "$FLAGS" == "-xu" ]; then
    echo Unmount and Clean
    amIRoot; unmount; clean;
# Clean
elif [[ "$FLAGS" == "-x" ]]; then
    echo Clean
    clean;
#help or man
elif [[ "$FLAGS" == "-h" ]]; then
    cat help.txt
# checks for is FLAGS is a path to a file or directory
elif [  -d "$FLAGS" ] || [ -f "$FLAGS" ]; then
    "$DEST" = "$FLAGS"
    amIRoot; Mount; copy;
else
    echo "ERROR: Rip can't process command line arguments"
    exit 1
fi
