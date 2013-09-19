##TTM Mobile with AIR

#Getting Started
###The Build System

1. Download the runtimes for youself from adobe
   * [Flex SDK](http://www.adobe.com/devnet/flex/flex-sdk-download.html)
   * [AIR SDK](http://www.adobe.com/devnet/air/air-sdk-download.html)
* Or Download the zip for the project
   *  [https://docs.google.com/a/thinkthroughmath.com/file/d/0B6jQ5p6g8RtodVVuYUwtQmhWVFk/edit?usp=sharing](https://docs.google.com/a/thinkthroughmath.com/file/d/0B6jQ5p6g8RtodVVuYUwtQmhWVFk/edit?usp=sharing)
* The runtimes should be placed in the projects 'runtimes' folder

		AIR SDK should be in 'runtimes/AdobeAIRSDK'
		FLEX SDK should be in 'runtimes/flex_sdk_<version>' so for example 'runtimes/flex_sdk_4.6'

* Test running the application with provided shell script
  * You may have to give execute permissions to the script 
  
 		$ sudo chmod +x CompileAndRunAS3-as.sh
  
  * run with
  
  		$ ./CompileAndRunAS3-as.sh
  
  * If everything is good you should see the app load. Otherwise it will prompt you to help you figure out what is wrong. Likely the biggest issue will be that your SDK folders are not named the same as the script expects. If that is t he case edit the 'CompileAndRunAS3-as.sh' file to reflect the correct locations of the binaries.
    
    	Update the following fileds in the build script:
    	
    	FLEX_LOC=runtimes/flex_sdk_4.6/bin
    	AIR_LOC=runtimes/AdobeAIRSDK/bin

###The Remote Config App
This guy is on heroku for now as super small sinatra endpoint that returns json. The app is at [http://boiling-fortress-9689.herokuapp.com/whereload.json](http://boiling-fortress-9689.herokuapp.com/whereload.json) The repo for this app is housed at heroku too and is integrated with the mobile apps repo at GitHub via submodule. So to get the submodule up you will need:

1. Request from me to be a collaborator on the app
*  The heroku toolbelt [https://toolbelt.heroku.com/](https://toolbelt.heroku.com/)
*  run:

		$ git submdule init
		$ git submodule update
		
* Now you can push changes back to heroku. But if for some reason the submodules remotes are not configured on a new installation run:

		$ git remote add git@heroku.com:boiling-fortress-9689.git

#Building - Android
###The build process from flex and the ADT tools requires a few steps.
We are going to need a compiled AIR application usually the result of the CompileAndRun command for testing. We will also need a signing for the apk and then we will be pushing the package to either a real device or a simulator.

Lets start out with creating a key. We will do this assuming that you have the runtimes setup and you are in the root of the project. If you are at the same level as the runtimes directory you are in the project root.

######Self Signed Key
		$ runtimes/flex_sdk_4.6/bin/adt -certificate -validityPeriod 25 -cn SelfSigned 1024-RSA selfSigned.pfx pass
		
		The breakdown for this command is:
		$ <flex_runtime>/adt -certificate -validityPeriod <years_valid> -cn SelfSigned 1024-RSA <cerfiticate_name>.pfx <password>

Now that you have a self signed key name selfSigned.pfx at the root of the project you can sign an build a apk for the deployable

######Building Package
		$ runtimes/AdobeAIRSDK/bin/adt -package -target apk -storetype pkcs12 -keystore selfSigned.pfx TTMMobile.apk ttm_mobile-app-as3-as.xml Main.swf
		
		The breakdown for this command is:
		$ <air_sdk>/adt -package -target apk -storetype pkcs12 -keystore <certificate_pfx> <output_apk_name> <application_descriptor_xml> [<files_included_in_content>*]

Now that you have a packaged application with the embedded runtime you can deploy this to your android test environment. You really have two choices here for doing the deployment:

1. use the flex sdk *<project_root>/runtimes/flex_sdk_4.6/lib/android/bin/adb*
2. use the android sdk either *<path_to_android_sdk>/adb*

I prefer to use the android sdk but to save you the time of having to download and install another sdk I will give you the command using flex and you can use that as a pattern for using the android sdk variant 
	
		$ runtimes/flex_sdk_4.6/lib/android/bin/adb -d install ~/workrepos/air_sideload_prototype/HelloWorld.apk
		
		The breakdown for this command is:
		$ <runtime_loc>/adb < -d | -e > install <absolute_path_to_apk>
		The command's first switch can be either -d or -e
		
		-d  references the first android device attached
		-e  references the first running emulator attached
		
#TroubleShooting
If you load the app and recieve a white page. 

*  First check the applications network connection. The wifi at the office is a real mess and it will show connected but will not be able to make any network requests until you power cycle the wifi.
*  Also make sure that the heroku app is pointed to a running instance of apangea. It is possible to deliver a local ip address via the config app so do not assume tha it is pointing to an external source like review.thinkthroughmath.com

#Building - iOS
* TBD

#Questions

If you have some questions please let me know pscarrone@thinkthroughmath.com
