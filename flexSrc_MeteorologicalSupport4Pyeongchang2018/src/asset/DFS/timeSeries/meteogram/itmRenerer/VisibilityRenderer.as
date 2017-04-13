package asset.DFS.timeSeries.meteogram.itmRenerer
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.LegendData;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	public class VisibilityRenderer extends UIComponent implements IDataRenderer
	{
//		private var label:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem

//		public var showSeriesLabel:Boolean = false;

	    public function VisibilityRenderer():void
	    {
	        super();	        
	    }

		override protected function createChildren():void
		{	
			super.createChildren();
			
			
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
                                         
		
    	override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void{
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
			
			
			
			var barColour:uint = 0x0077EE;
			if(val == 1){
				barColour = 0xB22222;
			}else if(val == 2){
				barColour = 0xFF1500;
			}else if(val == 3){
				barColour = 0xADFF2F;
			}else if(val == 4){
				barColour = 0x00FA9A;
			}else if(val == 5){
				barColour = 0x0077EE;
//			}else if(10.0 < val && val < 999){
//				barColour = 0x3CB371;
			}
			
			
			
			g.lineStyle(1,barColour,getAlpha(val));							
			g.beginFill(barColour,getAlpha(val));
//			g.lineStyle(1,barColour,0.2);							
//			g.beginFill(barColour,0.5);
	        g.lineTo(rc.right +0,rc.top);
	        g.lineTo(rc.right +0,rc.bottom);
	        g.lineTo(rc.left +0,rc.bottom);
	        g.lineTo(rc.left +0,rc.top);
	        g.endFill();    

//			trace("[rc.bottom]"+rc.bottom  + " .vs. [val]" + val)	                
		        
  		}
		
		public function getAlpha(val:Number):Number {
			trace(1.0/val)
			return 1.0/val;
		}
	}
}