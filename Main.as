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

  import flash.errors.IllegalOperationError;
  import flash.text.TextField;

  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  import LogWriter;
  import ClassLoader;

  public class Main extends Sprite {

    private var logFile:File = File.documentsDirectory.resolvePath("debug.log")
    private var logger:LogWriter = new LogWriter(logFile);

    private var loader:ClassLoader;
    private var tf:TextField = new TextField();
    
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
      loader = new ClassLoader();
      loader.addEventListener(ClassLoader.LOAD_ERROR,loadErrorHandler);
      loader.addEventListener(ClassLoader.CLASS_LOADED,classLoadedHandler);
      loader.load("blank.swf");
      webView.stage = null;
    }

    private function loadErrorHandler(e:Event):void {
        tf.text = "Load failed";
        throw new IllegalOperationError("Cannot load the specified file.");
    }

    private function classLoadedHandler(e:Event):void {
        var runtimeClassRef:Class = loader.getClass("blank");
        var greeter:Object = new runtimeClassRef();

        greeter.anotherMain(this.stage);
    }

    private function gameLoadComplete(e:Event):void{

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