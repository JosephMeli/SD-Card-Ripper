#!/bin/bash
#************************************************#
#               unmount_clean.sh                 #
#           written by Joseph Meli               #
#             October 21, 2016                   #
#                                                #
#      Functions for unmount and cleaning up     #
#             Development environment            #
#************************************************#
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
    rm -r "$each";
  done
}

if [[ "$FLAGS" = "-u" ]]; then
  unmount;
elif [[ "$FLAGS" = "-x" ]]; then
  clean;
elif [[ "$FLAGS" = "-ux" ]]; then
  unmount;clean;
else
  echo "ERROR: unmount_clean file has no commands found"
fi
}
exit
