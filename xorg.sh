#! /bin/bash

(( EUID != 0 )) && exec sudo -- "$0" "$@"

backupDir="./backup"

if [ ! -d "$backupDir" ]
then
    mkdir "$backupDir"
fi

#
# Edit pacman.conf
#


pacmanFile='/etc/pacman.conf'
tempPacmanFile='./pacman.conf'

#cat /etc/pacman.conf > test/pacman.conf
cat $pacmanFile > backup/pacman.conf

echo 'Locking Xorg to xorg117 in pacman.conf'

# Checks if doesnt have definition
if ! grep --silent "\[xorg117\]" $pacmanFile
then
    # Adds this right above [core]
    sed '/\[core\]/i\
[xorg117]\
SigLevel = Optional TrustAll\
Server   = http://catalyst.wirephire.com/repo/xorg117/$arch\
' $pacmanFile > "$tempPacmanFile"
    cat "$tempPacmanFile" > "$pacmanFile"
    rm -rf "$tempPacmanFile"
    pacman -Syyuu
else
    echo "Xorg already locked to xorg117"
    echo "Run 'pacman -Syyuu' to force sync"
    exit
fi
