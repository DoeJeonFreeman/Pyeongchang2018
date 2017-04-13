package asset.DFS.timeSeries.meteogram.itmRenerer{
	
//	import DotLine.DotLine;
	public class DashedLineRenderer extends DashedLine_doe{
		
		
//		public function DashedLineRenderer(_gap:Number, _len:Number, _weight:Number, _alpha:Number){
		public function DashedLineRenderer(){
			gap=3; // 점선 사이 간격
			length=4; // 점선 길이
			lineWeight=1; // 선 굵기
			lineAlpha=.9; // 선 알파
		}
	}
}
