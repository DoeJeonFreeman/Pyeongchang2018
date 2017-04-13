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
//		public function getPTYFillColour(item:Object):int{
//			var whichType:String = item.type;
//			var colour:int;
//			if(whichType == "RDPS_PMOS"){       // mos green
//				colour = 0x70be4e;
//			}else if(whichType == "GDPS_PMOS"){ // purple grey		 
//				colour = 0x646c8d;
//			}else if(whichType == "EPSG_PMOS"){ // mandarin~
//				colour = 0xf28d52;
//			}else if(whichType == "ECMW_PMOS"){  //sea blue?
//				colour = 0x0268c2;
//			}else if(whichType == "RDPS_NPPM"){  
//				colour = 0xadc900;
//			}else if(whichType == "GDPS_NPPM"){ 
//				colour = 0x8b9dad;
//			}else if(whichType == "EPSG_NPPM"){  
//				colour = 0xf2b263;
//			}else if(whichType == "ECMW_NPPM"){ 
//				colour = 0x009dd9;
//			}else{
//				colour = 0x03a696;				//pale-blue green
//			}
//			return colour;		
//		}
//		public function getPTYFillColour(item:Object):int{
//			var whichType:String = item.type;
//			var colour:int;
//			if(whichType == "RDPS_PMOS"){       
//				colour = 0xfbbc05;
//			}else if(whichType == "GDPS_PMOS"){ //GDPS MOS        PPM=0x1D9657
//				colour = 0xFFFFFF;
//			}else if(whichType == "EPSG_PMOS"){ //EPSG MOS		  
//				colour = 0xFFFFFF;
//			}else if(whichType == "ECMW_PMOS"){ 
//				colour = 0x329AE1;
//			}else if(whichType == "RDPS_NPPM"){ 
//				colour = 0x41C01C;
//			}else if(whichType == "GDPS_NPPM"){ 
//				colour = 0x1D9657;
//			}else if(whichType == "EPSG_NPPM"){  //EPSG PPM
//				colour = 0xFFFFFF;
//			}else if(whichType == "ECMW_NPPM"){ 
//				colour = 0x2D6FE8;
//			}else{
//				colour = 0xFFFFFF;				//SSPS 
//			}
//			return colour;		
//		}
		
		
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
			
				//				colour = 0x4ddf68;
				//			}else if(whichType == "GDPS_NPPM"){ //sleet
				//				colour = 0x42c0f0;
				//			}else if(whichType == "ECMW_NPPM"){   //snow
				//				colour = 0x8d8fe4;
				//			}else if(whichType == "RDPS_PMOS"){ //clear
				//				colour = 0xea4335;
				//			}else if(whichType == "RDPS_NPPM"){ //clear
				//				colour = 0xfbbc05;
				//			}else{
				//				colour = 0xf27c38;
				//			}
			
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
//			var arr:ArrayCollection = new ArrayCollection([
//				{type:"clear", percentage: getClaerPercentage(ptyObj)},
//				{type:"rain", percentage: ptyObj.rain},
//				{type:"sleet", percentage: ptyObj.sleet},
//				{type:"snow", percentage: ptyObj.snow}
//			]);
//			
//			2014.12.14 높은 확률부터 표출 ㄴㄴ -> 무강수  비 비눈 눈
//			글고 자바파서에서 무강수도 퍼센트 계산됨 흰색으로 채우고 툴팁 띄워잉
//			var sortField:SortField = new SortField();
//			sortField.name = "percentage";
//			sortField.numeric = true;
//			sortField.descending = true;
//			var numericDataSort:Sort = new Sort();
//			numericDataSort.fields = [sortField];
//			arr.sort = numericDataSort;
//			arr.refresh();
			
			/**
			 * 
			 * 2014.12.15
			 * 무강수 제외한 나머지 강수형태의 퍼센트값이 12.5이상일 경우에만 bar graphic 드로우 
			 * 
			 * 글고 클리어도 표출 포함(와이뜨)
			 * 
			 * 앙상블 종합 시계열 범례도 같이 수정함(무강수~)
			 * 
			 * */
			if((ptyObj.rain + ptyObj.sleet + ptyObj.snow) < 12.5) return;
			
			
			var arr_subList:ArrayCollection;
			
			if(meArr.length >= SIZE_MDL2DRAW){
				arr_subList = new ArrayCollection(meArr.toArray().slice(0,SIZE_MDL2DRAW));
			}else if(meArr.length < SIZE_MDL2DRAW){
				arr_subList = meArr;
			}
			
			
//			var sortField:SortField = new SortField();
			//								sortField.name = "seq";
			//								sortField.numeric = true;
			//								sortField.descending = false;
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
			
//			for each(var item:Object in meArr){
//				if(item.type.toString()=='clear'){
//					if(item.percentage == 100){
//						continue;
//					}
//				}
//					
//				gp.beginFill(getPTYFillColour(item),1);
//				var rectWidth:int = barWidth*(item.percentage/100);
//				if(rectWidth > 0){
//					gp.lineStyle(1,0x000000,.8);
//					gp.drawRect(_positionX,_positionY,rectWidth,barHeight);
//					_positionX+=rectWidth;
//				}else{
//					gp.lineStyle(0,0x000000,0);
//				}
//			}
		}	
		
		
		
		
	}// class
	
} // package