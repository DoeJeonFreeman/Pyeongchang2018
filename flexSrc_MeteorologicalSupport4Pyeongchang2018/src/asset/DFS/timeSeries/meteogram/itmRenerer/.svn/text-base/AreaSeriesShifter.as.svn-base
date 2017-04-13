package asset.DFS.STN_NPPM.meteogram.itmRenerer
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.LegendData;
	import mx.charts.series.AreaSeries;
	import mx.charts.series.items.AreaSeriesItem;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	public class AreaSeriesShifter extends UIComponent implements IDataRenderer
	{
		private var label:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem

	    public function AreaSeriesShifter():void
	    {
	        super();	        
	    }

		override protected function createChildren():void
		{	
			super.createChildren();
			
			if (label == null)
	        {
				// create and add the label
		        label = new Label();
		        label.truncateToFit = true;	
		        label.setStyle("fontSize", 12);	    
				label.setStyle("color",0x000066);
		        label.setStyle("textAlign", "center");
		        label.text = 'fxxk';
//		        addChild(label);
	        }	        
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
	        
//	        var rc:Rectangle = new Rectangle(0, 0, width, height);	       
//	        var g:Graphics = graphics;
//	        g.clear();        
//	        g.moveTo(rc.left, rc.top);

			var w:Number =  0.5;
	        
	        var rc:Rectangle = new Rectangle(w, w, width - 2 * w, height - 2 * w);
	        
	        var g:Graphics = graphics;
	        g.clear();      
	        g.moveTo(rc.left,rc.top);

//	         
	        if (_chartItem == null) // _chartItem has no data
	           return;
//	           
	        var cs:AreaSeries= _chartItem.element as AreaSeries;
	        var csi:AreaSeriesItem= _chartItem as AreaSeriesItem;
//			
//	       	// set the label	
	       	var val:Number = csi.item[cs.yField];		       	
//       		label.text =  val+"";	       		
	       	label.width = label.maxWidth = unscaledWidth;	       	
	       	label.height = label.textHeight;
			var labelHeight:int = label.textHeight + 2;
//				       		        	 
//	        // label's default y is 0. if the bar is too short we need to move it up a bit
	       	var barYpos:Number = csi.y;
	       	var minYpos:Number = csi.min;
//	       	
			var barHeight:Number = minYpos - barYpos;
			var labelColor:uint = 0x222222; // light black
//	       
       		label.y = -20; // -1 * (labelHeight - barHeight);
//			
			label.setStyle("color", labelColor);
//			
//			g.lineStyle(1,0x0066EE,0.2);								//alpha     ratio [0x0088EE,0xFCFCFD] 0x0077EE,0xFCFCFD
//			g.beginFill(0x0077EE,0.5);
//	        g.lineTo(rc.right +0,rc.top);
//	        g.lineTo(rc.right +0,rc.bottom);
//	        g.lineTo(rc.left +0,rc.bottom);
//	        g.lineTo(rc.left +0,rc.top);
//	        g.endFill();    

	                
//	        var w:Number =  0.5;
//	        
//	        var rc:Rectangle = new Rectangle(w, w, width - 2 * w, height - 2 * w);
//	        
//	        var g:Graphics = graphics;
	        
			g.lineStyle(1,0x0066EE,0.2);								//alpha     ratio [0x0088EE,0xFCFCFD] 0x0077EE,0xFCFCFD
			g.beginFill(0xFDD7E4,0.5);
			
	        
	        g.lineTo(rc.right,rc.top);
	        g.lineTo(rc.right,rc.bottom);
	        g.lineTo(rc.left,rc.bottom);
	        g.lineTo(rc.left,rc.top);
		        
  		}
	}
}