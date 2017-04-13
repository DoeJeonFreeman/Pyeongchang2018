package comp.chart.chartingTool{
	import flash.display.Sprite;
	
	public class LegendItem_filledRect extends Sprite {
		
		function LegendItem_filledRect(colorInHexadecimal:uint=0xFF794B, width:uint=10, height:uint=15):void {
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(colorInHexadecimal);
			rect.graphics.drawRect(0, 0, width, height);
			rect.graphics.endFill();
			addChild(rect);
			
		}
	}
}