package comp.chart.graphic{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	
	
	public class PrecipitationType_ensemble extends Sprite{
		
		private var _centerX:int = 0;
		private var _centerY:int = 0;
		private var _radius:int  = 18;
		
		private var barWidth:int = 36;
		private var barHeight:int = 14;
		
		private var gp:Graphics;
		
		
		public function setRadius(radiusVal:int):void{
			this._radius = radiusVal;	
		}	
		
		public function PrecipitationType_ensemble(caVal:Object,barHeight:Number=14 ){
			super();
			gp = this.graphics;
			this.barHeight = barHeight;
			drawPTYBar(caVal);
		}
		
		public function getPTYFillColour(item:Object):int{
			var whichType:String = item.type;
			var colour:int;
			if(whichType == "rain"){        //rain
				colour = 0x4ddf68;
			}else if(whichType == "sleet"){ //sleet
				colour = 0x42c0f0;
			}else if(whichType == "snow"){   //snow
				colour = 0x8d8fe4;
			}else if(whichType == "clear"){ //clear
				colour = 0xffffff;
			}	
			return colour;		
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
			
			var arr:ArrayCollection = new ArrayCollection([
				{type:"clear", percentage: getClaerPercentage(ptyObj)},
				{type:"rain", percentage: ptyObj.rain},
				{type:"sleet", percentage: ptyObj.sleet},
				{type:"snow", percentage: ptyObj.snow}
			]);
			
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
			

			for each(var item:Object in arr){
				if(item.type.toString()=='clear'){
					if(item.percentage == 100){
						continue;
					}
				}
					
				gp.beginFill(getPTYFillColour(item),1);
				var rectWidth:int = barWidth*(item.percentage/100);
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