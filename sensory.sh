#!/bin/sh
echo "start trigger"

cd ~/avs-sample/samples/wakeWordAgent/src
./wakeWordAgent -e sensory &
