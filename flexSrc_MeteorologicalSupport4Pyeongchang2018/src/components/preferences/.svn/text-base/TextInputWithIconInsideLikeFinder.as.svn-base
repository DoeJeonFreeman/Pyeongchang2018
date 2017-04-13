package components.preferences{
	
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.controls.TextInput;
	import mx.core.mx_internal;

	use namespace mx_internal;
	
	public class TextInputWithIconInsideLikeFinder extends TextInput{
		
		
	    private var _image:Image;
		
		private var _clear:Image;
	
		[Bindable]
		[Embed(source="asset/personalization/searchIcon3.png")]
		public var finderIcon:Class;
	
		[Bindable]
		[Embed(source="asset/personalization/btn_clear.png")]
		public var clearIcon:Class;
	
	    public function TextInputWithIconInsideLikeFinder(){
	        super();
	        this.addEventListener(Event.CHANGE,textChangeListner);
	    }
	
		
		public function textChangeListner(e:Event):void{
			if(this.text.length > 0){
				this._clear.visible = true
			}else{
				this._clear.visible = false
			}
		}
	
	    override protected function createChildren():void{
	        super.createChildren();
	
	        _image = new Image();
	        _image.source = finderIcon;
	
	        addChild(DisplayObject(_image));
	        
	        //clear button..
	        _clear= new Image();
	        _clear.source = clearIcon;
	        _clear.addEventListener(MouseEvent.CLICK,clearTextInput);
	
	        addChild(DisplayObject(_clear));
	        
	        //clear button..
	        
	    }
	
		public function clearTextInput(e:Event):void{
			if(this.text.length > 0){
				this.text='';
				this.dispatchEvent(new Event(Event.CHANGE,true,false));
			}
		}
	
	    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
	        super.updateDisplayList(unscaledWidth, unscaledHeight);
			trace('TextInputWithIconInsideLikeFinder.as updateDisplayList()..');
	        this._image.width = 16;
	        this._image.height = 16;
	
//	        this._image.x = this.width - this._image.width - 5;
//	        this._image.y = this.height - this._image.height;

	        this._image.alpha = 0.9;
	        this._image.x = 2;
	        this._image.y = 2;
	
	        this.textField.width = this.width - this._image.width - 5;
	        
	        
	        //clear button..
	        this._clear.width = 10;
	        this._clear.height = 10;
	        this._clear.x = this.width - this._clear.width - 5;
	        this._clear.y = 5;
			this._clear.visible = false;	        
	        //clear button..
	        
	        
	    }
	    
	}


}