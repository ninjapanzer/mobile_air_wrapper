package com.ttm.mobile{
  import flash.display.*;
  import flash.system.*;
  import flash.html.HTMLLoader;
  import flash.net.URLRequest;
  import flash.filesystem.*;
  import flash.media.StageWebView;
  import flash.geom.Rectangle;
  import flash.events.*;
  import flash.net.*;
  import flash.utils.*;
  import flash.net.URLLoader;

  import mx.utils.ObjectUtil;

  import flash.errors.IllegalOperationError;
  import flash.text.TextField;

  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  import com.ttm.mobile.util.LogWriter;
  import com.ttm.mobile.util.ClassLoader;

  public class Main extends Sprite {

    private var logFile:File = File.documentsDirectory.resolvePath("debug.log")
    private var logger:LogWriter = new LogWriter(logFile);

    private var loader:ClassLoader;
    
    private var webView:StageWebView = new StageWebView();

    public function Main():void {
      logger.debug("Starting");
      logger.info(Capabilities.version.toString());
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
      //stage.align = StageAlign.TOP_LEFT;
      //stage.scaleMode = StageScaleMode.EXACT_FIT;
      logger.info(stage.stageWidth.toString())
      webView.addEventListener("resize", resizeHandler);
      webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      webView.addEventListener(Event.COMPLETE, onWebViewLoaded);

      webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
      webView.loadURL( config.location );
      logger.debug("Finished Loading Web View");
    }

    private function onWebViewLoaded(e:Event):void{
      logger.info("WebViewCOmpleted");
      webView.removeEventListener(Event.COMPLETE, onWebViewLoaded);
      //loader = new ClassLoader();
      //loader.addEventListener(ClassLoader.LOAD_ERROR,loadErrorHandler);
      //loader.addEventListener(ClassLoader.CLASS_LOADED,classLoadedHandler);
      //loader.load("Blank.swf");
      //webView.stage = null;
    }

    private function loadErrorHandler(e:Event):void {
        throw new IllegalOperationError("Cannot load the specified file.");
    }

    private function classLoadedHandler(e:Event):void {
        var runtimeClassRef:Class = loader.getClass("Blank");
        var greeter:Object = new runtimeClassRef();
        var domain:ApplicationDomain = loader.getDomain();
        logger.debug(domain.hasDefinition("Blank").toString());

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
      webView.loadURL('javascript:=;');
      var localLoader:URLLoader = new URLLoader();
      localLoader.addEventListener(Event.COMPLETE, function(e:Event) : void {
        var pattern:RegExp = /(swfobject.embedSWF)\(\'(.*?)\'/gi //'
        var matches:Array = e.currentTarget.data.match(pattern)
        logger.debug(matches.length.toString())
        logger.debug(matches.toString())
        if(matches.lenth==1){
          logger.debug(matches[1].match(/'(.*?)'$/gi))
        }
        var numVal:Number = new Date().time;
        var htmllog:File = File.documentsDirectory.resolvePath("pages/"+webView.location.toString().replace(/\//gi, "|")+numVal.toString()+".html")
        var htmlstream:FileStream = new FileStream();
        htmlstream.open(htmllog, FileMode.APPEND);
        htmlstream.writeUTFBytes(e.currentTarget.data);
        htmlstream.close();
      })
      if (webView.location != "about:blank"){
        localLoader.load(new URLRequest(webView.location))
      }
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
