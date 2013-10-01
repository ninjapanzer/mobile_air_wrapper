package{
  import flash.display.*;
  import LogWriter;
  import flash.filesystem.*;
  public class Runnable extends Sprite{

    private var logFile:File = File.documentsDirectory.resolvePath("debug.log")
    private var logger:LogWriter = new LogWriter(logFile);

    public function Runnable():void{
      logger.debug("inside Runnable");
    }

    public function blank():void{
    }

    public function Main(_stage:Stage):void{
    }

    public function WebStage(loc:String):void{
    }
  }
}