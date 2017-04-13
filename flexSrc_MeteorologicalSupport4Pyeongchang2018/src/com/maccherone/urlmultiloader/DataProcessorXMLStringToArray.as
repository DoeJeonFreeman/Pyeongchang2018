/*
  Copyright (c) 2009, Lawrence S. Maccherone, Jr.
  All rights reserved.
  See LICENSE.TXT for licensing information
*/

package com.maccherone.urlmultiloader
{
	/**
	 * This class is an example iDataProcessor for use with URLMultiLoader. It will return an array with Objects {} where
	 * the key is the name of the field/tag ("name" for example) and the value is the contents of the tag 
	 * ("/db/node/visitor" for example).
	 * 
	 * <p>It will attempt to convert numbers into Numbers. If that fails, it will store the value as a String.</p>
	 * 
	 * <p>It assumes that you have an XML file structured like this:</p>
	 * 
	 * <code>
	 *	 <?xml version="1.0" encoding="UTF-8"?>
	 *	 <root>
	 *	   <file>
	 *	     <id>101</id>
	 *	     <name>/db/node/visitor</name>
	 *	   </file>
	 *	   <file>
	 *	     <id>102</id>
	 *	     <name>/db/node/observer</name>
	 *	   </file>
	 *	   <file>
	 *	     <id>103</id>
	 *	     <name>/ui/button</name>
	 *	   </file>
	 *	 </root>
	 * </code>
	 * 
	 * <p>Note that the "root" tag and it's child tags (all <file> in this case are irrelevant. The above XML would 
	 * be converted to an Array like this:</p>
	 * 
	 * <code>
	 *	 [
	 *	     {"id": 101, "name": "/db/node/visitor"},
	 *	     {"id": 102, "name": "/db/node/observer"},
	 *	     {"id": 103, "name": "/ui/button"}
	 *	 ]
	 * </code>
	 */
	public class DataProcessorXMLStringToArray implements IDataProcessor
	{
		public function DataProcessorXMLStringToArray()
		{
		}

		public function processData(data:*):*  
		{
			var tempXML:XML = new XML(data as String)
			return XMLListToArray(tempXML.children())
		}
		
		private static function XMLListToArray(xmlList:XMLList):Array {
			var usingNumberIDs:Boolean = false
			var temp:Array = []
			var tempObject:Object
			var tempString:String
			var tempNumber:Number
			for each (var row:XML in xmlList) {
				tempObject = {}
				for each (var element:XML in row.*) {
					tempString = element.toString()
					tempNumber = Number(tempString)
					// TODO: Should also check for date type and store it as a date if appropriate
					if (isNaN(tempNumber) || endsWith(element.localName(), "_id") || (element.localName() == "id")) {  // Store all id's as strings
						tempObject[element.localName()] = tempString
					} else {
						tempObject[element.localName()] = tempNumber
					}
				}
				temp.push(tempObject)
			}
			return temp;
		}
		
		private static function endsWith(s:String, pattern:String):Boolean {
			var li:Number = s.lastIndexOf(pattern)
			return (s.slice(li) == pattern)
		}
		
	}
}