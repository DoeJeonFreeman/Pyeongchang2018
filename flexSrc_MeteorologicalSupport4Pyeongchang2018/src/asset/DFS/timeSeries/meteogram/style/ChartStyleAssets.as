package asset.DFS.timeSeries.meteogram.style{
	
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;
	

	public class ChartStyleAssets{
		public function ChartStyleAssets(){
			trace('chartStyleAssets constructor()');
		}
		
		
		//me2016 RDPS PMOS 색상변경
		public static var ST_SHRT_PMOS:Stroke = new Stroke(0x41C01C, 1, 1);  // Red
		public static var ST_SHRT_RDPS:Stroke = new Stroke(0xE29529, 1, 1);  //Green
		public static var ST_SHRT_KWRF:Stroke = new Stroke(0xDA2323, 1, 1);  //Yellow 
		public static var ST_SHRT_ECMW:Stroke = new Stroke(0x2D6FE8, 1, 1);  //Blue
		
		public static var ST_MEDM_EPSG:Stroke = new Stroke(0xF53048, 1, 1);  // Red  //yellow -> 0xee930b
		public static var ST_MEDM_GDPS:Stroke = new Stroke(0x1D9657, 1, 1);  //green !!!!!!!!!!!!!!!!!!!!!!!!
		public static var ST_MEDM_ECMW:Stroke = new Stroke(0x2D6FE8, 1, 1);  //Bue
		//Fill Colour
		public static var SC_MEDM_EPSG:SolidColor = new SolidColor(0xF2C450,0);  //RED
		public static var SC_MEDM_GDPS:SolidColor = new SolidColor(0x1D9657);  //green !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!0x089c87 0x30600f 0x005c59   0x1D9657 (reh)
		public static var SC_MEDM_ECMW:SolidColor = new SolidColor(0x329AE1);  //Bue  0x2D6FE8탁해 기존 중기   0x329AE1단기 솔리드컬러가 더 이쁘네
		
		//		public static var SC_SHRT_PMOS:SolidColor = new SolidColor(0xF89929,0);  //RED
		//		public static var SC_SHRT_RDPS:SolidColor = new SolidColor(0x88C325,0);  //green   0x88C325      0x9CC325
		//me2016 RDPS PMOS 색상변경
		public static var SC_SHRT_PMOS:SolidColor = new SolidColor(0x88C325,0);  //RED
		public static var SC_SHRT_RDPS:SolidColor = new SolidColor(0xF89929,0);  //green   0x88C325      0x9CC325
		public static var SC_SHRT_KWRF:SolidColor = new SolidColor(0xF53048,0);  //Yellow 
		public static var SC_SHRT_ECMW:SolidColor = new SolidColor(0x329AE1,0);  //blue 
		//Fill Colour selected 
		//me2016 RDPS PMOS 색상변경
		//		public static var SEL_SHRT_PMOS:SolidColor = new SolidColor(0xeb6b00);  //RED
		//		public static var SEL_SHRT_RDPS:SolidColor = new SolidColor(0x009933);  //green  0x38C41B      0x37bd21   #72A805 7db212
		public static var SEL_SHRT_PMOS:SolidColor = new SolidColor(0x009933);  //RED
		public static var SEL_SHRT_RDPS:SolidColor = new SolidColor(0xeb6b00);  //green  0x38C41B      0x37bd21   #72A805 7db212
		public static var SEL_SHRT_KWRF:SolidColor = new SolidColor(0xE11215);  //Yellow  0xE11215
		public static var SEL_SHRT_ECMW:SolidColor = new SolidColor(0x2082c3);  //blue 
		
		
		
		
		public static var ST_SHRT_CURR:Stroke = new Stroke(0x000000,2,1);  //Red
		//		
		
		
		
		// define custom colors for use as fills in columnSeries -_-
		public static var bar1:SolidColor = new SolidColor( 0x45A8D );
		public static var bar2:SolidColor = new SolidColor( 0x2B8CBE );
		public static var bar3:SolidColor = new SolidColor( 0x74A9CF );
		
		// define custom colors for use as strokes in lineSeries
		public static var line1:Stroke = new Stroke( 0x570B0, 3 );
		public static var line2:Stroke = new Stroke( 0x74A9CF, 3 );
		public static var line3:Stroke = new Stroke( 0xBDC9E1, 3 );
		
		// axis renderers~ 
		public static var originStroke:Stroke = new Stroke( 0xC9C9C9, 2 );
		public static var grids:Stroke = new Stroke( 0xE5E5E5, 1 );
		
		
		// meteogram axis stroke
		public static var axisStroke:Stroke = new Stroke(0x333333,1, 1.0); //light black
		public static var axisStroke_red:Stroke = new Stroke(0xFF0000,1, 1.0); //light black
		
		public static var invisibleAxis:Stroke = new Stroke(0x333333,1, 0.0); //invisible
		
		// backgroundElements 							    color weight alpha
		public static var glStroke_h:Stroke = new Stroke(0xAAAAAA, 1, .6); //gray
		public static var glStroke_h_PTY:Stroke = new Stroke(0xAAAAAA, 1, .8); //gray
		public static var glStroke_h2:Stroke = new Stroke(0xAAAAAA, 1, 0.5); //gray
		public static var glStroke_h_a2:Stroke = new Stroke(0xAAAAAA, 0.5, 0.25); //gray
		public static var glStroke_h_a7:Stroke = new Stroke(0xAAAAAA, 0.5, 0.5); //gray
		
		//		public static var glStroke_v:Stroke = new Stroke(0xd4d4d4,1, 1); //gray
		public static var glStroke_v:Stroke = new Stroke(0xcdcdcd,1, 1); //gray
		public static var glStroke_v2:Stroke = new Stroke(0xAAAAAA,1, 0.7); //gray
		
		//POP column series
		public static var stroke_POP:Stroke = new Stroke(0x000000,1, 1.0);
		//POP column series     0x2BF5F5 haloBlue
		//haloOrange 0xFFC200
		public static var fill_POP:SolidColor = new SolidColor(0x2BF5F5, 0.9);
		
		
		public static var areaStroke_blue:Stroke = new Stroke(0x33BBDD,1,0.4);
		public static var areaFill_blue:SolidColor = new SolidColor(0x33BBDD,.2);
		
		public static var areaStroke_yellow:Stroke = new Stroke(0xF2C450, 1, 0.4);
		public static var areaFill_yellow:SolidColor = new SolidColor(0xF2C450,.3);
		
		//ensemble horizontalGridLine		
		//ensemble horizontalGridLine		
		//ensemble horizontalGridLine		
		public static var ensemble_hGrid:Stroke = new Stroke(0xcdcdcd,.1, 1); //gray
		
	}
	
	
	
}