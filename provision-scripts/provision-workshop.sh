#!/bin/bash

# contains functions called in this script
source ./_provision-scripts.lib

create_hosts()
{
  # setup active gate
  createhost active-gate

  # workshop VMs with easyTravel
  createhost ez
  createhost ez-docker
}

setup_workshop_config()
{
    # this scripts will add workshop config like tags, dashboard, MZ
    # need to change directories so that the generated monaco files
    # are in the right folder
    cd  ../workshop-config
    ./setup-workshop-config.sh
    cd ../provision-scripts
}

echo ""
echo "=========================================="
echo "Provisioning workshop resources"
echo "Starting: $(date)"
echo "=========================================="

create_hosts
create_azure_service_principal
setup_workshop_config

echo ""
echo "============================================="
echo "Provisioning workshop resources COMPLETE"
echo "End: $(date)"
echo "============================================="
echo ""