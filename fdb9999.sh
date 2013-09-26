#!/bin/sh

#run debugger

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin

$AIR_LOC/../lib/aot/bin/iOSBin/idb -devices
echo "Doing A Thing"
$AIR_LOC/../lib/aot/bin/iOSBin/idb -stopforward 8999
$AIR_LOC/../lib/aot/bin/iOSBin/idb -forward 8999 9999 1
echo "blast it"
$FLEX_LOC/fdb -p 8999