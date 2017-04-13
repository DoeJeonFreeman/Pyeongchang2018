package components.util{
	import comp.util.common.CommonUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.utils.StringUtil;
	
	
//	[Bindable] 
	public class DJFUpdateTimeGetter{
		//adios
		//adios
		private static var _instance:DJFUpdateTimeGetter;
		
		private var queue:Array;
		[Bindable]private var totalResults:Array;
		private var urlLoader:URLLoader;
		private var URLs:Array = new Array();
		
		private var updateTimeDictionary:Dictionary;

		//actionscript does not allowed  private constructor at any time haha!!		
		public function DJFUpdateTimeGetter(e:Enforcer){
			if(e != null){
//				urlLoader = new URLLoader();
			}else{
				throw new Error("It can\'t be done man!! Call function-getInstance() instead haha.")
			}
		}
		
		//implement singletons haha		
		public static function getInstance():DJFUpdateTimeGetter{
			if(_instance == null)
				_instance = new DJFUpdateTimeGetter(new Enforcer);
			return _instance;
		}
		
		public function getLastUpdateTime(dataPathArr:Array):void{
			//adios
			//adios
			updateTimeDictionary = new Dictionary();
			queue = new Array();
			totalResults = new Array();
			URLs = dataPathArr;
			var urlStr:String = '';	//debug	
			for each(var url:String in URLs) {
				urlStr+=url+'\n' //debug
			    loadData(url);
			}
			doQueue();
		}
		
			
		private function loadData(url:String):void {
		    var request:URLRequest = new URLRequest(url);
		    queue.push(request);
		}

		
		private function getRangeNameString(givenURL:String):String{
			return StringUtil.trim(givenURL.split('.')[1]); //vsrt || shrt || medm
		}

		
		private function doQueue():void {
		    if (queue.length > 0) {
		        var arr:Array = queue.splice(0,1);
		        var req:URLRequest = arr[0] as URLRequest;
		        urlLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				
//				var req_snippet:Array = req.url.split(" ");  //"SHRT.RDPS_MOS."+chartType+" "+dateString
//				req.url = CommonUtil.getInstance().getTimeseriesDataPathByGivenProperty(req_snippet[0],req_snippet[1]);
				trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!  doQueue()  [req.url]" + req.url)
				urlLoader.addEventListener(Event.COMPLETE, addArguments(completeHandler,[getRangeNameString(req.url)]));
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, IOErrHadler);
		        urlLoader.load(req);
				trace('try to load('+req.url+') from queue..')
		    }else {
		        trace('========================================================')
		        trace('DONE..\n [NumOfSucceeded] '+totalResults.length + ' / ' + URLs.length + ' [NumOfReq]','DONE' );
		        trace('========================================================')
//		        urlLoader.removeEventListener(Event.COMPLETE, completeHandler);
		        urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, IOErrHadler);
				
				var arr:Array = new Array();
				if(updateTimeDictionary['vsrt']) arr.push(parseInt(updateTimeDictionary['vsrt']));
				if(updateTimeDictionary['shrt']) arr.push(parseInt(updateTimeDictionary['shrt']));
				if(updateTimeDictionary['medm']) arr.push(parseInt(updateTimeDictionary['medm']));
				
				if(arr.length>0){
					var lastUpdate:Number = Math.max.apply(null, arr);
					var nadir4debug:Number = Math.min.apply(null, arr);
					CommonUtil.getInstance().setLatestStuff_VSRT(null, lastUpdate+'');
//					Alert.show(lastUpdate+'[peak] .vs. [nadir]'+nadir4debug,'DJFUpdateTimeGetter.as');
				}else{
//					Alert.show('lastUpdate.xxxx not exists haah','DJFUpdateTimeGetter.as');
				}
				
		    }
		}
		
		
		private function addArguments(method:Function, additionalArguments:Array):Function {
  			return function(event:Event):void {method.apply(null, [event].concat(additionalArguments));}
		}

		
		private function completeHandler(event:Event, flag:String):void {
			var dStr:String = new String(event.target.data);
			dStr=  StringUtil.trim(dStr);
		    totalResults.push(dStr);
		     if(updateTimeDictionary){
			    updateTimeDictionary[flag] = dStr;
			    trace('\t[SUCCEEDED] ::print additionalArguments:: '+flag);
		     }
		    doQueue();
		}

		

		
		private function IOErrHadler(errEvt:IOErrorEvent):void{
			trace('[QueueLoader] An IOError Occured');
			doQueue();
		}
		
//		vsrt || shrt || medm
		private function showResultSet():String{
			var modelArr:Array = new Array('vsrt','shrt','medm');
			var arr:Array = modelArr;
			var str:String='';
			for each(var key:String in arr){
				if(updateTimeDictionary[key]){
					str+= key+'\n';
				}	
			}
			return str;
		}
		
		
		public function getTotalResults():Array{
			return totalResults;
		}
		
		private function getupdateTimeDictionary():Dictionary{
			return updateTimeDictionary;
		}
		
		
	}	//EOC
}	//pkg


// an empty, private class, used to prevent outside sources from instantiating this locator
// directly, without using the getInstance() function....
class Enforcer{}
	