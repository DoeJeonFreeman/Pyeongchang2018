package components.preferences.userSharedObj{
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	
	
    public class SOHandler_setStuffAsMain {

        private var userSO:SharedObject;
        private var lsoType:String;
        

        public function SOHandler_setStuffAsMain(s:String,isAnotherDialog:Boolean=false) {
            init(s,isAnotherDialog);
        }

        private function init(s:String,launchViaPopup:Boolean):void {
            lsoType = s;
            userSO = SharedObject.getLocal(lsoType,"/");
        }

		
		public function storeRegionCode(someRegionCode:String,isSelected:Boolean=true):void{
			userSO.data.regionCode = (isSelected)? someRegionCode : '8318';
			userSO.flush();
		}
		
		public function getRegionCode():String{
			return userSO.data.regionCode;
		}
		
		
		
		
		
    }
}
		
		
