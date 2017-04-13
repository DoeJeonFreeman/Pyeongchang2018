package comp.chart.graphic
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class WindSymbol extends Sprite{
		
        private var barHeight:Number=13;   
        private var tailHeight:Number=9;
        private var tailGap:Number=3;   
        private var circleRadius:Number = 1.2;  // cloud amount 
        private var color:uint = 0x000080;  //symbol color
        
        public function WindSymbol( speed:Number,  direction:Number ){
            super();
			draw( speed, direction);
        }
        
        //  m/sec 으로      note/sec ?
		private function draw(speed:Number, direction:Number):void{
			
            var triangleCnt:int = int(speed/25);	// triangle/50
            speed = speed % 25;
            
            var pointCnt:int = int(speed/5);	//깃은 10단위마다
            speed = speed % 5;
            
            var halfPointCnt:int = int(speed/2.5);	//반깃은 5단위마다
            //trace("triangleCnt:"+triangleCnt+" pointCnt:"+pointCnt+" halfPointCnt:"+halfPointCnt);
			
			
			var radianAngle:Number = direction * Math.PI / 180;
			//tail angle = 300도 
     		var radiansX:Number = Number( Math.cos( 300 * Math.PI / 180 ).toFixed(3));
     		var radiansY:Number = Number( Math.sin( 300 * Math.PI / 180 ).toFixed(3));
     		
     		var pointEndX:Number;
     		var pointEndY:Number;
			
			var gp:Graphics = this.graphics;
			gp.clear();
			
			//회전축  걍 
//			gp.beginFill(0xCC0022,1);
//			gp.drawCircle(0,0,2);
//			gp.endFill();
			
			//가로 직선 긋기  
			// (0,0)이 회전축. 윈드바 중간 지점이 회전축이 되도록 .. -barSize 
            gp.lineStyle( 1, color, 1.0 );
            gp.moveTo( -barHeight, 0 );
            gp.lineTo( barHeight, 0 );
            
            //cloudAmountCircle
            gp.beginFill(color,1);
			gp.drawCircle(-barHeight + 1, 0, circleRadius);
			
			//testonly
			//testonly
//			gp.drawCircle(-barHeight + 12, 0, 11);
			//testonly
			//testonly
			gp.endFill();
			
            
            
            //깃대 긋기
            for (var i:int=0; i < triangleCnt + pointCnt + halfPointCnt; i++){
            	
            	var gap:Number = tailGap * i;
            	
            	if(triangleCnt==0 && pointCnt==0 && halfPointCnt==1){
            		gap = tailGap;	// mps < 2.5 then halfTail 약간 위쪽에 그려 ㅎㅎ
            	}
            	
            	gp.moveTo( barHeight - gap, 0 );//깃대 시작점
            	
            	if(i < triangleCnt + pointCnt){
	            	pointEndX = radiansX * tailHeight ;
	     			pointEndY = radiansY * tailHeight ;
            	}else{
            		pointEndX = radiansX * tailHeight/2 ;
	     			pointEndY = radiansY * tailHeight/2 ;
            	}
     			
     			if(i < triangleCnt){
     				gp.beginFill(color, 1.0 );	// 삼각 깃대일 때
     			}
     			
     			gp.lineTo( pointEndX + barHeight - gap, -pointEndY); // 일반 깃대 라인
     			
     			if(i < triangleCnt){
	     			gp.lineTo( pointEndX + barHeight - gap, 0); //삼각 깃대일 때
     			}
            }
            
            //회전
            this.rotation = direction;
		}      

	}
}