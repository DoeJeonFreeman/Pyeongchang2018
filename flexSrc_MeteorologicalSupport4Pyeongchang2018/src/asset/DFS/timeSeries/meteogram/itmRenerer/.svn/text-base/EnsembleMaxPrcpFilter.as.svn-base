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
	
	public class EnsembleMaxPrcpFilter extends UIComponent implements IDataRenderer
	{
		private var label:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem
		private var _vAxisMaximum:Number;

	    public function EnsembleMaxPrcpFilter():void
	    {
	        super();	        
	    }

		override protected function createChildren():void
		{	
			super.createChildren();
			if (label == null)
	        {
		        label = new Label();
		        label.truncateToFit = true;	
		        label.setStyle("fontSize", 10);	      
		        label.setStyle("textAlign", "left");
		        label.setStyle("color", 0xFF0000);
		        label.setStyle("paddingTop",-2);
	        }	        
		}
			
		
		public function set vAxisMaximum(num:Number):void{
			this._vAxisMaximum = num;
		}	
		
		public function get vAxisMaximum():Number{
			return _vAxisMaximum;
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
	         
	         
	         
	         
	         
	        if (_chartItem == null) return;// _chartItem has no data

	           
	        var cs:ColumnSeries = _chartItem.element as ColumnSeries;
	        var csi:ColumnSeriesItem = _chartItem as ColumnSeriesItem;
			var currFormat:Object = new NumberFormatter();
			currFormat.precision = 0;
			currFormat.rounding = "nearest";
	       	
	       	var val:Number = csi.item[cs.yField];		       	
       		label.text =  currFormat.format(val)+"";	 
			
			
	       	label.width = 30;	       	
	       	label.height = label.textHeight;
			var labelHeight:int = label.textHeight;// + 2;
				       		        	 
	       	var barYpos:Number = csi.y;
	       	var minYpos:Number = csi.min;
	       	
			var barHeight:Number = minYpos - barYpos;
			var labelColor:uint = 0xFF0000; // red
       		label.y = -(csi.y); 
			g.lineStyle(1,0x000000,1);							
			g.moveTo(rc.right,rc.top)
	        g.lineTo(rc.right,rc.bottom);
  		}
	}
}



