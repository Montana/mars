## aws-swap-init

aws-swap-init is a chkconfig and LSB-capable init script which can be used to automatically create a swapfile on an EC2 instance if one does not already exist. It supports Ubuntu and RedHat-derivative OSes like Oracle Linux, CentOS and others. If ephemeral disk is present, it will create the swapfile there. If not, or if the OS is an unsupported type, it will use /.

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
