## Mars

Mars is a chkconfig and LSB-capable init script which can be used to automatically create a swapfile on an EC2 instance if one does not already exist. It supports Ubuntu and RedHat derivative OSes like Oracle Linux, CentOS and others. If ephemeral disk is present, it will create the swapfile there. If not, or if the OS is an unsupported type, it will use /.

## Installation

Simply install in `/etc/init.d`. Then:

## Ubuntu
````
update-rc.d aws-swap-init defaults
````

## RedHat derivatives
````
chkconfig --add aws-swap-init
chkconfig aws-swap-init on
````

## Testing 

You can test to see if the script worked via you should get an output when checking the EC2 instance that looks similar to this:

````[ec2-user ~]$ lsblk
NAME  MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
xvda1 202:1    0    8G  0 disk /
xvda3 202:3    0  896M  0 disk [SWAP]
[ec2-user ~]$ swapon -s
Filename                                Type            Size    Used    Priority
/dev/xvda3                              partition       917500  0       -1
````
