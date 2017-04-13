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
	public class DJFQueueLoader{
		//adios
		//adios
		private static var _instance:DJFQueueLoader;
		
		private var queue:Array;
		[Bindable]private var totalResults:Array;
		private var urlLoader:URLLoader;
		private var URLs:Array = new Array();
		
		private var modelDictionary:Dictionary;

		//actionscript does not allowed  private constructor at any time haha!!		
		public function DJFQueueLoader(e:Enforcer){
			if(e != null){
//				urlLoader = new URLLoader();
			}else{
				throw new Error("It can\'t be done man!! Call function-getInstance() instead haha.")
			}
		}
		
		//implement singletons haha		
		public static function getInstance():DJFQueueLoader{
			if(_instance == null)
				_instance = new DJFQueueLoader(new Enforcer);
			return _instance;
		}
		
		public function getMergedModelData(dataPathArr:Array):void{
			//adios
			//adios
			modelDictionary = new Dictionary();
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

		
		private function getModelNameString(givenURL:String):String{
			return StringUtil.trim(givenURL.split('.')[0]);
		}

		
		private function doQueue():void {
		    if (queue.length > 0) {
		        var arr:Array = queue.splice(0,1);
		        var req:URLRequest = arr[0] as URLRequest;
		        urlLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				
				var req_snippet:Array = req.url.split(" ");  //"SHRT.RDPS_MOS."+chartType+" "+dateString
				req.url = CommonUtil.getInstance().getTimeseriesDataPathByGivenProperty(req_snippet[0],req_snippet[1]);
				trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!  doQueue()  [req.url]" + req.url)
//				urlLoader.addEventListener(Event.COMPLETE, addArguments(completeHandler,[getModelNameString(req.url)]));
				urlLoader.addEventListener(Event.COMPLETE, addArguments(completeHandler,[getModelNameString(req_snippet[0])]));
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, IOErrHadler);
		        urlLoader.load(req);
				trace('try to load('+req.url+') from queue..')
		    }else {
		        trace('========================================================')
		        trace('DONE..\n [NumOfSucceeded] '+totalResults.length + ' / ' + URLs.length + ' [NumOfReq]','DONE' );
		        trace('========================================================')
//				CommonUtil.getInstance().showAlertDialogOnScreenTop(showResultSet(),'DONE.. [NumOfSuccesses] '+totalResults.length );
		        urlLoader.removeEventListener(Event.COMPLETE, completeHandler);
		        urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, IOErrHadler);
//					Application.application.setExistEnsembleMember(getmodelDictionary());
					Application.application.setExistModelData(getmodelDictionary());
		    }
		}
		
		
		private function addArguments(method:Function, additionalArguments:Array):Function {
  			return function(event:Event):void {method.apply(null, [event].concat(additionalArguments));}
		}

		
		private function completeHandler(event:Event, modelName:String):void {
			var result:XML = new XML(event.target.data)
		    totalResults.push(result);
		     if(modelDictionary){
			    modelDictionary[modelName] = result;
			    trace('\t[SUCCEEDED] ::print additionalArguments:: '+modelName);
		     }
		    doQueue();
		}

		

		
		private function IOErrHadler(errEvt:IOErrorEvent):void{
			trace('[QueueLoader] An IOError Occured');
			doQueue();
		}
		
		
		private function showResultSet():String{
			var modelArr:Array = new Array('VSRT','SHRT','MEDM');
			var arr:Array = modelArr;
			var str:String='';
			for each(var key:String in arr){
				if(modelDictionary[key]){
					str+= key+'\n';
				}	
			}
			return str;
		}
		
		
		public function getTotalResults():Array{
			return totalResults;
		}
		
		private function getmodelDictionary():Dictionary{
			return modelDictionary;
		}
		
		
	}	//EOC
}	//pkg


// an empty, private class, used to prevent outside sources from instantiating this locator
// directly, without using the getInstance() function....
class Enforcer{}
	