package {
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

  import flash.system.SecurityDomain;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import mx.controls.SWFLoader;

  import LogWriter;

  public class Main extends Sprite {
    [Embed(source="experiments/testMotion.swf")]
      private var GameLevel:Class;

    private var logFile:File = File.documentsDirectory.resolvePath("debug.log")
    private var logger:LogWriter = new LogWriter(logFile);
    
    private var webView:StageWebView = new StageWebView();

    public function Main():void {
      logger.debug("Starting");
      var startOrientation:String = stage.orientation; 
      stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChangeListener);
      loadConfig();
      logger.debug("Done");
    }

    private function orientationChangeListener(e:StageOrientationEvent):void
      {
        logger.info("Rotating");
         if (e.afterOrientation == StageOrientation.DEFAULT || e.afterOrientation ==  StageOrientation.UPSIDE_DOWN)
         {
           e.preventDefault();
         }
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
      this.WebStage(config);
      logger.debug("Config Loaded");
    }

    public function doConfig():void{
      //Alert.show("This is an Alert!!!");
      //Alert.show("Object submitted", "...", Alert.OK);
    }

    public function SWFStage(config:String):void{

      logger.debug("Loading the SWF Stage");
      var swfloader:Loader = new Loader();
      var url:URLRequest = new URLRequest("experiments/testMotion.swf");
      logger.debug(url.url);
      var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
      swfloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSwfLoaded);
      swfloader.contentLoaderInfo.addEventListener(Event.INIT, function():void {logger.debug("INIT")});
      swfloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function():void {logger.debug("Progressing");});
      swfloader.load(url);
      addChild(swfloader);
    }

    private function onSwfLoaded(e:Event):void{
      logger.debug("SWFLoaded");
      //addChild((e.target);
      //webView.stage = stage;
    }

    public function WebStage(config:Object):void
    {
      logger.debug("Loading Web View");
      webView.stage = this.stage;
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      webView.addEventListener("resize", resizeHandler);
      webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      webView.dispatchEvent(new Event(Event.RESIZE));
      webView.addEventListener(Event.COMPLETE, onWebViewLoaded);
      logger.info("Setting up Click Event Listener");
      stage.addEventListener(MouseEvent.CLICK, stageClick);
      webView.dispatchEvent(new MouseEvent(MouseEvent.CLICK));

      webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
      webView.loadURL( config.location );                               
      logger.debug("Finished Loading Web View");
    }

    private function onWebViewLoaded(e:Event):void{
      logger.info("WebViewCOmpleted");
      webView.stage = null;
      SWFStage("thing");
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