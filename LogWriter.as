package {
  import flash.filesystem.*;

  public class LogWriter{
    private var stream:FileStream = new FileStream();

    public function LogWriter(initialFile:File = null){
      if(initialFile == null){
        initialFile = File.documentsDirectory.resolvePath("main.log");
      }
      stream.open(initialFile, FileMode.APPEND);
    }

    private function timeStamp():String{
      return new Date().toString();
    }

    private function messageHeader(type:String):String{
      return type + ":" + timeStamp()+ ": ";
    }

    public function debug(message:String = "No Message"):void{
      stream.writeUTFBytes(messageHeader("DEBUG") + message +"\n");
    }

    public function info(message:String = "No Message"):void{
      stream.writeUTFBytes(messageHeader("INFO") + message +"\n");
    }

    public function warning(message:String = "No Message"):void{
      stream.writeUTFBytes(messageHeader("WARNING") + message +"\n");
    }

    public function close():void{
      debug("Closed File");
      stream.close();
    }

  }
}