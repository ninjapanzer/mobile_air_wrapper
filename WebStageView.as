package  {
    import flash.display.MovieClip;
    import flash.media.StageWebView;
    import flash.geom.Rectangle;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.desktop.NativeApplication;
                
    public class WebStageView extends MovieClip{

        private var webView:StageWebView = new StageWebView();
                                
        public function StageWebViewExample() 
        {
            webView.stage = this.stage;
            webView.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
            webView.loadURL( "http://review.thinkthroughmath.com" );
                                                
            stage.addEventListener( KeyboardEvent.KEY_DOWN, onKey );
        }
                                
        private function onKey( event:KeyboardEvent ):void
        {
            if( event.keyCode == Keyboard.BACK && webView.isHistoryBackEnabled )
            {
                trace("Back.");
                webView.historyBack();
                event.preventDefault();
            }

            if( event.keyCode == Keyboard.SEARCH && webView.isHistoryForwardEnabled )
            {
                trace("Forward.");
                webView.historyForward();
            }
        }
    }
}