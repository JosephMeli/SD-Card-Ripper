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
mntpoint= "mnt/"


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
