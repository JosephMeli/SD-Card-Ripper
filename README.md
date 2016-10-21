

#SD-Ripper


## Filename: rip.sh -> Main Driver
run using:
<<<<<<< HEAD
$  ./rip.sh [option] [absolute file path]

### Usage:
=======
$ sh rip.sh [option] [absolute file path]

### Purpose:
 This program is a driver for the mount_copy and unmount_clean scripts. The
 driver processes the command line flags and then calls the correct function
 Usage:
>>>>>>> d6fef9710a31bac603af9d250c859410016a4627
 sh rip.sh [option]
 options:
 * -m :calls mount function from mount_copy.sh
 * -c :calls copy function from mount_copy.sh
 * -mc or -cm:calls mount  and copy functions from mount_copy.sh
 * -u:calls unmount function from unmount_clean.sh
 * -x: calls the clean function from unmount_clean.sh
 * -ux or -xu: calls the unmount and clean function from unmount_clean.sh

<<<<<<< HEAD
##Functions:

### unmount():
 Loops through the mounted point and unmounting all things that are mounted
 within the created directories.

### clean():
 This will loop through the mount point and checks
 if the individual directory is empty. If empty then will remove that directory from
 the mount point.  

### amIRoot():
This will exit the program if they are not root. This is for the ability to
copy over long periods of time without having to type password again.

### Mout():
This will loop through all drives located by-path on /dev/disk/by-path/*-usb-*-part1.
=======

## Filename: unmount_clean.sh

###Purpose:
 The way these functions work is by first looping through the mounted point
 and unmounting all things that are mounted within the created directories.
 The second function is clean(), this will loop through the mount point and checks
 if the individual directory is empty. If empty then will remove that directory from
 the mount point.  

## Filename: mount_copy.sh:

###Purpose:
There are 3 functions in this file. First is the amIRoot() function which will
exit the program if they are not root. This is for th ability to copy over long
periods of time without having to type password again. The next function Mout(),
will loop through all drives located by-path on /dev/disk/by-path/*-usb-*-part1.
>>>>>>> d6fef9710a31bac603af9d250c859410016a4627
So its by path to all recognizable exfat devices and the first partition of those
devices. Then will create a new directory for each drive named exactly how your
computer names it. Then the contents of each drive will be mounted to the exact same
corresponding folder by name. The mount point is a pre-made folder in this repository
<<<<<<< HEAD
called mnt.

### copy():
Will loop through all the contents of the the directories in the mnt folder as
well as go to there /DCIM/ directory.And only copy that folder to a user defined
destination.  This process happens with rysnc a command that works like rysnc
takes three possible arguments. first will be optional flags depending on what
you  want to sync, the second is source you are copying from and the final is
the destination.
=======
called mnt. The last function is copy() which will loop through all the contents
of the the directories in the mnt folder as well as go to there /DCIM/ directory.
And only copy that folder to a user defined destination.  This process happens with
rysnc a command that works like rysnc takes three possible arguments. first will be
optional flags depending on what you  want to sync, the second is source you are
copying from and the final is the destination.
>>>>>>> d6fef9710a31bac603af9d250c859410016a4627
