#!/bin/sh
echo "kill all avs processes"

pkill wakeWordAgent

pkill java

pkill npm
