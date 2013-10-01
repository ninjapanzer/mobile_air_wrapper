package{
  import flash.display.Loader;
  import flash.errors.IllegalOperationError;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  public class ClassLoader extends EventDispatcher {
      public static var CLASS_LOADED:String = "classLoaded";
      public static var LOAD_ERROR:String = "loadError";
      private var loader:Loader;
      private var swfLib:String;
      private var request:URLRequest;
      private var loadedClass:Class;

      public function ClassLoader() {

          loader = new Loader();
          loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
          loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
          loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
      }

      public function load(lib:String):void {
          swfLib = lib;
          request = new URLRequest(swfLib);
          var context:LoaderContext = new LoaderContext();
          context = new LoaderContext(false, ApplicationDomain.currentDomain, null);
          loader.load(request,context);
      }

      public function getClass(className:String):Class {
          try {
              return loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
          } catch (e:Error) {
            trace(e.getStackTrace());
            trace(e.toString());
              throw new IllegalOperationError(className + " definition not found in " + swfLib);
          }
          return null;
      }

      public function hasClass(className:String):Boolean{
         return loader.contentLoaderInfo.applicationDomain.hasDefinition(className);
      }

      public function getLoader():Loader{
        return loader;
      }

      public function getDomain():ApplicationDomain{
        return loader.contentLoaderInfo.applicationDomain;
      }

      private function completeHandler(e:Event):void {
          dispatchEvent(new Event(ClassLoader.CLASS_LOADED));
      }

      private function ioErrorHandler(e:Event):void {
          dispatchEvent(new Event(ClassLoader.LOAD_ERROR));
      }

      private function securityErrorHandler(e:Event):void {
          dispatchEvent(new Event(ClassLoader.LOAD_ERROR));
      }
  }
}
