
package components.util{
       
       import flash.display.Bitmap;
       import flash.display.DisplayObject;
       import flash.events.Event;
       import flash.events.IOErrorEvent;
       import flash.events.SecurityErrorEvent;
       
       import mx.controls.Image;
 

       public class AntiAliasingImg extends Image
       {
             public function AntiAliasingImg()
             {
                    super();
             }
             
             override public function load(url:Object=null):void
             {
                    super.load(url);
                    addEventHandlers();
             }
             
             private function completeEventHandler(event:Event):void
             {
                    var content:DisplayObject = this.content as DisplayObject;
                    var bitmap:Bitmap;
                    if(content)
                    {
                           bitmap = content as Bitmap;
                           if( bitmap )
                                 bitmap.smoothing=true;
                    }
                    removeEventHandlers();
             }
             
             override public function set source(value:Object):void
             {
                    var bitmap:Bitmap = value as Bitmap;
                    if( bitmap )
                    {
                           bitmap.smoothing = true;   
                    }
                    super.source = value;
             }
             
             private function ioEventHandler(event:IOErrorEvent):void
             {
                    removeEventHandlers();
             }
             
             private function securityErrorEventHandler(event:SecurityErrorEvent):void
             {
                    removeEventHandlers();
             }
             
             private function addEventHandlers():void
             {
                    this.addEventListener(Event.COMPLETE, completeEventHandler);
                    this.addEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
                    this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorEventHandler);
             }
             
             private function removeEventHandlers():void
             {
                    this.removeEventListener(Event.COMPLETE, completeEventHandler);
                    this.removeEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
                    this.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorEventHandler);
             }
       }
}
