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
	public class BuildMyOwnQLoader{
		//adios
		private var isEnsembleMulti:Boolean = false;
		private var ensembleVarName:String;		
		//adios
		private static var _instance:BuildMyOwnQLoader;
		
		private var queue:Array;
		[Bindable]private var totalResults:Array;
		private var urlLoader:URLLoader;
		private var URLs:Array = new Array();
		
		private var modelDictionary:Dictionary;

		//actionscript does not allowed  private constructor at any time haha!!		
		public function BuildMyOwnQLoader(e:Enforcer){
			if(e != null){
//				urlLoader = new URLLoader();
			}else{
				throw new Error("It can\'t be done!! Call getInstance() function instead. haha.")
			}
		}
		
		//implement singletons haha		
		public static function getInstance():BuildMyOwnQLoader{
			if(_instance == null)
				_instance = new BuildMyOwnQLoader(new Enforcer);
			return _instance;
		}
		
		public function getMergedModelData(dataPathArr:Array, isEnsembleMulti:Boolean=false):void{
			//adios
			this.isEnsembleMulti = isEnsembleMulti;
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
//			Alert.show(urlStr);
			doQueue();
		}
		
			
		private function loadData(url:String):void {
		    var request:URLRequest = new URLRequest(url);
		    queue.push(request);
		}

		
		private function getModelNameString(givenURL:String):String{
			var legacyName:String = '';
			var modelFalg = StringUtil.trim(givenURL.split('.')[1]);
			if(modelFalg=='RDPS_MOS'){
				legacyName = 'PMOS';
			}else if(modelFalg=='RDPS'){
				legacyName = 'RDPS';
			}else if(modelFalg=='ECMWF_MOS'){
				legacyName = 'ECMWF';
			}else if(modelFalg=='BEST'){
				legacyName = 'BEST';
			}else if(modelFalg=='SSPS'){
				legacyName = 'SSPS';
			}else if(modelFalg=='GDPS_MOS'){
				legacyName = 'GDPS';
			}else if(modelFalg=='EPSG_MOS'){
				legacyName = 'EPSG';
				if(isEnsembleMulti){ //앙상블멀티차트도 큐로더로 구현
					if(givenURL.indexOf("MMX") != -1) return "MMX";
					else if(givenURL.indexOf("SKY") != -1) return "SKY";
					else if(givenURL.indexOf("PTY") != -1) return "PTY";
					else if(givenURL.indexOf("R12") != -1) return "R12";
				}
			}
			
			return  legacyName;
			
			/**
			var baseModel:String = '';
			if(givenURL.indexOf("SHRT_STN_RDPS_NPPM") != -1){
				baseModel = 'RDPS'; 
			}else if(givenURL.indexOf("_BEST_") != -1){ //doeJeon Oct2015
				baseModel = 'BEST';
			}else if(givenURL.indexOf("SHRT_STN_KWRF_NPPM") != -1){
				baseModel = 'KWRF';
			}else if(givenURL.indexOf("SHRT_STN_RDPS_PMOS") != -1){
				baseModel = "PMOS";
			}else if(givenURL.indexOf("ECMW_NPPM") != -1){
				baseModel = "ECMWF";
			}else if(givenURL.indexOf("MEDM_STN_GDPS_NPPM") != -1){
				baseModel = "GDPS";
			}else if(givenURL.indexOf("MEDM_STN_GDPS_PMOS") != -1){
				baseModel ='PMOS2';
			}else if(givenURL.indexOf("MEDM_STN_EPSG_PMOS") != -1){
				baseModel ='EPSG';
				if(isEnsembleMulti){ //앙상블멀티차트도 큐로더로 구현
					if(givenURL.indexOf("MMX") != -1) return "MMX";
					else if(givenURL.indexOf("SKY") != -1) return "SKY";
					else if(givenURL.indexOf("PTY") != -1) return "PTY";
					else if(givenURL.indexOf("R12") != -1) return "R12";
				}
					
			}	
			return baseModel;
			*/ 
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
		        urlLoader.removeEventListener(Event.COMPLETE, completeHandler);
		        urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, IOErrHadler);
				if(isEnsembleMulti){
					Application.application.setExistEnsembleMember(getmodelDictionary());
				}else{
trace(showResultSet());					
					Application.application.setExistModelData(getmodelDictionary());
				}
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
			var modelArr:Array = new Array('PMOS','RDPS','KWRF','ECMWF','GDPS','EPSG','BEST');
			var varArr:Array = new Array('MMX','SKY','R12','PTY');
			var arr:Array = (isEnsembleMulti)? varArr : modelArr;
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
	