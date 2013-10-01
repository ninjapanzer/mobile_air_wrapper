package {
  import flash.display.*;
  import flash.events.*;
  import flash.geom.Rectangle;
  import flash.media.StageWebView;

  public class Blank extends Sprite {

    public var anotherWebView:StageWebView = new StageWebView();
    private var stag:Stage;

    public function blank():void{
      //Main(this.stage);
    }

    public function anotherMain(_stage:Stage):void {
      this.stag = _stage;
      anotherWebStage("http://boiling-fortress-9689.herokuapp.com/whereload.json");

    }

    public function getText():String{
      return "HAPPY PANTS";
    }

    public function anotherWebStage(loc:String):void
    {
      //logger.debug("Loading Web View");
      stag.align = StageAlign.TOP_LEFT;
      stag.scaleMode = StageScaleMode.EXACT_FIT;
      anotherWebView.stage = this.stag;
      //webView.addEventListener("resize", resizeHandler);
      //webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      //webView.dispatchEvent(new Event(Event.RESIZE));
      //webView.addEventListener(Event.COMPLETE, onWebViewLoaded);
      //logger.info("Setting up Click Event Listener");
      //stage.addEventListener(MouseEvent.CLICK, stageClick);
      //webView.dispatchEvent(new MouseEvent(MouseEvent.CLICK));

      anotherWebView.viewPort = new Rectangle( 0, 0, stag.stageWidth, stag.stageHeight );
      anotherWebView.loadURL( loc );                               
      //logger.debug("Finished Loading Web View");
    }
  }
}
