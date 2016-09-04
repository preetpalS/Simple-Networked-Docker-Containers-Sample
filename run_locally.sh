#!/bin/bash

# Necessary for making Ruby (and bundler) available in script for me
source ~/.bash_profile

# Set environment variables
export RANDOM_NUMBER_SERVICE_BIND=0.0.0.0
export RANDOM_NUMBER_SERVICE_PORT=3031
export WEB_APP_BIND=0.0.0.0
export WEB_APP_PORT=3030

trap "kill_descendents" SIGINT SIGTERM EXIT

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Start random number generation service
eval "cd ${SCRIPT_DIR}/RandomNumberServiceContainer/app/ && bundle exec rake" &

sleep 1

# Start web app service
eval "cd ${SCRIPT_DIR}/WebAppContainer/app/ && bundle exec rake" &

sleep 1

function kill_descendents() {
    # Reset signals and send SIGTERM to whole process group
    trap - SIGINT SIGTERM EXIT && kill -- -$$

    sleep 3
}

while :
do
    read -r -p "Press q to quit: " input
    case $input in
        q) exit 0;;
        *) echo "Please select from the only avaiable option 'q'...";;
    esac
done
