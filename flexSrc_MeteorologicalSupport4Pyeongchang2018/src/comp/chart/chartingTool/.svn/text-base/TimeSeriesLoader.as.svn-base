package comp.chart.chartingTool{
	import com.maccherone.urlmultiloader.URLMultiLoader;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	
	
	public class TimeSeriesLoader{
		
		private var baseUrl:String = "XML/";
		
		public function TimeSeriesLoader(){
			//constructor
		}

		public function loadAllTimeSeriesData(baseModel:String=null, dateTime:String=null):void{
			//모델네임이랑 시간받아서 처리하긔. 일단은 걍 거시기로
			var multiLoader:URLMultiLoader = new URLMultiLoader();
//			var dataProcessor:IDataProcessor = new DataProcessorXMLStringToArray();  // Example provided with URLMultiLoader. You can create your own.
			
			var req_REH:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_REH.201106120000.xml");			
			var req_POP:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_POP.201106120000.xml");			
			var req_RN3:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_RN3.201106120000.xml");			
			var req_SN3:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_SN3.201106120000.xml");			
			var req_WSD:URLRequest = new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_WSD.201106120000.xml");			
			var req_SKY:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_SKY.201106120000.xml");			
			var req_PTY:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_PTY.201106120000.xml");			
			var req_T3H:URLRequest =  new URLRequest(baseUrl+"DFS_SHRT_STN_RDPS_NPPM_T3H.201106120000.xml");			
			
			multiLoader.addURLRequest("reh",req_REH); //param3: dataProcessor, param4:fileTYpe
			multiLoader.addURLRequest("pop",req_POP); 
			multiLoader.addURLRequest("rn3",req_RN3); 
			multiLoader.addURLRequest("sn3",req_SN3); 
			multiLoader.addURLRequest("wsd",req_WSD); 
			multiLoader.addURLRequest("sky",req_SKY); 
			multiLoader.addURLRequest("pty",req_PTY); 
			multiLoader.addURLRequest("t3h",req_T3H); 
			
			multiLoader.addEventListener(Event.COMPLETE, filesLoaded);
			multiLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			multiLoader.load();
		}

		private function filesLoaded(event:Event):void {
			var seriesData:Object = (event.target as URLMultiLoader).data;
			var testXML:XML =  new XML(seriesData['reh']);
			if(testXML== null){
				Alert.show('null');
			}else{
				Alert.show(testXML.@basedOn);
			}
//			Alert.show(testXML.regionGroup[1].stn[1].toXMLString());
//			Alert.show("timeSeries loaded at once~");
		}
 
		private function onError(event:Event):void {
			Alert.show("ioErr. occured");
			trace(event)
		}


	} //class
}//package