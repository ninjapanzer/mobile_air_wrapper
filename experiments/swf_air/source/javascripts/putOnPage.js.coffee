jQuery ->
  privatefile = air.File.applicationStorageDirectory.resolvePath("something.swf")
  jQuery("#swfContainer").html("WONDERFUN #{privatefile.nativePath}")
  #swfobject.registerObject("myFlashContent", "9.0.0", privatefile.nativePath);
  #swfobject.embedSWF(privatefile.nativePath, "swfContainer", "300", "120", "9.0.0", "swf/expressInstall.swf", flashvars, params, attributes)
  air.trace(jQuery("#swfContainer").html())
  air.trace(jQuery("#myFlashContent").html())
  return