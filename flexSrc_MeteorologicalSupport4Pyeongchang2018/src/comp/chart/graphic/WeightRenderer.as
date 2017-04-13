package comp.chart.graphic{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	
	
	public class WeightRenderer extends Sprite{
		
		private var _centerX:int = 0;
		private var _centerY:int = 0;
		private var _radius:int  = 18;
		
		private var barWidth:int = 30;  //36
		private var barHeight:int = 14; //14
		
		private var gp:Graphics;
		
		private static const SIZE_MDL2DRAW = 4;
		
		
		public function setRadius(radiusVal:int):void{
			this._radius = radiusVal;	
		}	
		
		public function WeightRenderer(caVal:Object,barHeight:Number=15 ){
			super();
			gp = this.graphics;
			this.barHeight = barHeight;
			drawPTYBar(caVal);
		}
		
		
		
		
		public function getPTYFillColour(item:Object):int{
			var whichType:String = item.type;
			var colour:int;
			if(whichType == "RDPS_PMOS"){       // orange
				colour = 0xf28d52;
			}else if(whichType == "GDPS_PMOS"){ // green		 
				colour = 0x56da89;
			}else if(whichType == "EPSG_PMOS"){ // red
				colour = 0xde443a;
			}else if(whichType == "ECMW_PMOS"){  //jade / skyBlue
				colour = 0x2d97da;//0x2aacbb;
			}else if(whichType == "RDPS_NPPM"){  
				colour = 0xf2b263;
			}else if(whichType == "GDPS_NPPM"){ 
				colour = 0xa7f092;
			}else if(whichType == "EPSG_NPPM"){  
				colour = 0xd96762;
			}else if(whichType == "ECMW_NPPM"){ 
				colour = 0x73cbe9;
			}else{
				colour = 0x03a696;				//pale-blue green
			}
			return colour;		
		}
		
		
		private function getModelSequence(modelStr:String):uint{
			var seqNum:uint=0;
			if(modelStr.indexOf("RDPS_PMOS") != -1){
				seqNum = 1;
			}else if(modelStr.indexOf("GDPS_PMOS") != -1){
				seqNum = 2;
			}else if(modelStr.indexOf("EPSG_PMOS") != -1){
				seqNum = 3;
			}else if(modelStr.indexOf("ECMW_PMOS") != -1){
				seqNum = 4;
			}else if(modelStr.indexOf("RDPS_NPPM") != -1){
				seqNum = 5;
			}else if(modelStr.indexOf("GDPS_NPPM") != -1){
				seqNum = 6;
			}else if(modelStr.indexOf("EPSG_NPPM") != -1){
				seqNum = 7;
			}else if(modelStr.indexOf("ECMW_NPPM") != -1){
				seqNum = 8;
			}else if(modelStr.indexOf("SSPS") != -1){
				seqNum = 9;
			}else{
				seqNum = 999;
			}
			return seqNum;
		}
		
		// PTY
		// rian  0x4ddf68
		// sleet 0x42c0f0
		// snow  0x8d8fe4
		private function getClaerPercentage(ptyObj:Object):Number{
			return (100 - (ptyObj.rain + ptyObj.sleet + ptyObj.snow));
 		}
		
		private function drawPTYBar(ptyObj:Object,direction:String='horizontal'):void{
			gp.clear();
			gp.lineStyle(1,0x000000,.8);
			
			var _positionX:int =  -(barWidth/2);
			var _positionY:int =  -(barHeight/2);
			
				
			
			var weightArr:Array = ptyObj.weight.split(" ");
			var meArr:ArrayCollection = new ArrayCollection();
			for each(var w:String in weightArr){
				var splendid:Array = w.split(":"); 
				meArr.addItem({type:splendid[0], percentage:splendid[1], seq:getModelSequence(splendid[0])});
			}
			
			
								var sortField:SortField = new SortField();
//								sortField.name = "seq";
//								sortField.numeric = true;
//								sortField.descending = false;
								sortField.name = "percentage";
								sortField.numeric = true;
								sortField.descending = true;
								var numericDataSort:Sort = new Sort();
								numericDataSort.fields = [sortField];
								meArr.sort = numericDataSort;
								meArr.refresh();
			
//			
			if((ptyObj.rain + ptyObj.sleet + ptyObj.snow) < 12.5) return;
			
			
			var arr_subList:ArrayCollection;
			
			if(meArr.length >= SIZE_MDL2DRAW){
				arr_subList = new ArrayCollection(meArr.toArray().slice(0,SIZE_MDL2DRAW));
			}else if(meArr.length < SIZE_MDL2DRAW){
				arr_subList = meArr;
			}
			
			sortField.name = "seq";
			sortField.numeric = true;
			sortField.descending = false;
			var numericDataSort:Sort = new Sort();
			numericDataSort.fields = [sortField];
			arr_subList.sort = numericDataSort;
			arr_subList.refresh();
			
			
			
//			if(arr_subList.length==0)return;
			trace('[arr_subList.length]' +arr_subList.length)
			var meSum:Number =  0;
			for each(var topWght:Object in arr_subList){
				meSum += parseFloat(topWght.percentage);				
				
			}
			trace(meSum)
		
			for each(var item:Object in arr_subList){
				gp.beginFill(getPTYFillColour(item),1);
				var rectWidth:int = barWidth*(parseFloat(item.percentage)/meSum);
				trace('rectWidth == ' +   barWidth*  (parseFloat(item.percentage)/meSum  ));
				if(rectWidth > 0){
					gp.lineStyle(1,0x000000,.8);
					gp.drawRect(_positionX,_positionY,rectWidth,barHeight);
					_positionX+=rectWidth;
				}else{
					gp.lineStyle(0,0x000000,0);
				}
			}
			
		}	
		
		
		
		
	}// class
	
} // package