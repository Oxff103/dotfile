#!/bin/bash
#
# Create user on virtual box

ping -c 1 1.1.1.1 >/dev/null || exit

[ -z "$BRANCH" ] && BRANCH="master"
[ -z "$GITRESP" ] && GITRESP="https://github.com/Oxff103/dotfiles.git"

DISKPARTS=$(lsblk -nrpo "name,type,mountpoint" | awk '$2=="part"&&length($3)==0{print $1}')

[[ ! -z "${DISKPARTS}" ]] || exit

for DISK in ${DISKPARTS}
do
    echo "Find the disk ${DISK} and mount on home."
    mount ${DISK} /home >/dev/null || exit
    break
done

USERNAMES=$(ls /home/ | grep -v 'lost+found')

if [ ! -z "${USERNAMES}" ]; then
    for USERNAME in ${USERNAMES}
    do
        echo "Create user ${USERNAME} ing...\n"
        useradd -G wheel,tor -s /bin/bash ${USERNAME}
        passwd ${USERNAME}
    done
else
    USERNAME="blackarch"
    useradd -G wheel,tor -s /bin/bash ${USERNAME}
    passwd ${USERNAME}
fi

# yay -Syy termite xclip

dir=$(mktemp -d)
git clone -b "$BRANCH" --depth 1 "${GITRESP}" "${dir}/Dotfiles" >/dev/null 2>&1 &&
mv ${dir}/Dotfiles /home/${USERNAME}/Dotfiles
# bash install.sh
# i3-msg exit
echo "Install success !! must login user cd Dotfiles exec install.sh"
