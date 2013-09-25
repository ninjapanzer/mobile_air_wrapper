package {
  import flash.display.*;
  import flash.events.*;
  import flash.geom.Rectangle;
  import flash.media.StageWebView;

  public class blank extends Sprite {

    public var webView:StageWebView = new StageWebView();
    private var stag:Stage;

    public function blank():void{
      //Main(this.stage);
    }

    public function Main(_stage:Stage):void {
      this.stag = _stage;
      WebStage("http://boiling-fortress-9689.herokuapp.com/whereload.json");

    }

    public function WebStage(loc:String):void
    {
      //logger.debug("Loading Web View");
      stag.align = StageAlign.TOP_LEFT;
      stag.scaleMode = StageScaleMode.EXACT_FIT;
      webView.stage = this.stag;
      //webView.addEventListener("resize", resizeHandler);
      //webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChange);
      //webView.dispatchEvent(new Event(Event.RESIZE));
      //webView.addEventListener(Event.COMPLETE, onWebViewLoaded);
      //logger.info("Setting up Click Event Listener");
      //stage.addEventListener(MouseEvent.CLICK, stageClick);
      //webView.dispatchEvent(new MouseEvent(MouseEvent.CLICK));

      webView.viewPort = new Rectangle( 0, 0, stag.stageWidth, stag.stageHeight );
      webView.loadURL( loc );                               
      //logger.debug("Finished Loading Web View");
    }
  }
}