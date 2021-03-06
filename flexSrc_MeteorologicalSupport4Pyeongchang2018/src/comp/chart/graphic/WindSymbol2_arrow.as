package comp.chart.graphic
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class WindSymbol2_arrow extends Sprite{
		
        private var barHeight:Number=13;   
        private var tailHeight:Number=9;
        private var tailGap:Number=3;   
        private var circleRadius:Number = 1.2;  // cloud amount 
        private var color:uint = 0x000080;  //symbol color
//      private var color:uint = 0xFF0000;  //symbol color
        
        public function WindSymbol2_arrow( speed:Number,  direction:Number ){
            super();
			draw( speed, direction);
        }
        
		private function draw(speed:Number, direction:Number):void{
			
            var triangleCnt:int = int(speed/25);	 
            speed = speed % 25;
            
            var pointCnt:int = int(speed/5);	 
            speed = speed % 5;
            
            var halfPointCnt:int = int(speed/2.5); 
            //trace("triangleCnt:"+triangleCnt+" pointCnt:"+pointCnt+" halfPointCnt:"+halfPointCnt);
			
			
			var radianAngle:Number = direction * Math.PI / 180;
     		var radiansX:Number = Number( Math.cos( 300 * Math.PI / 180 ).toFixed(3));
     		var radiansY:Number = Number( Math.sin( 300 * Math.PI / 180 ).toFixed(3));
     		
     		var pointEndX:Number;
     		var pointEndY:Number;
			
			var gp:Graphics = this.graphics;
			gp.clear();
            gp.lineStyle( 1, color, 1.0 );
            gp.moveTo( -barHeight, 0 );
            gp.lineTo( barHeight, 0 );
            //cloudAmountCircle
//          gp.beginFill(color,1);
//			gp.drawCircle(-barHeight + 1, 0, circleRadius);
				
			var XTo:Number = barHeight;
			var YTo:Number = 0;
			var angle:Number = 0;
			
			var ahl:Number = 8;
			gp.beginFill(color); //had defined color earlier
			gp.moveTo(XTo, YTo);
			
			// Point A is the end of line at (XTo, YTo).
			// Points B and C are the two other points.
			var Bx:Number = XTo - ahl * Math.sin(Math.PI/3 - angle);
			var By:Number = YTo + ahl * Math.cos(Math.PI/3 - angle);
			
			gp.lineTo(Bx, By);
			
			var Cx:Number=Bx-ahl*Math.cos(Math.PI/2 - angle);
			var Cy:Number=By-ahl*Math.sin(Math.PI/2 - angle);
			
			gp.lineTo(Cx, Cy);
			gp.lineTo(XTo, YTo);
			
			
			
            this.rotation = direction +180;
		}      

	}
}