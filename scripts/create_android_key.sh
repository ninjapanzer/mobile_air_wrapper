#!/bin/sh

FLEX_LOC=runtimes/flex_sdk_4.6/bin
AIR_LOC=runtimes/AdobeAIRSDK/bin
KEY_LOC=keys/android

$FLEX_LOC/adt -certificate -validityPeriod 25 -cn SelfSigned 1024-RSA $KEY_LOC/selfSigned.pfx Apangea%123