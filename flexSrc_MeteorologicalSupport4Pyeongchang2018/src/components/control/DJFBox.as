package components.control
{
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	public class DJFBox extends VBox 
	{
		
		protected var rendered:Boolean;
		protected var originalItems:Array;
		
		function DJFBox() 
		{
			horizontalScrollPolicy = ScrollPolicy.OFF;
			addEventListener(ResizeEvent.RESIZE, onResize);
		}
		
		protected function render():void 
		{
			
			function newRow():HBox 
			{
				currentRow = new HBox();
				addChild(currentRow);
				return currentRow;
			} 
			
			if (!rendered) 
			{   
				var currentRow:HBox;
				var sum:int = 0;
				var subWidth:int = 0;
				
				if (!originalItems) originalItems = getChildren();
				
				removeAllChildren();
				
				newRow();
				
				for each (var d:UIComponent in originalItems) 
				{ 
					subWidth = d.width;
					// count up horizontalGap
					subWidth += currentRow.getChildren().length > 0 ? currentRow.getStyle('horizontalGap') : 0;
					
					if (sum + subWidth < width) 
					{
						sum += subWidth;     
						currentRow.addChild(d);
					} 
					else 
					{
						newRow();
						currentRow.addChild(d);
						sum = d.width;
					}
				}
				rendered = true;
			}
		}
		
		protected function onResize(e:ResizeEvent):void 
		{  
			rendered = false;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			render();
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
	}
}