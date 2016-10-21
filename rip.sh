#!/bin/bash

#************************************************#
#                   rip.sh                       #
#           written by Joseph Meli               #
#             October 21, 2016                   #
#                                                #
#       Main Driver for SD ripper functions      #
#************************************************#

#-----------------------------------------------------------------#
# Usage:                                                           #
# sh rip.sh [option]                                              #
# options:                                                        #
# -m                                                              #
#   :calls mount function from mount_copy.sh                      #
# -c                                                              #
#   :calls copy function from mount_copy.sh                       #
# -mc or -cm                                                      #
#   :calls mount  and copy functions from mount_copy.sh           #
# -u                                                              #
#   :calls unmount function from unmount_clean.sh                 #
# -x                                                              #
#   : calls the clean function from unmount_clean.sh              #
# -ux or -xu                                                      #
#   : calls the unmount and clean fucntion from unmount_clean.sh  #
#-----------------------------------------------------------------#

FLAGS="$1"
PATH="$2"
# TODO this is broken, need to fix situation when user doesnt type a flag
#but user types a filepath. What if user types a flag but no file path
if [[ "$PATH" = "" -o "$PATH" = " " ]]; then
  echo "need an absolute file path for secon command line argument"
  exit 1
elif [[ "$FLAGS" = "" -o "$FLAGS" = " " ]]; then
  echo DEFAULT: Mount and Copy
  sh mount_copy.sh -mc ~/;
fi
#Mount
if [[ "$FLAGS" = "-m" ]]; then
  echo Mount
  sh mount_copy.sh -m;
#Mount and Copy
elif [[ "$FLAGS" = "-mc" -o "$FLAGS" = "-cm" ]]; then
  echo Mount and Copy
  sh mount_copy.sh -mc;
#Copy
elif [[ "$FLAGS" = "-c" ]]; then
  echo Copy
  sh mount_copy.sh -c
# Unmount
elif [[ "$FLAGS" = "-u" ]]; then
    echo Unmount
    sh unmount_clean.sh -u
# Unmount and Clean
elif [[ "$FLAGS" = "-ux" -o "$FLAGS" = "-xu" ]]; then
    echo Unmount and Clean
    sh unmount_clean.sh -ux
# Clean
elif [[ "$FLAGS" = "-x" ]]; then
    echo Clean
    sh unmount_clean.sh -x
elif [[ "$FLAGS" = "-h" ]]; then
    cat help.txt
else
    echo "ERROR: Rip can't process command line arguments"
fi
exit 1
