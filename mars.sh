#!/bin/sh

DEFAULTSIZE=524288

start () {

    ISSWAP=`/bin/cat /proc/meminfo | /bin/grep SwapTotal | /usr/bin/awk '{print $2}'`
    if [ $ISSWAP -ne 0 ]
    then
        exit 0
    fi

    
    if [ -f /etc/system-release -o -f /etc/redhat-release ]
    then
        OSTYPE="amzn"
    elif [ -f /etc/lsb-release ]
    then
        OSTYPE="ubuntu"
    fi

    case "$OSTYPE" in
        amzn)
            TARGET="/media/ephemeral0"
            ;;
        ubuntu)
            TARGET="/mnt"
            ;;
        *)
            TARGET="/"
            ;;
    esac

    if [ -f $TARGET/swapfile00 ]
    then
        /sbin/swapon $TARGET/swapfile00
        exit 0
    fi
 
    if [ $TARGET = "/" ]
    then
        SIZE=$DEFAULTSIZE
    else
        /bin/mount | grep -q " on $TARGET type "
        if [ $? -eq 0 ]
        then
            SIZE=`/bin/cat /proc/meminfo | /bin/grep "^MemTotal" | /usr/bin/awk '{print $2}'`
        else
            SIZE=$DEFAULTSIZE
            TARGET="/"
        fi
    fi
        
    /bin/dd if=/dev/zero of=$TARGET/swapfile00 bs=1024 count=$SIZE
    /sbin/mkswap $TARGET/swapfile00
    /sbin/swapon $TARGET/swapfile00
}

stop () {
    exit 0
}

case "$1" in
    start)
        $1
        ;;
    stop)
        $1
        ;;
    *)
        echo $"Usage: $0 {start|stop}"
        exit 2
esac
exit $?

# Love ya Mars
