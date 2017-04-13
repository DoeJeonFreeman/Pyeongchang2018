package components.events


{
import flash.events.Event;

public class MenuEvent extends Event{
	
	public static const SUB_MENU_CLICK:String = "subMenuClick";
	
	public var id:String;
	public var name:String;
	public var path:String;
	
	public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
		super(type, bubbles, cancelable);
	}
	
}
}