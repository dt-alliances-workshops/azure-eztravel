#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "ERROR: script must be run as root or with sudo"
   exit 1
fi

APP_SCRIPTS_PATH=/home/workshop/azure-eztravel/app-scripts

echo "*** Stopping EasyTravel Docker ***"
sudo docker-compose -f "$APP_SCRIPTS_PATH/docker-compose.yaml" down

echo "*** Stopping EasyTravel Docker Done. ***"