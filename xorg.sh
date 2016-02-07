#! /bin/bash

backupDir="./backup"

if [ ! -d "$backupDir" ]
then
    mkdir "$backupDir"
fi

#
# Edit pacman.conf
#

#cat /etc/pacman.conf > test/pacman.conf
cat /etc/pacman.conf > backup/pacman.conf

pacmanFile='test/pacman.conf'

echo 'Locking Xorg to xorg117 in pacman.conf'

# Checks if doesnt have definition
if ! grep --silent "\[xorg117\]" $pacmanFile
then
    # Adds this right above [core]
    sed -i '/\[core\]/i\
[xorg117]\
SigLevel = Optional TrustAll\
Server   = http://catalyst.wirephire.com/repo/xorg117/$arch\
' $pacmanFile

fi
