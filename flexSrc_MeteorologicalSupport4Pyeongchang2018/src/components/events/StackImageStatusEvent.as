package components.events


{
	import flash.events.Event;
	
	public class StackImageStatusEvent extends Event{
		
		public var zoom:Number;
		public var x:Number;
		public var y:Number;
		public var winWidth:Number;
		public var winHeight:Number;
		
		/**
		 * 	일기도 부분 파일명
		 * */
		public var xxx:String;
		
		/**
		 *	댐 마커 XML 
		 */
		public var damInfo:XML;
		 
		
		public function StackImageStatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}