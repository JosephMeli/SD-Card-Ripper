#!/bin/bash



#*******************************************************************************
#         Program Name:  Mount Drives and Copy To Directory
#
#                           Author: Joseph Meli
#                             OS: Ubuntu 16.04
#
# Purpose:
# The program first checks for ROOT, the program must be run as root this because
# the sudo commans times out after 15 mins of running so root privileges will
# never time out. The Mount() function looks for dev/diks by-path. The path
# it is looking for is the all usb devices and the firs partions of those devices
# Then will make a new directory in mnt folder with the name of the:
# /dev/disk/by-path/*-usb-*-part1 ... this is to make easy when creating the
# directories. Then the contents on all thos drives will be mount to their new
# coresponding folder in mnt.  The next function is copy() this will have a
# designated file path to dump the contents to. The varibale name for that is
# ($fpath). This functions uses rysnc to copy the info over. rsync takes three
# parameters of function flags, the source, the destination. I use the folder
# name from the variable each in the for loop and then know i want the contents
# in the only the DCIM folder so this /each/DCIM/ is my source path. Then this
# particular instance is copying to an external 8 TB drive
#*******************************************************************************
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
