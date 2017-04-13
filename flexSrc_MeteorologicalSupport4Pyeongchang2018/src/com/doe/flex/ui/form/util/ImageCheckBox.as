package com.doe.flex.ui.form.util 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import mx.controls.ButtonLabelPlacement;
	import mx.controls.Image;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	
	/** Events forwarded from the SWFLoader */
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	[Event(name="init", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="open", type="flash.events.Event")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	[Event(name="unload", type="flash.events.Event")]

	[IconFile("ImageCheckBox.png")]
	
	/**
	 * Extends the CheckBox class to add support for showing an image between the 
	 * checkbox and the label.
	 * 
	 * @author Chris Callendar
	 * @date February 4th, 2010
	 */
	public class ImageCheckBox extends CheckBox
	{
		
		private var _image:Image;
		private var explicitImageWidth:Number = NaN;
		private var explicitImageHeight:Number = NaN;
		
		public function ImageCheckBox() {
			super();
		}
		
		public function get image():Image {
			if (_image == null) {
				_image = new Image();
				// forward these events
				_image.addEventListener(Event.COMPLETE, imageEventHandler);
				_image.addEventListener(Event.INIT, imageEventHandler);
				_image.addEventListener(Event.OPEN, imageEventHandler);
				_image.addEventListener(Event.UNLOAD, imageEventHandler);
				_image.addEventListener(HTTPStatusEvent.HTTP_STATUS, imageEventHandler);
				_image.addEventListener(IOErrorEvent.IO_ERROR, imageEventHandler);
				_image.addEventListener(SecurityErrorEvent.SECURITY_ERROR, imageEventHandler);
				_image.addEventListener(ProgressEvent.PROGRESS, imageEventHandler);
			}
			return _image;
		}
		
	    [Bindable("imageSourceChanged")]
		[Inspectable(category="General", defaultValue="", format="File")]
	    public function set imageSource(value:Object):void {
	    	if (value != image.source) {
	    		if (value == null) {
	    			image.unloadAndStop();	// also sets source to null	
	    		} else {
	        		image.source = value;
	      		}
	        	invalidateSize();
	        	dispatchEvent(new Event("imageSourceChanged"));
	        }
	    }
	    
	    public function get imageSource():Object {
	    	return image.source;
	    }
		
		[Inspectable(category="Size")]
		public function set imageWidth(value:Number):void {
			if (isNaN(value) || (value >= 0)) {
				explicitImageWidth = value;
				if (value >= 0) {
					image.width = value;
				}
			}
		}
		
		public function get imageWidth():Number {
			return image.width;
		}
		
		[Inspectable(category="Size")]
		public function set imageHeight(value:Number):void {
			if (isNaN(value) || (value >= 0)) {
				explicitImageHeight = value;
				if (value >= 0) {
					image.height = value;
				}
			}
		}
		
		public function get imageHeight():Number {
			return image.height;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			
			addChild(image);
		}
		
		override protected function measure():void {
			super.measure();
			
			// include the width of the image in the measured with
			// and make sure the image height isn't larger than the measured height
			if (image.source) {
				var iw:Number = image.width;
				var ih:Number = image.height;
				if ((iw > 0) && (ih > 0)) {
					var hgap:uint = uint(Number(getStyle("horizontalGap")));
					var checkbox:IFlexDisplayObject = mx_internal::getCurrentIcon();
					var cbw:Number = (checkbox ? checkbox.width + hgap : 0);
					var cbh:Number = (checkbox ? checkbox.height : 0);
					if ((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)) {
						measuredMinWidth += iw + hgap + 2;
						measuredWidth = measuredMinWidth;
					} else {
						var cbAndImage:Number = cbw + iw + 2;
						if (cbAndImage > measuredMinWidth) {
							measuredMinWidth = cbAndImage;
							measuredWidth = measuredMinWidth;
						}
						
					}
					if (measuredMinHeight < ih) {
						measuredMinHeight = ih;
						measuredHeight = ih;
					}
				}
			} 
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			
			// make sure the image is on top
			var index:int = getChildIndex(image);
			if (index != (numChildren - 1)) {
				setChildIndex(image, numChildren - 1);
			}
			
			// make sure the image size has been set
			var iw:Number = image.width;
			var icw:Number = image.contentWidth;
			var ih:Number = image.height;
			var ich:Number = image.contentHeight;
			if (((iw == 0) || (ih == 0)) &&  
				((explicitImageWidth != 0) && (explicitImageHeight != 0)) && 
				((icw > 0) || (ich > 0))) {
				resizeImage();
			}
			
			// position the image
			positionImage(w, h);
		}
		
		/**
		 * Positions the image between the checkbox and the label.
		 */
		protected function positionImage(w:Number, h:Number):void {
			if (image.source) {
				var padLeft:uint = uint(Number(getStyle("paddingLeft")));
				var padTop:uint = uint(Number(getStyle("paddingTop")));
				var hgap:uint = uint(Number(getStyle("horizontalGap")));
				var vgap:uint = uint(Number(getStyle("verticalGap")));

				var checkbox:IFlexDisplayObject = mx_internal::getCurrentIcon();
				var cbw:Number = (checkbox ? checkbox.width + hgap : 0);
				var cbh:Number = (checkbox ? checkbox.height : 0);

				var ix:Number = padLeft;
				var iy:Number = padTop;
				var iw:Number = image.width;
				var ih:Number = image.height;
				
				// center vertically on the checkbox
				if (checkbox) {
					iy = Math.max(0, checkbox.y + ((cbh - ih) / 2));
				}
				
				if (labelPlacement == ButtonLabelPlacement.RIGHT) {
					ix = padLeft + cbw + 2;
					textField.x += iw + hgap;
				} else if (labelPlacement == ButtonLabelPlacement.LEFT) {
					ix = textField.x + textField.width + hgap;
					if (checkbox) {
						checkbox.x += iw + hgap + 2;
					}
				} else {
					// position the image to the right of the checkbox
					ix = padLeft + cbw + 2;
				}
				
				if ((ix != image.x) || (iy != image.y)) {
					image.move(ix, iy);
				}
			}
		}
		
		/**
		 * Resizes the image using either the explicit sizes set by the user,
		 * or the actual content size.
		 * If one of the explicit sizes (width or height) has been set, then the 
		 * other is calculated based on the content size.
		 */
		protected function resizeImage():void {
			var icw:Number = image.contentWidth;
			var ich:Number = image.contentHeight;
			if (isNaN(explicitImageWidth) && isNaN(explicitImageHeight)) {
				// no explicit image sizes set - just use the real image size
				image.width = icw;
				image.height = ich;
			} else if (!isNaN(explicitImageWidth)) {
				// an explicit width was given, so scale the image height
				image.width = explicitImageWidth;
				image.height = (icw == 0 ? 0 : (ich / icw) * explicitImageWidth);
			} else if (!isNaN(explicitImageHeight)) {
				// an explicit height was gicen, so scale the image width
				image.height = explicitImageHeight;
				image.width = (ich == 0 ? 0 : (icw / ich) * explicitImageHeight);
			} else {
				// both the width and height were explicitly set
				image.width = explicitImageWidth;
				image.height = explicitImageHeight;
			}
			invalidateSize();
		}
		
		protected function imageEventHandler(event:Event):void {
			if (event.type == Event.COMPLETE) {
				// must set the proper sizes for the image to show up
				resizeImage();
			}

			// forward the event, but only if there is a listener
			// otherwise the IO_ERROR will cause an ugly error box to popup
			if (hasEventListener(event.type)) {
				dispatchEvent(event.clone());
			}
		}
		
	}
}