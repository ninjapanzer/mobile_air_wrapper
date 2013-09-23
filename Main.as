package {
  import flash.display.MovieClip;
  import flash.display.*;
  import flash.html.HTMLLoader;
  import flash.net.URLRequest;
  import flash.filesystem.*;
  import flash.media.StageWebView;
  import flash.geom.Rectangle;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import flash.desktop.NativeApplication;
  import flash.events.*;
  import flash.net.*;
  import flash.net.URLLoader;
  import flash.events.IOErrorEvent;

  import LogWriter;

  public class Main extends Sprite {

    private var logFile:File = File.documentsDirectory.resolvePath("debug.log")
    private var logger:LogWriter = new LogWriter(logFile);
    
    private var webView:StageWebView = new StageWebView();

    public function Main():void {
      logger.debug("Starting");
      loadConfig();
      logger.debug("Done");
    }

    public function loadConfig():void{
      var loader:URLLoader = new URLLoader();
      var configURL:String = "http://boiling-fortress-9689.herokuapp.com/whereload.json";
      configureListeners(loader);
      logger.debug("Loading Config from " + configURL)
      var request:URLRequest = new URLRequest(configURL);
      loader.load(request);
    }

    private function configureListeners(dispatcher:IEventDispatcher):void {
      dispatcher.addEventListener(Event.COMPLETE, completeHandler);
    }
     private function completeHandler(event:Event):void {
      var loader:URLLoader = URLLoader(event.target);
      var config:Object = JSON.parse(loader.data);
      doConfig();
      trace(config.location);
      this.WebStage(config);
      logger.debug("Config Loaded")
    }

    public function doConfig():void{
      //Alert.show("This is an Alert!!!");
      //Alert.show("Object submitted", "...", Alert.OK);
    }

    public function WebStage(config:Object):void
    {
      logger.debug("Loading Web View");
      webView.stage = this.stage;
      stage.align = StageAlign.TOP_LEFT;
      //stage.scaleMode = StageScaleMode.EXACT_FIT;
      webView.addEventListener(Event.RESIZE, resizeHandler);
      webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      webView.dispatchEvent(new Event(Event.RESIZE));
      logger.info("Setting up Click Event Listener");
      stage.addEventListener(MouseEvent.CLICK, stageClick);
      webView.dispatchEvent(new MouseEvent(MouseEvent.CLICK));

      webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
      webView.loadURL( config.location );                               
      logger.debug("Finished Loading Web View");
    }

    private function stageClick(event:MouseEvent):void{
      logger.info("Click Happened");
    }

    private function onLocationChange(e:Event):void{
      logger.info("New URL " + webView.location);
    }

    private function resizeHandler(e:Event):void{
      logger.info("Resize Event Triggered");
      if(stage.stageWidth > stage.stageHeight){
        logger.info("Resize Horizontal Triggered");
        //orientHorizontal();     //Write a custom function that repositions your display objects for horizontal viewing
      }
      else{
        logger.info("Resize Vertical Triggered")
         //orientVertical();       //Write a custom function that repositions your display objects for vertical viewing
       }
    }
  }
}