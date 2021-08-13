#!/bin/sh

nmcli device wifi list
echo "Enter WIFI name: "
read NAME

echo "Enter password for $NAME: "
read -s PASS

nmcli device wifi connect $NAME password $PASS
