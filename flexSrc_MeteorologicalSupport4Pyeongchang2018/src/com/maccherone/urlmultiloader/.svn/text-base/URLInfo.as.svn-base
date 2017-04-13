/*
  Copyright (c) 2009, Lawrence S. Maccherone, Jr.
  All rights reserved.
  See LICENSE.TXT for licensing information
*/

package com.maccherone.urlmultiloader
{
	public class URLInfo {
		public var name:String;
		public var data:*  // This is where we stick the processed data (or if no IDataProcessor is provided, it'll copy the output of the URLLoader into here)
		public var complete:Boolean = false
		public var happy:Boolean = true  // true if the request is either pending or completed successfully
		public var dataProcessor:IDataProcessor
		
		public function URLInfo(name:String, dataProcessor:IDataProcessor) {
			this.name = name
			this.dataProcessor = dataProcessor
		}
	}
}