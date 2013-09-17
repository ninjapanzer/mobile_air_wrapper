AIR Wrapper Setup

#Getting Started

1. Download the runtimes for youself from adobe
   * Flex SDK
   * AIR SDK
* Or Download the zip for the project
   *  [Runtimes](https://docs.google.com/a/thinkthroughmath.com/file/d/0B6jQ5p6g8RtodVVuYUwtQmhWVFk/edit?usp=sharing)
* The runtimes should be placed in the projects 'runtimes' folder
  * AIR SDK should be in 'runtimes/AdobeAIRSDK'
  * FLEX SDK should be in 'runtimes/flex_sdk_<version>' so for example 'runtimes/flex_sdk_4.6'
* Test running the application with provided shell script
  * You may have to give execute permissions to the script 
  >    sudo chmod +x CompileAndRunAS3-as.sh
  * run with
  >    ./CompileAndRunAS3-as.sh
  * If everything is good you should see the app load. Otherwise it will prompt you to help you figure out what is wrong. Likely the biggest issue will be that your SDK folders are not named the same as the script expects. If that is t he case edit the 'CompileAndRunAS3-as.sh' file to reflect the correct locations of the binaries.
  >    Update:
  >
  >    FLEX_LOC=runtimes/flex_sdk_4.6/bin
  >
  >    AIR_LOC=runtimes/AdobeAIRSDK/bin
  
#Questions

If you have some questions please let me know pscarrone@thinkthroughmath.com