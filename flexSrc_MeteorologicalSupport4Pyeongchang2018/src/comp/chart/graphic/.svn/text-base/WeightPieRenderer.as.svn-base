package comp.chart.graphic{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	
	
	
	public class WeightPieRenderer extends Sprite{
		
		private var _centerX:int = 0;
		private var _centerY:int = 0;
		private var _radius:int  = 10;
		private var gp:Graphics;
		private var highestOne:Object;
		
		public function setRadius(radiusVal:int):void{
			this._radius = radiusVal;	
		}	
		
		public function WeightPieRenderer(caVal:Object ){
			super();
			gp = this.graphics;
			drawCloudAmount(caVal);
		}
		
		private function drawCloudAmount(cAmount:Object):void{
			gp.clear();
			gp.lineStyle(1,0x000000,.6);

			
			
			var weightArr:Array = cAmount.weight.split(" ");
			var meArr:ArrayCollection = new ArrayCollection();
			trace(weightArr.length);
			for each(var w:String in weightArr){
				var splendid:Array = w.split(":"); 
				meArr.addItem({type:splendid[0], percentage:splendid[1]});
			}
			
			
			
			var endAngle:Number = (90+(90*2))/360; //전역으로 빼버려 최초에 디그리0 값 걸어주고

//			var angle_claer:Number = (Number(cAmount.clear)/100)*360;
//			var angle_scattered:Number = (Number(cAmount.scattered)/100)*360;
//			var angle_broken:Number = (Number(cAmount.broken)/100)*360;
//			var angle_overcast:Number = (Number(cAmount.overcast)/100)*360;
//			
//			if(angle_claer==360){
//				gp.beginFill(0xFFFFFF);
//				gp.drawCircle(_centerX, _centerY, _radius);
//			}else if(angle_scattered==360){
//				gp.beginFill(0xd1e3f0);
//				gp.drawCircle(_centerX, _centerY, _radius);
//			}else if(angle_broken==360){
//				gp.beginFill(0x72b2d8);
//				gp.drawCircle(_centerX, _centerY, _radius);
//			}else if(angle_overcast==360){
//				gp.beginFill(0x3e89c2);
//				gp.drawCircle(_centerX, _centerY, _radius);
//			}else{
//				gp.beginFill(0xFFFFFF);
//				endAngle = DrawSolidArc (0, 0, 0, _radius, (90+(90*2))/360,  angle_claer/360, angle_claer);
//				gp.beginFill(0xd1e3f0);
//				endAngle = DrawSolidArc (0, 0, 0, _radius, endAngle,  angle_scattered/360 , angle_scattered);
//				gp.beginFill(0x72b2d8);
//				endAngle = DrawSolidArc (0, 0, 0, _radius, endAngle,  angle_broken/360, angle_broken);
//				gp.beginFill(0x3e89c2);
//				DrawSolidArc (0, 0, 0, _radius, endAngle,  angle_overcast/360, angle_overcast);
//				DrawSolidArc (0, 0, 0, _radius, endAngle,  angle_overcast/360, angle_overcast);
//			}
			
	
			
			
			
			for each(var item:Object in meArr){
				if((Number(item.percentage)/100)*360 == 360){
					gp.drawCircle(_centerX, _centerY, _radius);
					continue;
				}else{
					var percentage:Number = (Number(item.percentage)/100)*360;
					trace();
					gp.beginFill(getPTYFillColour(item));
					endAngle = DrawSolidArc (0, 0, 0, _radius, endAngle,  percentage/360, percentage);
				}
			}
			
			
			
			
			
			
			
			gp.endFill();
		}
		
//		0x98d4d0
//		0xf2f2f2
//		0x2e728c
//		0xafd3e1
//		0x03a696
		
//		0x99bf60
//		0xf2e8b6
//		0xf2cd5e
//		0xf28d52
//		0xf27052

//		0xde443a
//		0xebe9e2
//		0x79bbc3
//		0xd96762
//		0xc3b9be
		
		public function getPTYFillColour(item:Object):int{
			var whichType:String = item.type;
			var colour:int;
			if(whichType == "RDPS_PMOS"){        //라블
				colour = 0xde443a;
			}else if(whichType == "ECMW_PMOS"){ //스블
				colour = 0xebe9e2;
			}else if(whichType == "RDPS_NPPM"){   //딥블
				colour = 0x79bbc3;
			}else if(whichType == "GDPS_NPPM"){ //라그
				colour = 0xd96762;
			}else if(whichType == "ECMW_NPPM"){ //
				colour = 0xc3b9be;
			}else{
				colour = 0xf27c38;
			}
			return colour;		
		}
//		
//		public function getPTYFillColour(item:Object):int{
//			var whichType:String = item.type;
//			var colour:int;
//			if(whichType == "RDPS_PMOS"){        //rain
//				colour = 0xfbbc05;
//			}else if(whichType == "ECMW_PMOS"){ //sleet
//				colour = 0x329AE1;
//			}else if(whichType == "RDPS_NPPM"){   //snow
//				colour = 0x41C01C;
//			}else if(whichType == "GDPS_NPPM"){ //clear
//				colour = 0x1D9657;
//			}else if(whichType == "ECMW_NPPM"){ //clear
//				colour = 0x2D6FE8;
//			}else{
//				colour = 0xf27c38;
//			}
//			return colour;		
//		}
		
      		private function drawArc( _startAngle, _arcAngle, _steps, fillColor) {
  	 			var angle;
  				var xx, yy:int;
			    var startAngle, endAngle, arcAngle;
  				var angleStep, steps;
   				gp.lineStyle(1,0x000000,1.0);
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
      		
      		
      		//
			// The DrawSolidArc function takes standard arc drawing
			// arguments but the "radius" has been split into 2 different
			// variables, "innerRadius" and "outerRadius".
			private function DrawSolidArc (centerX, centerY, innerRadius, outerRadius, startAngle, arcAngle, steps){
			    //
//			    if(startAngle==(90+(90*2))/360 && (arcAngle == 0 ||arcAngle == 360)){
//				    gp.lineStyle(0,0x000000,0);
//			    	trace("arcAngle is "+arcAngle);
//			    	return startAngle + arcAngle;
//			    }else{
//				    gp.lineStyle(1,0x0000,.8);
//			    }
			    
			    // Used to convert angles to radians.
			    var twoPI = 2 * Math.PI;
			    //
			    // How much to rotate for each point along the arc.
			    var angleStep = arcAngle/steps;
			    //
			    // Variables set later.
			    var angle, i, endAngle;
			    //
			    // Find the coordinates of the first point on the inner arc.
			    var xx = centerX + Math.cos(startAngle * twoPI) * innerRadius;
			    var yy = centerY + Math.sin(startAngle * twoPI) * innerRadius;
			    //
			    // Store the coordiantes in an object.
			    var startPoint = {x:xx, y:yy};
			    //
			    // Move to the first point on the inner arc.
			    gp.moveTo(xx, yy);
			    //
			    
			    /*
			     Draw all of the other points along the inner arc.
			    for(i=1; i<=steps; i++){
			        angle = (startAngle + i * angleStep) * twoPI;
			        xx = centerX + Math.cos(angle) * innerRadius;
			        yy = centerY + Math.sin(angle) * innerRadius;
			        gp.lineTo(xx, yy);
			    }
			    */
			    //
			    // Determine the ending angle of the arc so you can
			    // rotate around the outer arc in the opposite direction.
			    endAngle = startAngle + arcAngle;
			    //
			    // Start drawing all points on the outer arc.
			    for(i=0; i<=steps; i++){
			        //
			        // To go the opposite direction, we subtract rather than add.
			        angle = (endAngle - i * angleStep) * twoPI;
			        xx = centerX + Math.cos(angle) * outerRadius;
			        yy = centerY + Math.sin(angle) * outerRadius;
			        gp.lineTo(xx, yy);
			    }
			    //
			    // Close the shape by drawing a straight
			    // line back to the inner arc.
//			    gp.lineTo(startPoint.x, startPoint.y);
			    
			    return endAngle;
			}
//
// Draw 4 colored arcs around a circle without any overlap.
//beginFill(0xFF0000, 50);
//DrawSolidArc (250, 250, 80, 200, 45/360, -90/360, 20);
//beginFill(0x00FF00, 50);
//DrawSolidArc (250, 250, 80, 200, 135/360, -90/360, 20);
//beginFill(0x0000FF, 50);
//DrawSolidArc (250, 250, 80, 200, 225/360, -90/360, 20);
//beginFill(0xFFFF00, 50);
//DrawSolidArc (250, 250, 80, 200, 315/360, -90/360, 20);
//
//
		
		
	}// class
	
} // package