package comp.chart.graphic
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class WindSymbol extends Sprite{
		
        private var barHeight:Number=13;   
        private var tailHeight:Number=9;
        private var tailGap:Number=3;   
        private var circleRadius:Number = 1.2;   
        private var color:uint = 0x000080;   
        
        public function WindSymbol( speed:Number,  direction:Number ){
            super();
			draw( speed, direction);
        }
        
		private function draw(speed:Number, direction:Number):void{
			
            var triangleCnt:int = int(speed/25);	
            speed = speed % 25;
            
            var pointCnt:int = int(speed/5);	
            speed = speed % 5;
            
            var halfPointCnt:int = int(speed/2.5);	
			
			
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
            
            gp.beginFill(color,1);
			gp.drawCircle(-barHeight + 1, 0, circleRadius);
			
			//testonly
//			gp.drawCircle(-barHeight + 12, 0, 11);
			//testonly
			gp.endFill();
			
            
            
            //깃대 긋기
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