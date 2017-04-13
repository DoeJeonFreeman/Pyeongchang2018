package asset.DFS.timeSeries.meteogram.itmRenerer
{
	import flash.display.GradientType;
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
	import mx.graphics.SolidColor;
	
	public class EnsembleMMXBar extends UIComponent implements IDataRenderer
	{
		private var label:Label;
		private var _chartItem:ChartItem; // stores current ColumnSeriesItem

	    public function EnsembleMMXBar():void
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
	        
	        var rc:Rectangle = new Rectangle(0, 0, width, height);	       
	        var g:Graphics = graphics;
	        g.clear();        
	        g.moveTo(rc.left, rc.top);
	         
	         trace(width +" width .vs. height "+height)
	         
	         
	         
	        if (_chartItem == null) // _chartItem has no data
	           return;
	           
	        var cs:ColumnSeries = _chartItem.element as ColumnSeries;
	        var csi:ColumnSeriesItem = _chartItem as ColumnSeriesItem;
			
	       	// set the label	
   						var currFormat:Object = new NumberFormatter();
						currFormat.precision = 1;
						currFormat.rounding = "nearest";
	       	
	       	var val:Number = csi.item[cs.yField];		       	
       		label.text =  currFormat.format(val)+"";	       		
	       	label.width = label.maxWidth = unscaledWidth;	       	
	       	label.height = label.textHeight;
			var labelHeight:int = label.textHeight + 2;
				       		        	 
	        // label's default y is 0. if the bar is too short we need to move it up a bit
	       	var barYpos:Number = csi.y;
	       	var minYpos:Number = csi.min;
	       	
			var barHeight:Number = minYpos - barYpos;
			var labelColor:uint = 0x222222; // light black
	       
//	       	if (barHeight < labelHeight) // if no room for label
//	       	{
				// nudge label up the amount of pixels missing
				// 얘만 수정하면
	       		label.y = -20; // -1 * (labelHeight - barHeight);
//	       		labelColor = 0x222222; // label will appear on white background, so make it dark	       		
//	       	}
//	       	else
//			{	
//				// center the label vertically in the bar
//	       		label.y =barHeight-labelHeight*5;     // barHeight / 2  - labelHeight / 2;
//	       		labelColor = 0x000099; //blue
//			}
			
			label.setStyle("color", labelColor);
	       
	       
// 			   vertical gradient exam !!!!!!
//            var ge1:GradientEntry = new GradientEntry(0xCCFF99, 0); 
//            var ge2:GradientEntry = new GradientEntry(0x99FF00, .33); 
//            var ge3:GradientEntry = new GradientEntry(0x669900, .66); 
//            var lg1:LinearGradient = new LinearGradient(); 
//            lg1.entries = [ge1, ge2, ge3]; 
//            lg1.angle = 90;
	       
//	       <mx:GradientEntry color="0x0088EE"
//                             ratio="0.0"
//                             alpha="0.5" />
//         <mx:GradientEntry color="0x99DDEE" 
//                             ratio="1.0"
//                             alpha="1.0" />
	       
	       
			// Draw the column
			
  				var currKST:String = String(csi.xValue);
				currKST = currKST.substr(currKST.length-2,2);
		        var isMax:Boolean = (currKST == '15')? true : false; 
				var fillColour:SolidColor = (isMax)? new SolidColor(0xf89722) : new SolidColor(0x52c5fe);

			
			if(! isNaN(height)){
	//			g.lineStyle(1,0xCCCCCC,0.2);								//alpha     ratio [0x0088EE,0xFCFCFD] 0x0077EE,0xFCFCFD
				g.lineStyle(1,0x000000,1);								//alpha     ratio [0x0088EE,0xFCFCFD] 0x0077EE,0xFCFCFD
				g.beginGradientFill(GradientType.LINEAR,[fillColour.color,fillColour.color],[1,1],[0,255],null,null,null,0);
		        g.lineTo(rc.right,rc.top);
		        g.lineTo(rc.right,rc.bottom);
		        g.lineTo(rc.left,rc.bottom);
		        g.lineTo(rc.left,rc.top);
		        g.endFill();    
			}
  		}
	}
}