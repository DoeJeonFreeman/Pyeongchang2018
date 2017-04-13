package components{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	
	/**
	 * Alert를 보여주고 일정 시간 후 자동 닫히는 컴포넌트
	 */
	public class AutoDisableAlert{
		
		/**
		 * 사라지기까지 시간
		 */
		[Bindable]public var delay:Number = 1000 * 2.5;
		
		private var alert:Alert;
		
		public function AutoDisableAlert(delay:Number=-1){
			if(delay!=-1){
				this.delay = delay;
			}
		}
		
		private function disable(e:TimerEvent):void{
			if(alert && alert.isPopUp)
				alert.parent.removeChild(alert);
		}
		
		/**
		 * 기본 컴포넌트인 Alert.show() 파라미터와 동일
		 */
		public function show(text:String = "", title:String = "",
                                flags:uint = 0x4 /* Alert.OK */, 
                                parent:Sprite = null, 
                                closeHandler:Function = null, 
                                iconClass:Class = null, 
                                defaultButtonFlag:uint = 0x4 /* Alert.OK */):void{
       		
       		alert = Alert.show(text,title,flags,parent,closeHandler,iconClass,defaultButtonFlag);
       		
       		var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, disable);
			timer.start();
			
       }
	}
}