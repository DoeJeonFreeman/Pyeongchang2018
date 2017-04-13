package components.events{
	import flash.events.Event;
	
	
	
	public class CheckBoxEvent extends Event{
		
		public static const EVT_STN_SELECTED:String = "STN_SELECTED";
		
		public var selectedItem:XML;
		
		public function CheckBoxEvent(type:String, selected:XML ,bubbles:Boolean=false, cancelable:Boolean=false){
//		public function CheckBoxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
//			super(type, true);
			this.selectedItem = selected;
		}

	}
}