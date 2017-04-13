package comp.chart.graphic
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class WindSymbol_small extends Sprite{
		
        private var barHeight:Number=12;   
        private var tailHeight:Number=8;
        private var tailGap:Number=3;   
        private var circleRadius:Number = 1.2;  // cloud amount 
        private var color:uint = 0x000080;  //symbol color
        
        public function WindSymbol_small( speed:Number,  direction:Number ){
            super();
			draw( speed, direction);
        }
        
        //  m/sec 으로      note/sec ?
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
            gp.beginFill(color,1);
			gp.drawCircle(-barHeight + 1, 0, circleRadius);
			
			gp.endFill();
			
            
            
            for (var i:int=0; i < triangleCnt + pointCnt + halfPointCnt; i++){
            	
            	var gap:Number = tailGap * i;
            	
            	if(triangleCnt==0 && pointCnt==0 && halfPointCnt==1){
            		gap = tailGap;	
            	}
            	
            	gp.moveTo( barHeight - gap, 0 );
            	
            	if(i < triangleCnt + pointCnt){
	            	pointEndX = radiansX * tailHeight ;
	     			pointEndY = radiansY * tailHeight ;
            	}else{
            		pointEndX = radiansX * tailHeight/2 ;
	     			pointEndY = radiansY * tailHeight/2 ;
            	}
     			
     			if(i < triangleCnt){
     				gp.beginFill(color, 1.0 );	
     			}
     			
     			gp.lineTo( pointEndX + barHeight - gap, -pointEndY); 
     			
     			if(i < triangleCnt){
	     			gp.lineTo( pointEndX + barHeight - gap, 0); 
     			}
            }
            
            this.rotation = direction;
		}      

	}
}