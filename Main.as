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
  import mx.controls.Alert;

  public class Main extends MovieClip {
    
    private var webView:StageWebView = new StageWebView();

    public function Main():void {
      trace("HI");
      loadConfig();
      //var html:WebStageView = new WebStageView();
      //var html:HtmlStage = new HtmlStage();
      //var fileStream:FileStream = new FileStream();
      //var userfile:File = File.documentsDirectory.resolvePath("AIR_log.txt");
      //fileStream.open(userfile, FileMode.WRITE);
      //var htmlLoader:HTMLLoader = html.load();
      //addChild(htmlLoader);
      //fileStream.close();
    }

    public function loadConfig():void{
      var loader:URLLoader = new URLLoader();
      configureListeners(loader);
      var request:URLRequest = new URLRequest("http://boiling-fortress-9689.herokuapp.com/whereload.json");
      loader.load(request);
    }

    private function configureListeners(dispatcher:IEventDispatcher):void {
      dispatcher.addEventListener(Event.COMPLETE, completeHandler);
    }
     private function completeHandler(event:Event):void {
      var loader:URLLoader = URLLoader(event.target);
      var config:Object = JSON.parse(loader.data);
      trace(config.location);
      this.StageWebViewExample(config);
    }

    public function StageWebViewExample(config:Object):void
    {
      webView.stage = this.stage;
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      stage.addEventListener(Event.RESIZE, resizeHandler);
      stage.dispatchEvent(new Event(Event.RESIZE));

      webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
      webView.loadURL( config.location );
                                          
      //stage.addEventListener( KeyboardEvent.KEY_DOWN, onKey );
    }
    public function resizeHandler(e:Event):void{
       if(stage.stageWidth > stage.stageHeight){
        //orientHorizontal();     //Write a custom function that repositions your display objects for horizontal viewing
       }
       else{
         //orientVertical();       //Write a custom function that repositions your display objects for vertical viewing
       }
    }
  }
}