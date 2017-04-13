package comp.chart.chartingTool
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.graphics.codec.PNGEncoder;
	
	 public class ByteArrayUtil{
	 	
 		 public function ByteArrayUtil(){}
  
 		 public static function getByteArrayFrom(view:DisplayObject):ByteArray{
// 		 	  Alert.show("encoerInfo:: PNGEncoder. The chart has been saved to xxx"); 
 			  var bitmapData:BitmapData = new BitmapData( view.width, view.height, false, 0xFFFFFF );
   			  bitmapData.draw( view );
  			  var encoder:PNGEncoder = new PNGEncoder();
   			  return encoder.encode( bitmapData );
 		 }
	}
}