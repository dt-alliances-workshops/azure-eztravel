#!/bin/bash

HOST_TYPE=$1
if [ -z "$HOST_TYPE" ]
then
    echo "Missing HOST_TYPE argument"
    exit 1
fi

APP_SCRIPTS_FULL_PATH=/home/workshop/modernize-workshop-setup/app-scripts

setup_ez() {

    echo "----------------------------------------------------"
    echo "Setup Tools"
    echo "----------------------------------------------------"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-get install -y jq
    
    echo "----------------------------------------------------"
    echo "Install EZtravel Monolith"
    echo "----------------------------------------------------"
    . $APP_SCRIPTS_FULL_PATH/install-ez-travel-monolith.sh
}

setup_ez_docker() {

    echo "----------------------------------------------------"
    echo "Setup Tools"
    echo "----------------------------------------------------"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-get install -y jq
    apt install -y docker-compose
  
    echo "----------------------------------------------------"
    echo "Start EZtravel Docker"
    echo "----------------------------------------------------"
    . $APP_SCRIPTS_FULL_PATH/start-ez-travel-docker.sh
}

case "$HOST_TYPE" in
    "ez") 
        echo "===================================================="
        echo "Setting up: $HOST_TYPE" 
        echo "===================================================="
        setup_ez
        ;;
    "ez-docker") 
        echo "===================================================="
        echo "Setting up: $HOST_TYPE" 
        echo "===================================================="
        setup_ez-docker
        ;;
    *) 
        echo "Invalid HOST_TYPE: $HOST_TYPE"
        exit 1
        ;;
esac

echo "===================================================="
echo "Setup Complete" 
echo "===================================================="
echo ""