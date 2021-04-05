# Overview

This folder contains the scripts a learner would use in workshop labs.

* `show-app-urls.sh` - called the Azure CLI to get the public IPs and outputs the URL to the sample applications
* `set-problem-pattern-XXX.sh` - scripts call the non-Docker-Compose EZ travel REST endpoint to turn on or off the problem pattern.  This script accepts an argument of `true` or `false`.  If nothing passed then `true` is the default value

# Prereqs

Assumes there is credentials files with value such as Dynatrace URL and Azure Subscription located at `/tmp/workshop-credentials.json`.  See the `provision-scripts/input-credentials.sh` for how this file is created.
