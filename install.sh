#!/bin/bash
#
# Create user on virtual box

PASSWD="blackarch"

ping -c 1 1.1.1.1 >/dev/null || exit

DISKPART=`lsblk -nrpo "name,type" | awk '$2=="part"{print $1}'`
# echo ${DISPART}
# exit 5

if [ ! -z ${DISPART} ]
    echo "Find the disk ${DISPART} and mount on home."
    mount ${DISKPART} /home >/dev/null || exit
else
    echo "Not found any disk. exit !"
    exit
fi

for USERNAME in `ls /home/ | grep -v 'lost+found'`
do
    echo "Create user ${USERNAME} ing...\n"
    useradd -M -G wheel,tor -s /bin/bash -p ${PASSWD} ${USERNAME}
done

i3-msg exit
