package{
  import flash.display.Sprite;
  import flash.html.HTMLLoader;
  import flash.net.URLRequest;

  public class HtmlStage
    {
        public function load():HTMLLoader
        {
            var html:HTMLLoader = new HTMLLoader();
            var urlReq:URLRequest = new URLRequest("http://review.thinkthroughmath.com/");
            html.width = 500;
            html.height = 500;
            html.scrollH = 1000;
            html.scrollV = 2000;
            html.load(urlReq); 
            return html;
        }
    }
}