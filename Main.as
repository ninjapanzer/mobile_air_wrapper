package {
  import flash.display.*;
  import flash.html.HTMLLoader;
  import flash.net.URLRequest;
  import flash.filesystem.*;
  import flash.media.StageWebView;
  import flash.geom.Rectangle;
  import flash.events.*;
  import flash.net.*;
  import flash.net.URLLoader;

  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

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
      loader.load(new URLRequest(configURL));
    }

    private function configureListeners(dispatcher:IEventDispatcher):void {
      dispatcher.addEventListener(Event.COMPLETE, completeHandler);
    }
     private function completeHandler(event:Event):void {
      var loader:URLLoader = URLLoader(event.target);
      var config:Object = JSON.parse(loader.data);
      WebStage(config);
      logger.debug("Config Loaded");
    }

    public function WebStage(config:Object):void
    {
      logger.debug("Loading Web View");
      webView.stage = this.stage;
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      webView.addEventListener("resize", resizeHandler);
      webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      webView.addEventListener(Event.COMPLETE, onWebViewLoaded);

      webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
      webView.loadURL( config.location );
      logger.debug("Finished Loading Web View");
    }

    private function onWebViewLoaded(e:Event):void{
      logger.info("WebViewCOmpleted");
      var loader:Loader = new Loader();
      var lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, gameLoadComplete);
      loader.load(new URLRequest("blank.swf"), lc);
      webView.stage = null;
    }

    private function gameLoadComplete(e:Event):void{

      //Start at http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/system/ApplicationDomain.html#includeExamplesSummary

      var someblank:Class = ApplicationDomain.currentDomain.getDefinition("blank") as Class;
      var myBlank:someblank = someblank(e.target.content);
      logger.debug("loading Complete for external swf");
      var li:LoaderInfo = LoaderInfo(e.target)
      var loader:Loader = li.loader

      //var _myVariable:* = e.target.content;
      logger.info("Triggering new stage");
      //_myVariable.Main(this.stage);

      logger.info("Triggering new stage");
      webView.stage = this.stage;

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