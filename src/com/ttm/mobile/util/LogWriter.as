package com.ttm.mobile.util{
  import flash.filesystem.File;
  import flash.filesystem.FileStream;
  import flash.filesystem.FileMode;

  public class LogWriter{
    private var stream:FileStream = new FileStream();
    private var mobile:Boolean = ShortcutCapabilities.isMobile()

    public function LogWriter(initialFile:File = null){
      if(!mobile){
        if(initialFile == null){
        initialFile = File.documentsDirectory.resolvePath("main.log");
      }
      stream.open(initialFile, FileMode.APPEND);
      }
    }

    public function debug(message:String = "No Message"):void{
      if(!mobile){
        sendDebug(message);
      }
    }

    public function info(message:String = "No Message"):void{
      if(!mobile){
        sendInfo(message);
      }
    }

    public function warning(message:String = "No Message"):void{
      if(!mobile){
        sendWarning(message);
      }
    }

    private function timeStamp():String{
      return new Date().toString();
    }

    private function messageHeader(type:String):String{
      return type + ":" + timeStamp()+ ": ";
    }

    private function sendDebug(message:String = "No Message"):void{

      stream.writeUTFBytes(messageHeader("DEBUG") + message +"\n");
    }

    private function sendInfo(message:String = "No Message"):void{
      stream.writeUTFBytes(messageHeader("INFO") + message +"\n");
    }

    private function sendWarning(message:String = "No Message"):void{
      stream.writeUTFBytes(messageHeader("WARNING") + message +"\n");
    }

    public function close():void{
      if (!mobile){
        debug("Closed File");
        stream.close();
      }
    }

  }
}