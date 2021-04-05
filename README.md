# Overview

The repo contains the setup and learner scripts to support [this Azure and Dynatrace workshop](http://azure-modernize-workshop.alliances.dynatracelabs.com/).

<img src="dt-azure.png" width="400"/> 

# Repo Structure

1. `provision-scripts/` - If not done in advance by the workshop instructor, this folder contains a script for a learner to enter in information such as Dynatrace URL and Azure subscription. This information then read by the scripts and other script then provisions and sets up the workshop Azure compute resources.
1. `app-scripts/` - These scripts are called by the scripts in `provision-scripts/` folder to install workshop sample applications.  A learner generally would not run these directly. 
1. `workshop-config/` - If not done in advance by the workshop instructor, this folder contains the script to setup the Dynatrace configuration for the learners Dynatrace tenant.
1. `learner-scripts/` - This folder contains the scripts a learner would use in workshop labs.

See the README files in the subfolders for additional details.

# Typical Usage

A learner would already have a Dynatrace tenant and Azure subscription.  Then using the Azure Cloud Shell, they would provision the workshop following these steps:
* `git clone https://github.com/dt-alliances-workshops/azure-eztravel.git` 
* `cd azure-eztravel/provision-scripts/`
* `./input-credentials.sh`
* `./provision-workshop.sh`
* `cd ../learner-scripts`
* `./show-app-urls.sh`
