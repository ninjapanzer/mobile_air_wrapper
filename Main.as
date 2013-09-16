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
            html.width = stage.stageWidth;
            html.height = stage.stageHeight;
            html.load(urlReq); 
            addChild(html);
        }
    }
}