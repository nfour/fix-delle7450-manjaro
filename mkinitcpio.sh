#! /bin/bash

backupDir="./backup"

if [ ! -d "$backupDir" ]; then
    mkdir "$backupDir"
fi

input="$1"
presetFile="${input:-linux41}"
configFile="/etc/mkinitcpio.conf"
cat $configFile > backup/mkinitcpio.conf

echo "Adding shutdown to mkinitcpio $configFile with preset $presetFile"

if [ ! -f $presetFilePath ]; then
    echo "$presetFilePath not found"
    exit
fi

if ! grep --silent "^HOOKS=.*\bshutdown\b" "$configFile"
then
    sudo sed -i 's/\(HOOKS="\)/\1shutdown /' "$configFile"
    sudo mkinitcpio -p "$presetFile"
else
    echo "'shutdown' already in $configFile, exiting..."
    exit
fi
