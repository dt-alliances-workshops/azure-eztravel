# Overview

These scripts install the Dynatrace EZ travel sample application on both the non-Docker-Compose and Docker-Compose deployment options.

# Prereqs

1. This repo was git cloned to `/home/workshop/azure-eztravel`
1. The non-Docker-Compose VM is running Docker
1. The Docker-Compose VM is running Docker and has Docker-Compose installed

# Usage

1. EZ Travel non-Docker-Compose
    * The `install-ez-travel-monolith.sh` installs EZ travel and the call `start-ez-travel-monolith.sh`.  
    * An installation log is written to `/tmp/install-ez-travel-monolith.log` 
    * The `start-ez-travel-monolith.sh` will call the `stop-ez-travel-monolith.sh` first, then it will start the application.  The start script also will start a Docker container that servers as proxy servers to EZ travel to export standars port 80. 
    * A startup log is written to `/tmp/start-ez-travel-monolith.log`
    * EZ travel runs on port 80, REST endpoint on 8019 and admin console runs on port 8094

1. EZ Travel Docker-Compose
    * The `start-ez-travel-docker.sh` will call the `stop-ez-travel-docker.sh` first, then it will start the application.
    * A startup log is written to `/tmp/start-ez-travel-docker.log`
    * EZ travel runs on port 80
