#!/bin/bash

#*******************************************************************************
#         Program Name:  Unmount Drives and Clean Directory
#
#                           Author: Joseph Meli
#                             OS: Ubuntu 16.04
#
# Purpose:
# The current process in which the unmount() function executes is by scanning the
#contents of all sub folders mounted with in mnt and then one by one unmounting
# them. Once they are Sucessfully unmounted then The clean() function will remove
# all the folders in Test folder so Development enviroment is clean.
#*******************************************************************************
FLAGS="$1"

unmount(){
  for each in mnt/*; do
      echo "UNMOUNTING -----> $each"\r;
      sudo umount "$each";
  done
  echo "Unmounting Completed"
}

clean(){
  for each in mnt/*; do
    echo "$each";
    sudo rm -r "$each";
  done
}

if [ "$FLAGS" = "-u" ]; then
  unmount;
elif [ "$FLAGS" = "-x" ]; then
  clean;
elif [ "$FLAGS" = "-ux" ]; then
  unmount;clean;
else
  echo "ERROR: unmount_clean file has no commands found"
fi
}
exit
