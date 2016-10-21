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
LOG_DIR=/var/log
ROOT_UID=0     # Only users with $UID 0 have root privileges.
LINES=50       # Default number of lines saved.
E_XCD=86       # Can't change directory?
E_NOTROOT=87   # Non-root exit error.

fpath="/media/joemeli/Seagate Backup Plus Drive/dump"
srcpath="/DCIM/"

# Run as root, of course.
amIRoot(){
  if [ "$UID" -ne "$ROOT_UID" ]; then
    echo "Must be root to run this script."
    exit $E_NOTROOT
  fi
}

Mount(){
  for each in /dev/disk/by-path/*-usb-*-part1; do
      echo "MOUNTING -----> $each"\r;
    mntdir="$(basename "$each")"
    mkdir mnt/"$(basename "$each")";
    sudo mount "$each" mnt/"$(basename "$each")";
  done
  echo "Mounting Completed"

}

copy(){
 for each in mnt/*; do
     echo "COPYING -----> $each"\r;
     echo "$fpath"
     rsync -rav "${each}${srcpath}"* "$fpath"
     sync
   done
}

# TODO:fix -> mount and copy are allowed by common user needs to be root user
if [ "$FLAGS" = "-m" ]; then
  Mount
elif [ "$FLAGS" = "-c" ]; then
  amIRoot;
  copy;
elif [ "$FLAGS" = "-mc" ]; then
  amIRoot;
  Mount; copy;
else
  echo "ERROR: mount_copy file has no commands found"
fi
}
exit
