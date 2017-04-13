package comp.chart.graphic{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	
	public class CloudAmount extends Sprite{
		
		private var _centerX:int = 0;
		private var _centerY:int = 0;
		private var _radius:int  = 9;
		private var gp:Graphics;
		
		public function setRadius(radiusVal:int):void{
			this._radius = radiusVal;	
		}	
		
		public function CloudAmount(caVal:String ){
			super();
			gp = this.graphics;
			drawCloudAmount(caVal);
		}
		
		private function drawCloudAmount(cAmount:String):void{
			gp.clear();
			gp.lineStyle(1,0x000000,1.0);

			if(cAmount=="1"){
				gp.lineStyle(1,0x000000,1.0);
				gp.beginFill(0xFFFFFF,1.0);
				gp.drawCircle(_centerX, _centerY, _radius);
				gp.endFill();
			}else if(cAmount=="2"){
				gp.lineStyle(2,0x000000, 0.8);
				gp.drawCircle(_centerX, _centerY, _radius);
				drawArc((90+(90*2))/360,  90/360, 90, 0x000000);    //90
      			drawArc((90+(90*3))/360, 270/360, 270, 0xFFFFFF);   //270
			}else if(cAmount=="3"){
				gp.lineStyle(2,0x000000,0.8);
				gp.drawCircle(_centerX, _centerY, _radius);
				drawArc((90+(90*2))/360, 270/360,  270, 0x000000);   //270
      			drawArc((90+(90*1))/360,  90/360, 90, 0xFFFFFF);   //90
			}else if(cAmount=="4"){
				gp.beginFill(0x000000,1);
				gp.drawCircle(_centerX, _centerY, _radius);
			}else{
				trace('[drawCloudAmount] Err. cAmount is ' + cAmount);	
			}	
		}
		

      		private function drawArc( _startAngle, _arcAngle, _steps, fillColor) {
  	 			var angle;
  				var xx, yy:int;
			    var startAngle, endAngle, arcAngle;
  				var angleStep, steps;
   				gp.lineStyle(1,0x000000,0.0);
   				gp.beginFill(fillColor,1);
 				gp.moveTo(_centerX, _centerY);
//  				steps = 20;
  			    endAngle = _startAngle + _arcAngle;
                angleStep = _arcAngle/_steps;
   					for (var i=0; i<=_steps; i++) {
  					  	angle = (endAngle - (i * angleStep)) * 2 * Math.PI;
					    xx = _centerX + Math.cos(angle) * _radius;
   						yy = _centerY + Math.sin(angle) * _radius;
   						gp.lineTo(xx, yy);
  				    }
 				gp.moveTo(xx, yy);
     			gp.lineTo(_centerX, _centerY); 
  			}
      		
		
		
	}// class
	
} // package