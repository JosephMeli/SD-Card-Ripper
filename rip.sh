#!/bin/bash

#*******************************************************************************
#                           Program Name:  Rip
#
#                           Author: Joseph Meli
#                             OS: Ubuntu 16.04
#
# Purpose:
# This program is a driver for the mount_copy and unmount_clean scripts. The
# driver processes the command line flas and then calls the correct fucntion
# Usage:
# sh rip.sh [option]
# options:
# -m
#   :calls mount function from mount_copy.sh
# -c
#   :calls copy function from mount_copy.sh
# -mc or -cm
#   :calls mount  and copy functions from mount_copy.sh
# -u
#   :calls unmount function from unmount_clean.sh
# -x
#   : calls the clean function from unmount_clean.sh
# -ux or -xu
#   : calls the unmount and clean fucntion from unmount_clean.sh
#*******************************************************************************
# TODO create a default flag call for is user doesent pick any flag
FLAGS="$1"
#Mount
if [ "$FLAGS" = "-m" ]; then
  echo Mount
  sh mount_copy.sh -m;
#Mount and Copy
elif [ "$FLAGS" = "-mc" -o "$FLAGS" = "-cm" ]; then
  echo Mount and Copy
  sh mount_copy.sh -mc;
#Copy
elif [ "$FLAGS" = "-c" ]; then
  echo Copy
  sh mount_copy.sh -c
# Unmount
elif [ "$FLAGS" = "-u" ]; then
    echo Unmount
    sh unmount_clean.sh -u
# Unmount and Clean
elif [ "$FLAGS" = "-ux" -o "$FLAGS" = "-xu" ]; then
    echo Unmount and Clean
    sh unmount_clean.sh -ux
# Clean
elif [ "$FLAGS" = "-x" ]; then
    echo Clean
    sh unmount_clean.sh -x
elif [ "$FLAGS" = "-h" ]; then
    cat help.txt
else
    echo "ERROR: Rip can't process command line arguments"
fi
exit
