package components.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.graphics.codec.PNGEncoder;
	
	 public class ByteArrayUtil{
	
	 	 	
 		 public function ByteArrayUtil(){}
  
 		 public static function getByteArrayFrom(view:DisplayObject,addLogo:Boolean=false):ByteArray{
 		 	  if(addLogo){
				  var c:Canvas = view as Canvas;
				  var logo:Image = c.getChildByName('nimr') as Image;
	 		 	  logo.visible = true;	
//	 		 	  logo.alpha = 1.0;
	 		 	  logo.alpha = .6;
 		 	  }	
 		 	  
 			  var bitmapData:BitmapData = new BitmapData( view.width, view.height, false, 0xFFFFFF );
   			  bitmapData.draw( view );
   			  
   			  if(addLogo){
	   			  logo.visible = false;
   			  }
   			  
  			  var encoder:PNGEncoder = new PNGEncoder();
  			  
   			  return encoder.encode( bitmapData );
   			  
 		 	  trace(" [encoderInfo::PNGEncoder] The screenshot has been saved to.."); 
 		 }
	}
}