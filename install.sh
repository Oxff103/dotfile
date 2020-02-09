#!/bin/bash
#
# Create user on virtual box

PASSWD="blackarch"

ping -c 1 1.1.1.1 >/dev/null || exit

DISKPARTS=$(lsblk -nrpo "name,type,mountpoint" | awk '$2=="part"&&length($3)==0{print $1}')

[[ ! -z "${DISKPARTS}" ]] || exit

for DISK in ${DISKPARTS}
do
    echo "Find the disk ${DISK} and mount on home."
    mount ${DISk} /home >/dev/null || exit
    break
done

for USERNAME in `ls /home/ | grep -v 'lost+found'`
do
    echo "Create user ${USERNAME} ing...\n"
    useradd -M -G wheel,tor -s /bin/bash -p ${PASSWD} ${USERNAME}
done

i3-msg exit
