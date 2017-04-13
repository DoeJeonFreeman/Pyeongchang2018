/*
  Copyright (c) 2009, Lawrence S. Maccherone, Jr.
  All rights reserved.
  See LICENSE.TXT for licensing information
*/

package com.maccherone.urlmultiloader
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * This class will load multiple files and optionally "process" them before calling the method specified
	 * for Event.COMPLETE.
	 *
	 * <p>Example usage:</p>
	 * <code>
	 * 		var urlMultiLoader:URLMultiLoader = new URLMultiLoader
	 * 
	 *		var dataProcessor:IDataProcessor = new DataProcessorXMLStringToArray()  // Example provided with URLMultiLoader. You can create your own.
	 * 
	 * 		var urlRequest1:URLRequest = new URLRequest("data/file1.xml")
	 * 		var urlRequest2:URLRequest = new URLRequest("data/smile.gif")
	 * 
	 * 		urlMultiLoader.addURLRequest(urlRequest1, dataProcessor)
	 * 		urlMultiLoader.addURLRequest(urlRequest1)  // If no IDataProcessor is provided, then file's contents is returned as String, ByteArray, or
	 *                                                 // URLVariables depending upon the URLLoaderDataFormat TEXT, BINARY, or VARIABLES respectively
	 * 		urlMultiLoader.addURLRequest(urlRequest3, null, URLLoaderDataFormat.BINARY)
	 *		
	 *		urlMultiLoader.addEventListener(Event.COMPLETE, filesLoaded);
	 *		urlMultiLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
	 *		urlMultiLoader.load();		
	 * </code>
	 * 
	 * <p>You access the returned data as such:</p>
	 * 
	 * 
	 */
	public class URLMultiLoader extends EventDispatcher	{	
		
		private var urlInfoDictionary:Dictionary; // key: URLRequest passed into addURLRequest, value: URLInfo
		private var urlLoaders:Dictionary; // key: URLLoader, value: URLRequest (same as above)
		public var data:Object = {};
		
		public function URLMultiLoader(target:IEventDispatcher=null) {
			super(target);
			urlInfoDictionary = new Dictionary();
			urlLoaders = new Dictionary();
		}
		
		public function load():void {
			var tempURLRequest:URLRequest;
			for (var urlLoader:* in urlLoaders) {
				tempURLRequest = urlLoaders[urlLoader];
				urlLoader.load(tempURLRequest);
			}
		}
		
		public function abort():void {
			var tempURLRequest:URLRequest;
			for (var urlLoader:* in urlLoaders) {
				tempURLRequest = urlLoaders[urlLoader];
				if (! urlInfoDictionary[tempURLRequest].complete) {
					try {
						urlLoader.close();
					} catch(event:Event) {
						
					}
				}
			}
		}
		
		public function addURLRequest(name:String, urlRequest:URLRequest, dataProcessor:IDataProcessor = null, urlLoaderDataFormat:String = URLLoaderDataFormat.TEXT):void {
			var tempURLInfo:URLInfo = new URLInfo(name, dataProcessor);
			urlInfoDictionary[urlRequest] = tempURLInfo;
			var tempURLLoader:URLLoader = new URLLoader();
			tempURLLoader.dataFormat = urlLoaderDataFormat;
			tempURLLoader.addEventListener(Event.COMPLETE, onComplete);
			tempURLLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			urlLoaders[tempURLLoader] = urlRequest;
		}
		
		public function onIOError(event:Event):void {
			var tempURLRequest:URLRequest = urlLoaders[event.target]			
			var tempURLInfo:URLInfo = urlInfoDictionary[tempURLRequest];
			tempURLInfo.complete = true;
			tempURLInfo.happy = false;
			abort();
			dispatchEvent(new Event(flash.events.IOErrorEvent.IO_ERROR));
		}
		
		public function onComplete(event:Event):void {
			var tempURLRequest:URLRequest = urlLoaders[event.target]
			var tempURLInfo:URLInfo = urlInfoDictionary[tempURLRequest];
			tempURLInfo.complete = true;
			tempURLInfo.happy = true;
			var done:Boolean = true;
			
			if (tempURLInfo.dataProcessor != null) {
				tempURLInfo.data = tempURLInfo.dataProcessor.processData(event.target.data)
				delete event.target.data
			} else {
				tempURLInfo.data = event.target.data  // If there is no dataProcessor, put the raw String into data
			}
			data[tempURLInfo.name] = tempURLInfo.data
					
			for each (var urlInfoValue:URLInfo in urlInfoDictionary) {
				if (! urlInfoValue.complete) {
					done = false;
				}
			}
			if (done) {
				dispatchEvent(new Event(flash.events.Event.COMPLETE));
			}
		}

		
	}
}