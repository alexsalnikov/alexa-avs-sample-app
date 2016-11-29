#!/bin/sh
echo "start trigger"

cd ~/Desktop/alexa-avs-sample-app/samples/wakeWordAgent/src
./wakeWordAgent -e sensory &
