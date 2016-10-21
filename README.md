

#rip


## Filename: rip.sh -> Main Driver
run using:
$ sh rip.sh [option]

### Purpose:
 This program is a driver for the mount_copy and unmount_clean scripts. The
 driver processes the command line flags and then calls the correct function
 Usage:
 sh rip.sh [option]
 options:
 * -m :calls mount function from mount_copy.sh
 * -c :calls copy function from mount_copy.sh
 * -mc or -cm:calls mount  and copy functions from mount_copy.sh
 * -u:calls unmount function from unmount_clean.sh
 * -x: calls the clean function from unmount_clean.sh
 * -ux or -xu: calls the unmount and clean function from unmount_clean.sh


## Filename: unmount_clean.sh

###Purpose:
 The current process in which the unmount() function executes is by scanning the
 contents of all sub folders mounted with in test and then one by one unmounting
 them. Once they are successfully unmounted then The clean() function will remove
 all the folders in Test folder so Development environment is clean.

## Filename: mount_copy.sh:

###Purpose:
  The program first checks for ROOT, the program must be run as root this because
  the sudo commands times out after 15 mins of running so root privileges will
  never time out. The Mount() function looks for dev/diks by-path. The path
  it is looking for is the all usb devices and the first partition of those devices
  Then will make a new directory in test folder with the name of the:
  /dev/disk/by-path/*-usb-*-part1 ... this is to make easy when creating the
  directories. Then the contents on all thos drives will be mount to their new
  corresponding folder in test.  The next function is copy() this will have a
 designated file path to dump the contents to. The variable name for that is
 ($fpath). This functions uses rysnc to copy the info over. rsync takes three
 parameters of function flags, the source, the destination. I use the folder
 name from the variable each in the for loop and then know i want the contents
 in the only the DCIM folder so this /each/DCIM/ is my source path. Then this
 particular instance is copying to an external 8 TB drive.
