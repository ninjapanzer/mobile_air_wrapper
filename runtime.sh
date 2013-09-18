RUNTIME_ARCHIVE="https://docs.google.com/a/thinkthroughmath.com/file/d/0B6jQ5p6g8RtodVVuYUwtQmhWVFk/edit?usp=sharing"

FLEX_LOC=runtimes/flex_sdk_4.6/bin
AIR_LOC=runtimes/AdobeAIRSDK/bin

FLEX=`which $FLEX_LOC/amxmlc`
AIR=`which $AIR_LOC/adl`

if [[ "$FLEX" == "" || "$AIR" == "" ]]; then
  echo "\nLooking for FLEX in $FLEX_LOC"
  echo "Looking for AIR in $AIR_LOC"
  echo "\nSorry Couldn't find the runtimes to build and execute this app"
  echo "What I am looking for is 'amxmlc' and 'adl' from FLEX and AIR respectively"
  echo "\nIf you don't know what I am talking about please Download\n$RUNTIME_ARCHIVE\nand extract it into the runtimes directory\n"
  echo "\nThe Directory structure should looke like"
  echo "| <Project Root>"
  echo " \\"
  echo " | runtimes"
  echo "  \\"
  echo "  | <AirSDK>"
  echo "  | <FlexSDK>"
  echo "\nFor extra configuration edit the FLEX_LOC and AIR_LOC of this file\n\n\n"
fi