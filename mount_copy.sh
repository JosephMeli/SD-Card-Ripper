#!/bin/bash
#************************************************#
#               mount_copy.sh                    #
#           written by Joseph Meli               #
#             October 21, 2016                   #
#                                                #
#      Functions for mounting and copying to     #
#             desired file location              #
#************************************************#

FLAGS="$1"
PATH= "$2"
srcpath="/DCIM/"

# Run as root, of course.
amIRoot(){
  "$(whoami)" != 'root' && (echo you are using a non-privileged account; exit 1
}

Mount(){
  for each in /dev/disk/by-path/*-usb-*-part1; do
    echo "MOUNTING -----> $each"\r;
    mntdir="$(basename "$each")"
    mkdir mnt/"$(basename "$each")";
    mount "$each" mnt/"$(basename "$each")";
  done
  echo "Mounting Completed"

}

copy(){
 for each in mnt/*; do
     echo "COPYING -----> $each"\r;
     echo "$PATH"
     rsync -rav "${each}${srcpath}"* "$PATH"
     sync
   done
}

if [[ "$FLAGS" = "-m" ]]; then
  amIRoot;
  Mount
elif [[ "$FLAGS" = "-c" ]]; then
  amIRoot;
  copy;
elif [[ "$FLAGS" = "-mc" ]]; then
  amIRoot;
  Mount; copy;
else
  echo "ERROR: mount_copy file has no commands found"
fi
}
exit
