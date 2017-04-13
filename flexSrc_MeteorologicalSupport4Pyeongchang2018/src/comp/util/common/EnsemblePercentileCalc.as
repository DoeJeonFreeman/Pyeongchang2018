package comp.util.common{
	import mx.collections.ArrayCollection;
	
	public class EnsemblePercentileCalc{
		
		private var arr_ensemble:Array;
		
		//cons
		public function EnsemblePercentileCalc(){
			arr_ensemble = new Array();
		}

		public function setEnsembleMemberData(arr:Array):Array{
			arr_ensemble = arr;
			return printData2();
		}
		
		public function setCloudAmount(arr:Array):Array{
			arr_ensemble = arr;
			return printData2(false);
		}
		
		
		private var arr2d:ArrayCollection = new ArrayCollection();
		public function printData2(isPecentile:Boolean=true):Array{
			var firstOne:Array = arr_ensemble[0];
			for (var i:int=0; i<firstOne.length; i++){  //  데이터길이만큼 횡으로
				var arr_ver:Array = new Array();					
				var values:Array = new Array();
				var kst:String;
				for each(var eachOne:Array in arr_ensemble){
					var obj:Object = eachOne[i];
					if(obj.val == undefined){
						trace("obj.val is UNDEFINED!!!!")
						continue;
					}
					values.push(Number(obj.val))
					kst = obj.lst;
				}
				var vObj:Object = new Object();
				vObj.lst = kst; 
				vObj.dataList = values; 
				arr2d.addItem(vObj);
				//
			}
				if(isPecentile){
					return printArrcoll(arr2d);
				}else{
//					return printArrcoll_cloudAmount(arr2d);;
					return printArrcoll_PTY(arr2d);;
				}
		}
		
		public function printArrcoll(ac:ArrayCollection):Array{
			var arr4return:Array = new Array();
			trace("[Bindable]private var pseudoData:Array=[")
			for each(var vObj:Object in ac){
				var obj4return:Object = new Object();
				var str2print:String='';
				str2print += "["+vObj.lst+"] ";
				var dataList:Array = vObj.dataList;
				dataList.sort(Array.NUMERIC);
				for each(var currVal:Number  in dataList){
					str2print += currVal +", ";
				}
				
				obj4return.lst = vObj.lst;
				obj4return.allMembers = dataList;
				obj4return.mn = Math.min.apply(null, dataList)
				obj4return.mx = Math.max.apply(null, dataList)
				obj4return.pr10th = getPercentileRange(10,dataList);
				obj4return.pr90th = getPercentileRange(90,dataList);
				obj4return.pr25th = getPercentileRange(25,dataList);
				obj4return.pr75th = getPercentileRange(75,dataList);
				obj4return.median = getPercentileRange(50,dataList);
				
				arr4return.push(obj4return);
				
				trace("{lst:\""+obj4return.lst+"\", mn:"+obj4return.mn +", mx:"+obj4return.mx +", pr10th:"+obj4return.pr10th+", pr25th:"+obj4return.pr25th
						+", median:"+obj4return.median +", pr75th:"+obj4return.pr75th +", pr90th:"+obj4return.pr90th + "},");
			}				
			trace("];")
			return arr4return;
		}
		
		
		public function printArrcoll_cloudAmount(ac:ArrayCollection):Array{
			var arr4return:Array = new Array();
			trace("[Bindable]private var pseudoData_cloudAmount:Array=[")
			for each(var vObj:Object in ac){
				var obj4return:Object = new Object();
				var str2print:String='';
				str2print += "["+vObj.lst+"] ";
				var dataList:Array = vObj.dataList;
				dataList.sort(Array.NUMERIC);
				for each(var currVal:Number  in dataList){
					str2print += currVal +", ";
				}
				obj4return.lst = vObj.lst;
				obj4return.clear = getCloudAmountPercentage("clear",dataList);
				obj4return.scattered = getCloudAmountPercentage("scattered",dataList);
				obj4return.broken = getCloudAmountPercentage("broken",dataList);
				obj4return.overcast = getCloudAmountPercentage("overcast",dataList);
				
				arr4return.push(obj4return);
//				trace(str2print)
				trace("{lst:\""+obj4return.lst+"\", clear:"+obj4return.clear +", scattered:"+obj4return.scattered +", broken:"+obj4return.broken+", overcast:"+obj4return.overcast+ "},");
			}				
			trace("];")
			return arr4return;
		}
		
		public function getCloudAmountPercentage(whichOne:String,dataList:Array):Number{
			var valFrom:Number;
			var valTo:Number;
			var counter:Number=0;
			var percentage:Number;
			if(whichOne=="clear"){
				valFrom = 0; valTo = 2.5;
			}else if(whichOne=="scattered"){
				valFrom = 2.5; valTo = 5;
			}else if(whichOne=="broken"){
				valFrom = 5; valTo = 7.5;
			}else if(whichOne=="overcast"){
				valFrom = 7.5; valTo = 10.1;
			}	
			for each(var val:Number in dataList){
				if(valFrom<=val && val<valTo){
//				if(valFrom==val){
					counter++;
//					trace(whichOne+' '+val)
				}
			}
			
//			return (counter/dataList.length)*100;
			return (counter/24)*100;
		}
		public function printArrcoll_PTY(ac:ArrayCollection):Array{
			var arr4return:Array = new Array();
			trace("[Bindable]private var pseudoData_cloudAmount:Array=[")
			for each(var vObj:Object in ac){
				var obj4return:Object = new Object();
				var str2print:String='';
				str2print += "["+vObj.lst+"] ";
				var dataList:Array = vObj.dataList;
				dataList.sort(Array.NUMERIC);
				for each(var currVal:Number  in dataList){
					str2print += currVal +", ";
				}
				obj4return.lst = vObj.lst;
				obj4return.clear = getPTYPercentage("rain",dataList);
				obj4return.scattered = getPTYPercentage("sleet",dataList);
				obj4return.broken = getPTYPercentage("snow",dataList);
				
				arr4return.push(obj4return);
//				trace(str2print)
				trace("{lst:\""+obj4return.lst+"\", rain:"+obj4return.clear +", sleet:"+obj4return.scattered +", snow:"+obj4return.broken+ "},");
			}				
			trace("];")
			return arr4return;
		}
		
		public function getPTYPercentage(whichOne:String,dataList:Array):Number{
			var valFrom:Number;
			var valTo:Number;
			var counter:Number=0;
			var percentage:Number;
			if(whichOne=="rain"){
				valFrom = 1; 
			}else if(whichOne=="sleet"){
				valFrom = 2; 
			}else if(whichOne=="snow"){
				valFrom = 3; 
			}	
			for each(var val:Number in dataList){
//				if(valFrom<=val && val<valTo){
				if(valFrom==val){
					counter++;
//					trace(whichOne+' '+val)
				}
			}
			
//			return (counter/dataList.length)*100;
			return (counter/24)*100;
		}
		
		public function getPercentileRange(range:Number ,dataList:Array):Number{
			var nn_th:Number = range;
			var idx:Number = (nn_th/100) * dataList.length;
			var rangeVal:Number;
//				trace("50th... " + dataList[Math.ceil(idx)] + ' idx is ' + idx)
			if(idx%1!=0){
				idx = Math.ceil(idx) -1;
//				trace("["+nn_th+"th idx is decimal] " + dataList[idx]);
				 rangeVal = dataList[idx];
			}else{
				idx = idx -1;
				var percentile_avg:Number = (dataList[idx] + dataList[idx+1])/2;
//				trace("["+nn_th+"th idx is whole number] " + percentile_avg);
				rangeVal = percentile_avg;
			}
			return rangeVal;
		}
		
	}
}