package asset.DFS.timeSeries.meteogram.itmRenerer{
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.LegendData;
	import mx.charts.series.items.LineSeriesItem;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.formatters.NumberFormatter;
	import mx.graphics.SolidColor;



	public class LineSeriesLabel extends UIComponent implements IDataRenderer{
	
		private var _label:Label;
		
		
		/**
		 *  series data label visiblitiy 제어
		 *  아이템렌더러 생성시 플래그 값 넘겨주긔
		 *  T3H랑 REH는 해당 렌더러 사용 (labelVisiblity, lineColour, labelPrecision )
		 * */
		 /////////////////////////////////////////////
		public var isREH:Boolean = false;
		public var showSeriesLabel:Boolean = false;
//		public var circleItemColour:SolidColor;
//		public var labelPrecision:uint;
		 /////////////////////////////////////////////
		
		
		public function LineSeriesLabel():void{
			super();
			_label = new Label();
			 addChild(_label);
			_label.setStyle("color",0x000000);
			_label.setStyle("fontSize",12);
		}
	
		
		private var _chartItem:ChartItem;
		
		public function get data():Object{
			return _chartItem;
		}
	
		
		public function set data(value:Object):void{
		    // setData also is executed if there is a Legend Data 
		   //defined for the chart. We validate that only chartItems are 
		   //assigned to the chartItem class. 
		   //와 대박 legendData가 얘 계속 호출하면서 캐스팅 에러 났었는데ㅋㅋㅋㅋㅋㅋㅋㅋㅋ
			if (value is LegendData){
		        return;
			} 
			
			if (_chartItem == value){
					return;
			}
	
		
			_chartItem = ChartItem(value);
			
			var currFormat:Object = new NumberFormatter();
			
			if(!isREH){
				currFormat.precision = 1; ///
			}else{
				currFormat.precision = 0; ///
			}
			
			currFormat.rounding = "nearest";
			
			if(_chartItem != null){
				if(showSeriesLabel){
					_label.text = currFormat.format(LineSeriesItem(_chartItem).yValue).toString();
				}else{
					_label.text = '';
				}
			}
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void{
		
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			
			
			_label.setActualSize(_label.getExplicitOrMeasuredWidth(),_label.getExplicitOrMeasuredHeight());
			_label.move(unscaledWidth - _label.getExplicitOrMeasuredWidth()*0.5, unscaledHeight/2 - _label.getExplicitOrMeasuredHeight()/2 -10);
				
			
			
			
			graphics.clear();
											// green      //orange
//			graphics.beginFill((isREH)?0x15B06D :0xFB5318  ,1);
			graphics.beginFill(0xFB5318  ,.9);
			graphics.drawCircle(unscaledWidth-3,unscaledHeight-4,3);
		
		}
	
	}

}