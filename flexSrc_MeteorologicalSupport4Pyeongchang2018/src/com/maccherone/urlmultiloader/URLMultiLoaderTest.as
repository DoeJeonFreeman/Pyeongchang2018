package com.maccherone.urlmultiloader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
 
	public class URLMultiLoaderTest extends Sprite
	{
		private var urlMultiLoader:URLMultiLoader = new URLMultiLoader()
		private var baseURL:String = "data/"
//		private var urlRequest1:URLRequest = new URLRequest(baseURL + "file.xml")
//		private var urlRequest2:URLRequest = new URLRequest(baseURL + "file.xml")  // Same file but we'll get it in a different format
//		private var urlRequest3:URLRequest = new URLRequest(baseURL + "smile.gif")
		private var urlRequest1:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_POP.201106120000.xml");
		private var urlRequest2:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_REH.201106120000.xml");
		private var urlRequest3:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_RN3.201106120000.xml");
		private var urlRequest4:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_SKY.201106120000.xml");
		private var urlRequest5:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_SN3.201106120000.xml");
		private var urlRequest6:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_T3H.201106120000.xml");
		private var urlRequest7:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_WSD.201106120000.xml");
		private var urlRequest8:URLRequest = new URLRequest("DFS_SHRT_STN_RDPS_NPPM_PTY.201106120000.xml") ; // Same file but we'll get it in a different format
//		private var urlRequest3:URLRequest = new URLRequest("testIMG.jpg");
 
		public function URLMultiLoaderTest() {
			var urlMultiLoader:URLMultiLoader = new URLMultiLoader
 
			var dataProcessor:IDataProcessor = new DataProcessorXMLStringToArray()  // Example provided with URLMultiLoader. You can create your own.
 
//			urlMultiLoader.addURLRequest("Request1", urlRequest1, dataProcessor)
			urlMultiLoader.addURLRequest("Request1", urlRequest1)
			urlMultiLoader.addURLRequest("Request2", urlRequest2)
			urlMultiLoader.addURLRequest("Request3", urlRequest3)
			urlMultiLoader.addURLRequest("Request4", urlRequest4)
			urlMultiLoader.addURLRequest("Request5", urlRequest5)
			urlMultiLoader.addURLRequest("Request6", urlRequest6)
			urlMultiLoader.addURLRequest("Request7", urlRequest7)
			urlMultiLoader.addURLRequest("Request8", urlRequest8)  // If no IDataProcessor is provided, then file's contents is returned as String, ByteArray, or
			                                           // URLVariables depending upon the URLLoaderDataFormat TEXT, BINARY, or VARIABLES respectively
//			urlMultiLoader.addURLRequest("Request3", urlRequest3, null, URLLoaderDataFormat.BINARY)  // Loads smile.gif as a ByteArray
 
			urlMultiLoader.addEventListener(Event.COMPLETE, filesLoaded)
			urlMultiLoader.addEventListener(IOErrorEvent.IO_ERROR, onError)
			urlMultiLoader.load()
		}
 
		private function filesLoaded(event:Event):void {
			var data:Object = (event.target as URLMultiLoader).data
//			trace("Array of Objects:\n" + data["Request1"] + "\n") // Uses JSON.encode for pretty output
//			trace("String of file contents:\n" + data["Request2"] + "\n")
//			trace("String of file contents:\n" + data["Request3"] + "\n")
//			trace("String of file contents:\n" + data["Request4"] + "\n")
//			trace("String of file contents:\n" + data["Request5"] + "\n")
//			trace("String of file contents:\n" + data["Request6"] + "\n")
//			trace("String of file contents:\n" + data["Request7"] + "\n")
//			trace("String of file contents:\n" + data["Request8"] + "\n")
			Alert.show("data loaded");
		}
 
		private function onError(event:Event):void {
			trace(event)
		}
	}
}