#!/bin/bash

LOGFILE='/tmp/start-ez-travel-docker.log' 
APP_SCRIPTS_PATH=/home/workshop/azure-eztravel/app-scripts
START_TIME="$(date)"

printf "\n\n***** Init Log ***\n" > $LOGFILE 2>&1
{ date ; apt update 2>/dev/null; whoami ; } >> $LOGFILE ; sudo chmod 777 $LOGFILE

printf "\n\n***** Deleting /tmp/weblauncher.log ***\n" >> $LOGFILE 2>&1
rm -f /tmp/weblauncher.log

printf "\n\n***** Calling stop-ez-travel-docker.sh ***\n" >> $LOGFILE 2>&1
sudo $APP_SCRIPTS_PATH/stop-ez-travel-docker.sh

sudo docker-compose -f "$APP_SCRIPTS_PATH/docker-compose.yaml" up -d

END_TIME="$(date)"
printf "\n\n" >> $LOGFILE 2>&1
printf "\n\nSTART_TIME: $START_TIME     END_TIME: $END_TIME" >> $LOGFILE 2>&1
