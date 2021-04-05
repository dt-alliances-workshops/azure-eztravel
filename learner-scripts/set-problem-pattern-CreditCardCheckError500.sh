#!/bin/bash

PROBLEM_PATTERN=CreditCardCheckError500
ENABLED=$1

source ./_learner-scripts.lib

setProblemPattern $PROBLEM_PATTERN $ENABLED
if [ $? -eq 0 ]; then
    echo ""
    echo "--------------------------------------------------------------------------------------"
    echo "$PROBLEM_PATTERN Description"
    echo "--------------------------------------------------------------------------------------"
    echo "Causes Error in the Booking Service"
    echo "Root cause is Communication plugin could not contact credit card verification application via named pipe"
    echo "in the Booking Service" 
fi