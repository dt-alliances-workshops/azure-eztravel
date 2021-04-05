#!/bin/bash

PROBLEM_PATTERN=CPULoadJourneyService
ENABLED=$1

source ./_learner-scripts.lib

setProblemPattern $PROBLEM_PATTERN $ENABLED
if [ $? -eq 0 ]; then
    echo ""
    echo "--------------------------------------------------------------------------------------"
    echo "$PROBLEM_PATTERN Description"
    echo "--------------------------------------------------------------------------------------"
    echo "This plugin causes additional high CPU usage when searching for a journey.  "
    echo "It is executed a number of times, regardless whether the requested journey is found or not"
fi