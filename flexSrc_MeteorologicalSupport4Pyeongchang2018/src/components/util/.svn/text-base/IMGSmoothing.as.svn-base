package components.util
{
    import flash.display.*;
    import flash.events.*;
    
    import mx.controls.*;

    public class IMGSmoothing extends Image
    {
        private var targetImage:Image;

        public function IMGSmoothing(){
        	super();
            targetImage = new Image();
            targetImage.addEventListener(Event.COMPLETE, sourceChanged);
            targetImage.addEventListener(IOErrorEvent.IO_ERROR, IOErrHandler);
            targetImage.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrHandler);
        }

		//have2del..
        private function progressEventHandler(event:ProgressEvent) : void
        {
        	trace('progressEventHandler')
            if (event.bytesLoaded == event.bytesTotal){
            }
            if (event.bytesTotal.toString() != "0"){
                this.visible = true;
            }
            return;
        }

        private function sourceChanged(event:Event) : void{
            var NIMRBitmapDataObj:BitmapData = new BitmapData(targetImage.content.width, targetImage.content.height);
            NIMRBitmapDataObj.draw(targetImage.content);
			var NIMRImage:Bitmap = new Bitmap(NIMRBitmapDataObj);
			NIMRImage.smoothing = true;
            this.source = NIMRImage;
            this.visible = true;
            removeEventHandlers();
        }
        
        public function changeSource(url:String) : void{
            targetImage.load(url);
//            trace("changeSource accomplished.. ["+url+"]");
        }



        private function IOErrHandler(event:IOErrorEvent) : void{
            this.source = new Image();
            this.visible = false;
            trace("IOErrHandler...");
            removeEventHandlers();
        }


		 private function securityErrHandler(event:SecurityErrorEvent):void{
		 	trace("securityErrHandler...");
	         removeEventHandlers();
	     }

		 private function removeEventHandlers():void{
             this.removeEventListener(Event.COMPLETE, sourceChanged);
             this.removeEventListener(IOErrorEvent.IO_ERROR, IOErrHandler);
             this.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrHandler);
         }
    }
}
