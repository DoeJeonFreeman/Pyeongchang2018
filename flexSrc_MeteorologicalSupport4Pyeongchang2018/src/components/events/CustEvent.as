package components.events
{
	
	import flash.events.Event;

	public class CustEvent extends Event
	{
		public var obj:Object;
		public function CustEvent(type:String, obj:Object)
		{
			super(type, true, false);
			this.obj = obj;
		}
	}
}