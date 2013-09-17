package {
    import flash.display.Sprite;
    import flash.html.HTMLLoader;
    import flash.net.URLRequest;

    public class Main extends Sprite
    {
        public function Main():void
        {
            var html:HTMLLoader = new HTMLLoader();
            var urlReq:URLRequest = new URLRequest("http://lms.thinkthroughmath.com/");
            trace(stage.stageWidth);
            trace(stage.stageHeight);
            trace("HI");
            html.width = 500;
            html.height = 500;
            html.scrollH = 1000;
            html.scrollV = 2000;
            html.load(urlReq); 
            addChild(html);
        }
    }
}