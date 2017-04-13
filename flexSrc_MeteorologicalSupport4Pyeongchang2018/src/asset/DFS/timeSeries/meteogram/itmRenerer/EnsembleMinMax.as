package asset.DFS.timeSeries.meteogram.itmRenerer
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.LegendData;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.formatters.NumberFormatter;
	
	public class EnsembleMinMax extends UIComponent implements IDataRenderer
	{
//		private var label:Label;
//		private var label_min:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem
		private var _peak:Number;
		private var _nadir:Number;

	    public function EnsembleMinMax():void
	    {
	        super();	        
	    }

		override protected function createChildren():void
		{	
			super.createChildren();
//			if (label == null)
//	        {
//				// create and add the label
//		        label = new Label();
//		        label.truncateToFit = true;	
//		        label.setStyle("fontSize", 10);	      
//		        label.setStyle("textAlign", "left");
//		        label.setStyle("color", 0xFF0000);
////		        trace("_peak[passingParam]"+ _peak);	    
////		        addChild(label);
//				label_min = new Label();
//		        label_min.truncateToFit = true;	
//		        label_min.setStyle("fontSize", 10);	      
//		        label_min.setStyle("textAlign", "left");
//		        label_min.setStyle("color", 0x0000FF);
//	        }	        
		}
			
		
		public function set peak(num:Number):void{
			this._peak = num;
		}	
		public function get peak():Number{
			return _peak;
		}
		public function set nadir(num:Number):void{
			this._nadir = num;
		}	
		public function get nadir():Number{
			return _nadir;
		}
			
				
		public function set data(value:Object):void{
	        if (_chartItem == value) return;
	          // setData also is executed if there is a Legend Data 
	          // defined for the chart. We validate that only chartItems are 
	          // assigned to the chartItem class. 
	        if (value is LegendData) 
	        	return;
			
	        _chartItem = ChartItem(value);	        
	    }	
		
	    public function get data():Object
	    {
	        return _chartItem;
	    }
                                         
    	override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
  		{
	        super.updateDisplayList(unscaledWidth, unscaledHeight);
	        
	        var rc:Rectangle = new Rectangle(0, 0, width, height);	       
	        var g:Graphics = graphics;
	        g.clear();        
	        g.moveTo(rc.left, rc.top);
//	        trace("width: " + width + " / height: " + height + "\trc.bottom: " + rc.bottom + "unscaledHeight: "+unscaledHeight)
	         
	         
	         
	         
	         
	        if (_chartItem == null) return;// _chartItem has no data

	           
	        var cs:ColumnSeries = _chartItem.element as ColumnSeries;
	        var csi:ColumnSeriesItem = _chartItem as ColumnSeriesItem;
//			var currFormat:Object = new NumberFormatter();
//			currFormat.precision = 0;
//			currFormat.rounding = "nearest";
			
	       	var val:Number = csi.item[cs.yField];		       	
//       		label.text =  currFormat.format(val)+"";	 
       		
	       	var min_val:Number = csi.item[cs.minField];		       	
//			label_min.text = currFormat.format(min_val)+"";
			
//	       	label.width = 30;	       	
//	       	label_min.width = 30;	       	
	       	
//	       	label.height = label.textHeight;
//	       	label_min.height = label.textHeight;
//			var labelHeight:int = label.textHeight;// + 2;
				       		        	 
	        // label's default y is 0. if the bar is too short we need to move it up a bit
//	       	var barYpos:Number = csi.y;
//	       	var minYpos:Number = csi.min;
	       	
//			var barHeight:Number = minYpos - barYpos;
			
	       
	       //강수 axis maximum 보다 큰 값만 표출!!
//	       if(_peak < val){
//	       	   label.y = -(csi.y); // 레이블 바 하이트 위치에 생성.. 바하이트는 csi.min - csi.y 이므로 레이블 최 상단에 걍 박을려면 csi.y 만큼 빼버리면 레이블 위치 잡힘 
//		       addChild(label);
//	       }
	       // 강수 axis minimu 보다 작은값 표출 하단에!!
//	       if(_nadir >  min_val){
//	       	   label_min.y = +csi.min -20;//-1 * (labelHeight -barHeight)
//	       	   trace(label_min.text+"\tcsi.min: "+ csi.min+"\tcsi.minValue?: " + csi.minValue)
//	       	   label_min.x =  10;
////	       	   addChild(label_min);
//	       }
	       
			// Draw the column
			g.lineStyle(1,0x000000,1);								//alpha     ratio
			g.moveTo(rc.right,rc.top)
//	        g.lineTo(rc.right,rc.top);
	        g.lineTo(rc.right,rc.bottom);
//	        g.lineTo(rc.left,rc.bottom);
//	        g.lineTo(rc.left,rc.top);
  		}
	}
}



