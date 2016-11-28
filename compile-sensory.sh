#!/bin/bash

# This script used to compile wakeWordAgent\src\wakeWordAgent
# Required parts source code and headers for Kitt_Ai and Sensory

# Preconfigured variables
OS=rpi
User=$(id -un)
Group=$(id -gn)
Origin=$(pwd)
Samples_Loc=$Origin/samples
Wake_Word_Agent_Loc=$Samples_Loc/wakeWordAgent
Kitt_Ai_Loc=$Wake_Word_Agent_Loc/kitt_ai
Sensory_Loc=$Wake_Word_Agent_Loc/sensory
External_Loc=$Wake_Word_Agent_Loc/ext

cd $Origin


echo "========== Preparing External dependencies for Wake Word Agent =========="
mkdir $External_Loc/include
mkdir $External_Loc/lib
mkdir $External_Loc/resources

cp $Kitt_Ai_Loc/snowboy/include/snowboy-detect.h $External_Loc/include/snowboy-detect.h
cp $Kitt_Ai_Loc/snowboy/examples/C++/portaudio/install/include/portaudio.h $External_Loc/include/portaudio.h
cp $Kitt_Ai_Loc/snowboy/examples/C++/portaudio/install/include/pa_ringbuffer.h $External_Loc/include/pa_ringbuffer.h
cp $Kitt_Ai_Loc/snowboy/examples/C++/portaudio/install/include/pa_util.h $External_Loc/include/pa_util.h
cp $Kitt_Ai_Loc/snowboy/lib/$OS/libsnowboy-detect.a $External_Loc/lib/libsnowboy-detect.a
cp $Kitt_Ai_Loc/snowboy/examples/C++/portaudio/install/lib/libportaudio.a $External_Loc/lib/libportaudio.a
cp $Kitt_Ai_Loc/snowboy/resources/common.res $External_Loc/resources/common.res
cp $Kitt_Ai_Loc/snowboy/resources/alexa.umdl $External_Loc/resources/alexa.umdl

$Sensory_Loc/alexa-rpi/bin/sdk-license file $Sensory_Loc/alexa-rpi/config/license-key.txt $Sensory_Loc/alexa-rpi/lib/libsnsr.a $Sensory_Loc/alexa-rpi/models/spot-alexa-rpi-20500.snsr $Sensory_Loc/alexa-rpi/models/spot-alexa-rpi-21000.snsr $Sensory_Loc/alexa-rpi/models/spot-alexa-rpi-31000.snsr

cp $Sensory_Loc/alexa-rpi/include/snsr.h $External_Loc/include/snsr.h
cp $Sensory_Loc/alexa-rpi/lib/libsnsr.a $External_Loc/lib/libsnsr.a
cp $Sensory_Loc/alexa-rpi/models/spot-alexa-rpi-31000.snsr $External_Loc/resources/spot-alexa-rpi.snsr

# copy content of ext folder to wakeWordAgent\tst\ext
# probably for testing
mkdir $Wake_Word_Agent_Loc/tst/ext
cp -R $External_Loc/* $Wake_Word_Agent_Loc/tst/ext
cd $Origin

echo "========== Compiling Wake Word Agent =========="
# compile wakeWordAgent
cd $Wake_Word_Agent_Loc/src && cmake . && make -j4

# compile wakeWordAgentTest
# cd $Wake_Word_Agent_Loc/tst && cmake . && make -j4


echo ""
echo '============================='
echo '*****************************'
echo '========= Finished =========='
echo '*****************************'
echo '============================='
echo ""
