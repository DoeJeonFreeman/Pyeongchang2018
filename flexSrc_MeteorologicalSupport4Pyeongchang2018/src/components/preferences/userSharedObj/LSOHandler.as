package components.preferences.userSharedObj{
	import comp.util.common.CommonUtil;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	
	
	
    public class LSOHandler {

        private var userSO:SharedObject;
        private var ac:ArrayCollection;
        private var lsoType:String;


        public function LSOHandler(s:String,mainConfigOnly:Boolean=false) {
            init(s,mainConfigOnly);
        }
        

        private function init(s:String,launchViaMainPageSetter:Boolean):void {
            ac = new ArrayCollection();
            lsoType = s; //s='setSomeStuffAsMainpage'
            userSO = SharedObject.getLocal(lsoType,"/");
            
            //메인페이지설정이 아닌 경우에만 리스트 가져오긔
            if(!launchViaMainPageSetter){
	            if (getObjects()) ac = getObjects();
            }
            
        }

		private function restoreAsDefault():void{
        	userSO.data.regionCode = '';
        	userSO.data.baseModel = '';
        	userSO.data.isMEDM = '';
        	userSO.flush();
		}

        public function getObjects(isMEDM:Boolean=false):ArrayCollection {
            return userSO.data[lsoType];
        }


 		private function printUserConfiguredList():String{
			var str:String='';
			var cnt:uint=0;
			var testList:ArrayCollection = getObjects();
			for each(var obj:Object in testList){
				str+= '[' + cnt + ']' +obj.stnName + ' (' + obj.stnCode + ')\n'
				cnt++;
			}
			return str;
		}
        
        public function replaceStationList(arr:ArrayCollection):void{
        	ac = arr;
            updateSharedObjects();
        }

        private function updateSharedObjects():void {
            userSO.data[lsoType] = ac;
            userSO.flush();
//CommonUtil.getInstance().showAlertDialogOnScreenTop(printUserConfiguredList(),lsoType+":LSOHandler.updateSharedObjects()");
        }
        
		
			public function storeLastConfiguration():void{
			userSO.data.lastConfiguration = new Date();
			userSO.flush();
		}
		
		public function getLastConfiguration():Date{
			return userSO.data.lastConfiguration;
		}
		
		
		/*
		public function iPad4(regionCodeNum:int, padDigit:int):String {
			if(regionCodeNum == 8318 || regionCodeNum==555){
				return regionCodeNum+"";
			}else{
				var ret:String = ""+regionCodeNum;
				while( ret.length < padDigit )
					ret="0" + ret;
				return ret;
			}
			
		}
		*/
		
		public function storeRegionCode(mainPageInfo:Object, isSelected:Boolean=true, restoreAsDefaultVal:Boolean=false):void{
			if(restoreAsDefaultVal || ! isSelected){
				restoreAsDefault();
			}else{
				userSO.data.isMEDM = mainPageInfo.isMEDM;
				userSO.data.isSSPS = mainPageInfo.isSSPS;
				//2018 평창 ~
				userSO.data.isPYEONGCHANG = mainPageInfo.isPYEONGCHANG;
				
				userSO.data.baseModel = mainPageInfo.baseModel;
				userSO.data.regionCode = mainPageInfo.regionCode;
				userSO.flush();
//var str:String = 'isMEDM: '+mainPageInfo.isMEDM + '\nisSSPS: '+ mainPageInfo.isSSPS +"\nBased On: " + mainPageInfo.baseModel+"\ngrCode: "+mainPageInfo.regionCode;
//CommonUtil.getInstance().showAlertDialogOnScreenTop(str,"LSOHandler.storeRegionCode(someInfo)");
			}
		}
		
		public function getRegionCode():String{
			return userSO.data.regionCode;
		}
		
		public function isOlympic():String{
			return userSO.data.isPYEONGCHANG;
		}
		
		public function getBaseModel():String{
			return userSO.data.baseModel;
		}
		
		public function getIsMEDM():String{
			return userSO.data.isMEDM;
		}
		
    }
}