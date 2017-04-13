package com.doe.flex.ui.form.util 
{
	import mx.controls.CheckBox;

	/**
	 *  Background color of the CheckBox.
	 *  @default 0xFFFFFF
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  The alpha value for the background.
	 *  @default 0
	 */
	[Style(name="backgroundAlpha", type="Number", format="Length", inherit="no")]

	[IconFile("CheckBox.png")]

	/**
	 * Extends the default CheckBox class to fix an annoying problem that happens when the 
	 * mouse moves in between the checkbox and the label and the control loses focus and 
	 * the tooltip gets hidden. 
	 * It also adds support for choosing a background color and alpha value (defaults to 0)
	 * to paint instead of the invisible box.
	 * 
	 * @author Chris Callendar
	 */
	public class CheckBox extends mx.controls.CheckBox
	{
		
		public function CheckBox() {
			super();
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			
			// paints the background with a color and alpha value.
			// by default the background is invisible, but is still painted so that 
			// tooltips stay visible when the mouse is in between the checkbox and the label
			var bgColor:uint = 0xffffff;
			var bgAlpha:Number = 0;
			var style:Object = getStyle("backgroundColor");
			if (style) {
				bgColor = uint(Number(style));
				bgAlpha = getStyle("backgroundAlpha");
				if (isNaN(bgAlpha) || (bgAlpha < 0) || (bgAlpha > 1)) {
					bgAlpha = 0;
				}
			}
			
			graphics.clear();
			graphics.beginFill(bgColor, bgAlpha);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
	}
}