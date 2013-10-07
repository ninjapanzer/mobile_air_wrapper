package com.ttm.mobile.util{
  import  flash.system.Capabilities;

  public class ShortcutCapabilities{

    public static function isAndroid():Boolean{
      return (Capabilities.version.substr(0,3) == "AND");
    }

    public static function isIOS():Boolean{
      return (Capabilities.version.substr(0,3) == "IOS");
    }

    public static function isMobile():Boolean{
        return (isAndroid() || isIOS()); // || isBlackberry()
    }

  }
}