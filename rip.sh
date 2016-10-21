#!/bin/bash

#************************************************#
#                   rip.sh                       #
#           written by Joseph Meli               #
#             October 21, 2016                   #
#                                                #
#              SD Ripper Script                  #
#************************************************#

FLAGS="$1"
PATH= "$2"
mntpoint= "mnt/"
srcpath="/DCIM/"

# Run as root, of course.
amIRoot(){
  "$(whoami)" != 'root' && (echo you are using a non-privileged account); exit 1
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
     echo "$PATH"
     rsync -rav "${each}${srcpath}"* "$PATH"
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

clean(){
for each in "$mntpoint"*; do
  if [ "$(ls -A "$each")" ]; then
     echo "$each is not Empty"
   else
     echo "$each is Empty"
     rm -r "$each";
      echo "removed $each"
    fi
  done
}
#check if second cammad line argument is null
if [[ "$PATH" = "" -o "$PATH" = " " ]]; then
  echo "need an absolute file path for secon command line argument"
  exit 1
elif [[ "$FLAGS" = "" -o "$FLAGS" = " " ]]; then
  echo DEFAULT: Mount and Copy
  amIRoot; Mount; copy;
#Mount
elif [[ "$FLAGS" = "-m" ]]; then
  echo Mount
  amIRoot; Mount;
#Mount and Copy
elif [[ "$FLAGS" = "-mc" -o "$FLAGS" = "-cm" ]]; then
  echo Mount and Copy
  amIRoot; Mount; copy;
#Copy
elif [[ "$FLAGS" = "-c" ]]; then
  echo Copy
  amIRoot; copy;
# Unmount
elif [[ "$FLAGS" = "-u" ]]; then
    echo Unmount
    amIRoot; unmount;
# Unmount and Clean
elif [[ "$FLAGS" = "-ux" -o "$FLAGS" = "-xu" ]]; then
    echo Unmount and Clean
    amIRoot; unmount; clean;
# Clean
elif [[ "$FLAGS" = "-x" ]]; then
    echo Clean
    clean;
#help or man
elif [[ "$FLAGS" = "-h" ]]; then
    cat help.txt
# if there is no provided flag only a file path then call default flags
# and use that file path.
elif [[ "$FLAGS" = "/*" ]]; then
    "$PATH" = "$FLAGS"
    sh mount_copy.sh -mc "$PATH"
else
    echo "ERROR: Rip can't process command line arguments"
fi
exit 1
