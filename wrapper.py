from Tkinter import *
# this is not complete for testing is only here for persnonal developement/use

import subprocess
#TODO figure out how to pass a string from python to a shell command subprocess
def show_entry_fields():
    myPath  = e1.get()
    print("Destination: %s" % (myPath))

def Mount():
    print "Mounting"
    subprocess.call(['bash rip.sh -m'], shell=True)
def Copy():
    print "Copying"
    myPath  = e1.get()
    subprocess.call(['bash rip.sh -c'], shell=True)
def Unmount():
    print "Unmounting"
    subprocess.call(['bash rip.sh -u'], shell=True)
def Clean():
    print "Cleaning"
    subprocess.call(['bash rip.sh -x'], shell=True)


master = Tk()
Label(master, text="Destination:").grid(row=0, column=0)
master.wm_title("SD-Ripper")

e1 = Entry(master)


e1.grid(row=0, column=1)

Button(master, text='Mount', command=Mount).grid(row=2, column=0, sticky=W, pady=4)
Button(master, text='Copy', command=Copy).grid(row=2, column=1, sticky=W, pady=4)
Button(master, text='Unmount', command=Unmount).grid(row=3, column=0, sticky=W, pady=4)
Button(master, text='Clean', command=Clean).grid(row=3, column=1, sticky=W, pady=4)
Button(master, text='Quit', command=master.quit).grid(row=4, column=0, sticky=W, pady=4)
Button(master, text='Show', command=show_entry_fields).grid(row=4, column=1, sticky=W, pady=4)

mainloop( )
