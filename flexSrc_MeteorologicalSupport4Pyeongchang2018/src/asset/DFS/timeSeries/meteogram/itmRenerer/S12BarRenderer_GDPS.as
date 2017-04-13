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
	
	public class S12BarRenderer_GDPS extends UIComponent implements IDataRenderer
	{
//		private var label:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem

//		public var showSeriesLabel:Boolean = false;

	    public function S12BarRenderer_GDPS():void
	    {
	        super();	        
	    }

		override protected function createChildren():void
		{	
			super.createChildren();
			
			
			//레이블 ㄴ ㄴ 
			//멀티에서는 그리지마
			//멀티에서는 그리지마
			//멀티에서는 그리지마
//			if (label == null)
//	        {
//				// create and add the label
//		        label = new Label();
//		        label.truncateToFit = true;	
//		        label.setStyle("fontSize", 12);	    
//				label.setStyle("color",0x000066);
//		        label.setStyle("textAlign", "center");
//		        addChild(label);
//	        }	        
			//멀티에서는 그리지마
			//멀티에서는 그리지마
			//멀티에서는 그리지마
		}
				
		public function set data(value:Object):void
	    {
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
	         
	        if (_chartItem == null) // _chartItem has no data
	           return;
	           
	        var cs:ColumnSeries = _chartItem.element as ColumnSeries;
	        var csi:ColumnSeriesItem = _chartItem as ColumnSeriesItem;
			
	       	// set the label	
	       	
	       	var val:Number = csi.item[cs.yField];		       	
	       	
	       	
	       	
//	       	if(showSeriesLabel){
//	       		label.text =  val+"";	       		
//		       	label.width = label.maxWidth = 35//unscaledWidth;	       	
//		       	label.truncateToFit = true;
//		       	label.height = label.textHeight;
//				var labelHeight:int = label.textHeight + 2;
//					       		        	 
//		        // label's default y is 0. if the bar is too short we need to move it up a bit
//		       	var barYpos:Number = csi.y;
//		       	var minYpos:Number = csi.min;
//		       	
//				var barHeight:Number = minYpos - barYpos;
//				var labelColor:uint = 0x222222; // light black
//		       
////	       		label.y = -20; // -1 * (labelHeight - barHeight);
////				label.x = - 9; 
////				
////				label.setStyle("color", labelColor);
////				label.setActualSize(label.getExplicitOrMeasuredWidth(),label.getExplicitOrMeasuredHeight());
//	       	}
			
			
			g.lineStyle(1,0xF2C450, 0.4);								//alpha     ratio [0x0088EE,0xFCFCFD] 0x0077EE,0xFCFCFD
			g.beginFill(0xF2C450,.3);
	        g.lineTo(rc.right +0,rc.top);
	        g.lineTo(rc.right +0,rc.bottom);
	        g.lineTo(rc.left +0,rc.bottom);
	        g.lineTo(rc.left +0,rc.top);
	        g.endFill();    

	                
		        
  		}
	}
}