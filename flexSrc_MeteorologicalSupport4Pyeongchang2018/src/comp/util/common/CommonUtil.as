package comp.util.common{
	import asset.DFS.timeSeries.meteogram.style.ChartStyleAssets;
	
	import components.util.DJFQueueLoader;
	import components.util.DJFUpdateTimeGetter;
	import components.util.DateMgr;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.effects.Resize;
	import mx.graphics.Stroke;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceBundle;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	
	import org.as3commons.lang.StringUtils;
	
	
	/**
	 * 
	 * 2016.05.31 
	 * 
	 * 
	 * */
	public class CommonUtil{
		
		private static var _instance:CommonUtil;
		
		private var peak_temperature:Number;
		private var nadir_temperature:Number;
		private var peak_prcp:Number;
		
		public function initPeakAndNadir():void{
			this.peak_temperature = NaN;
			this.nadir_temperature = NaN;
			this.peak_prcp = NaN;
		}
		
		public function getPeak_temperature():Number{ return peak_temperature;}
		public function getNadir_temperature():Number{ return nadir_temperature;}
		public function getPeak_Prcp():Number{ return peak_prcp;}
		
		public function CommonUtil(e:CommonUtilEnforcer){
			if(e != null){
				//do something
			}else{
				throw new Error("It can\'t be done!! Call getInstance() function instead. haha.")
			}
		}
		
		
		public static function getInstance():CommonUtil{
			if(_instance == null)
				_instance = new CommonUtil(new CommonUtilEnforcer);
			return _instance;
		}
		
		
		public function computeVerticalAxisMinMax(axisVal:Number, interval:Number, isMaximum:Boolean=true):Number{
			if(axisVal % interval == 0) return axisVal;
			
			var computed:Number;			
			if(isMaximum){
				var diff:Number = Math.ceil(axisVal/10)*10 - axisVal;
				if(diff > interval){
					diff-=interval;
					computed = axisVal + diff;
				}else if(diff < interval){
					computed = Math.ceil(axisVal/10)*10;
				}
			}else{
				var diff:Number = axisVal - Math.floor(axisVal/10)*10;
				if(diff> interval){
					diff = diff-interval;
					computed = axisVal - diff;
				}else if(diff < interval){
					computed = Math.floor(axisVal/10)*10;
				}
				
			}
			return computed;
		}
		
		/**
		 * SHRT, MEDiuM-range 자료는 00UTC, 12UTC 두 번 생산됨.
		 * VSRT는 00, 06, 12, 18UTC 네 번 생산됨. 
		 * VSRT 06 혹은 18UTC 표출 시 단기와 중기는 각각 00이랑 12utc 표출(-6 hrs)  
		 * 
		private function getProperTimeString(dStr:String):String{
			var JJNN:String = dStr.substring(dStr.length-4, dStr.length);
			if(JJNN=='0600' || JJNN=='1800'){
				var d:Date = DateMgr.addHours(DateMgr.str2Date(dStr),-6);
				return DateMgr.getYYYYMMDDStr(d,'JJNN');
			}else{
				return dStr;
			}
		}
		 * */
		// 2017.01.17. 
		// VSRT 자료생산 주기가 기존 00, 06, 12, 18 UTC에서 한시간 간격 24번으로 변경됨!!!
		// VSRT 데이터 크리에이션 타임에 SHRT(MEDM) 자료가 존재하지 않을 경우  
		// VSRT는 콤보박스 시간으로, 나머지는 걍 과거자료 무조건 표출. 단 issued date 명시해야
		
		//  00 UTC
		//  01 ~ 11   VSRT   == > 00 SHRT, MEDM
		//  12 UTC
		//  13 ~ 23   VSRT   == > 12 SHRT, MEDM
		
		private function getProperTimeString(dStr:String):String{
			var JJNN:String = dStr.substring(dStr.length-4, dStr.length);
			if(JJNN != '0000' && JJNN != '1200'){
				var d:Date = new Date();
				var JJinNum:Number = Number(JJNN.substr(0,2));
				if(0<JJinNum && JJinNum<12){
					d = DateMgr.str2Date(dStr.substr(0,8) + "0000");
				}else if(12<JJinNum && JJinNum<24){
					d = DateMgr.str2Date(dStr.substr(0,8) + "1200");
				}
				
//				Alert.show(DateMgr.getYYYYMMDDStr(d,'JJNN'),dStr + ' / JJNN:' + JJNN)
				return DateMgr.getYYYYMMDDStr(d,'JJNN');
			}else{
//				Alert.show('ELSE',dStr)
				return dStr;
			}
		}
		
		/**
		 * 네 가지 케이스는 분기문 태워라. 반기문은 꺼져라
		 * 		
		 * 		종합-초단기일경우 드랍다운 4개고, 나머지는 2개. 
		 * 		단기에서는 드랍다운 일 4개고(초단기 떄문에) 06, 18 선택시 단기랑 중기는 각각 00시랑 12시(-6hrs) 표출..
		 * 
		 * T1H, T3H, MMX
		 * RN1, RN3, R12
		 * SN1, SN3, S12
		 * 
		 * POP는 SHRT에만 있음 ==> 걍 있으면 표출되도록 // 아니면 일단 이번 웹메뉴에서 제외시키던지 ㅎㅎ
		 * 
		 * */
		public function loadXML_VSRT_trhu_MEDM(varAbbreviation:String, dStr:String){
			var runnersHigh:Array = new Array();
		
			if(varAbbreviation=="T1H" || varAbbreviation=="T3H" || varAbbreviation=="MMX"){
				runnersHigh.push("VSRT.PYEONGCHANG.T1H " + dStr); 
				runnersHigh.push("SHRT.PYEONGCHANG.T3H " + getProperTimeString(dStr)); 
				runnersHigh.push("MEDM.PYEONGCHANG.MMX " + getProperTimeString(dStr)); 
			}else if(varAbbreviation=="RN1" || varAbbreviation=="RN3" || varAbbreviation=="R12"){
				runnersHigh.push("VSRT.PYEONGCHANG.RN1 " + dStr); 
				runnersHigh.push("SHRT.PYEONGCHANG.RN3 " + getProperTimeString(dStr)); 
				runnersHigh.push("MEDM.PYEONGCHANG.R12 " + getProperTimeString(dStr)); 
			}else if(varAbbreviation=="SN1" || varAbbreviation=="SN3" || varAbbreviation=="S12"){
				runnersHigh.push("VSRT.PYEONGCHANG.SN1 " + dStr); 
				runnersHigh.push("SHRT.PYEONGCHANG.SN3 " + getProperTimeString(dStr)); 
				runnersHigh.push("MEDM.PYEONGCHANG.S12 " + getProperTimeString(dStr)); 
			}else{
				runnersHigh.push("VSRT.PYEONGCHANG."+varAbbreviation+" "+dStr); 
				runnersHigh.push("SHRT.PYEONGCHANG."+varAbbreviation+" "+getProperTimeString(dStr)); 
				runnersHigh.push("MEDM.PYEONGCHANG."+varAbbreviation+" "+getProperTimeString(dStr)); 
			}
			
//			showAlertDialogOnScreenTop('VSRT JJNN is: ' + dStr + '\nOthers JJNN is: ' + getProperTimeString(dStr))
			
			DJFQueueLoader.getInstance().getMergedModelData(runnersHigh);
		}
	
		
		
		public var seriesColorArr:Array = new Array(
			new Stroke(0x1A3E3C,1,1),   //7 almost black
			new Stroke(0x5D738C,1,1),   //6 gray?
			new Stroke(0x41C01C,1,1),   //1 moss green 0x00945f
			new Stroke(0xE29529,1,1),   //2 mandarin
			new Stroke(0xDA2323,1,1),   //3 red
			new Stroke(0x2D6FE8,1,1),   //4 blue
			new Stroke(0x00acc8,1,1),   //8 turqoise
			
			new Stroke(0x772d8a,1,1),   //9 purple
			new Stroke(0x0E4473,1,1),   //5 navy?
			new Stroke(0xE3AAD6,1,1)    // pink? ㅠ
		);
		
		
		public function stripHyphensMan(str:String, substitute:String=" "):String{
			var pattern:RegExp = /-/g;
			return str.replace(pattern,substitute);
		}
		
		public  function spriteToBitmap(sprite:Sprite, smoothing:Boolean = false):Bitmap{
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
			bitmapData.draw(sprite);
			
			return new Bitmap(bitmapData, "auto", smoothing);
		} 
		
		
		public function getStrokeColourByModelName(baseModelName:String,isColoumnSeries:Boolean=false,isColoumnSelected:Boolean=false,isMEDM:Boolean=false):int{
			var colour:int;
			if(! isColoumnSeries){
				switch(baseModelName){
					case "series_pmos": colour = ChartStyleAssets.ST_SHRT_PMOS.color; break;
					case "series_rdps": colour = ChartStyleAssets.ST_SHRT_RDPS.color; break;
					case "series_best": colour = ChartStyleAssets.ST_SHRT_KWRF.color; break;//doejeon Oct2015
					case "series_kwrf": colour = ChartStyleAssets.ST_SHRT_KWRF.color; break;
					case "series_ecmw": colour = ChartStyleAssets.ST_SHRT_ECMW.color; break;
				}
			}else{
				if(baseModelName=="series_pmos"){
					colour = (isColoumnSelected)? ChartStyleAssets.SEL_SHRT_PMOS.color : ChartStyleAssets.SC_SHRT_PMOS.color; 
				}else if(baseModelName=="series_rdps"){
					colour = (isColoumnSelected)? ChartStyleAssets.SEL_SHRT_RDPS.color : ChartStyleAssets.SC_SHRT_RDPS.color; 
				}else if(baseModelName=="series_best"){ //doejeon Oct2015
					colour = (isColoumnSelected)? ChartStyleAssets.SEL_SHRT_KWRF.color : ChartStyleAssets.SC_SHRT_KWRF.color; 
				}else if(baseModelName=="series_ecmw"){
					if(!isMEDM){
						colour = (isColoumnSelected)? ChartStyleAssets.SEL_SHRT_ECMW.color : ChartStyleAssets.SC_SHRT_ECMW.color; 
					}else{
						colour = ChartStyleAssets.SC_MEDM_ECMW.color; 
					}
				}else if(baseModelName=="series_gdps"){
					colour = ChartStyleAssets.SC_MEDM_GDPS.color; 
				}else if(baseModelName=="series_epsg"){
					colour = ChartStyleAssets.SC_SHRT_RDPS.color; //djf2016 중기BEST가 빨간색. 기존 EPSG는 단기 RDAPS와 동일한 오렌지컬러로 변경
				}
			}
			return colour;
		}
		
		
		
		[Bindable]private var properties:Object;
		
		public function loadBaseModelResources(url:String):void{
		var urlLoader:URLLoader= new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,meCompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,  meXmlLoadFailed);
			urlLoader.load(new URLRequest(url));
		}
		
		public function getLastUpdateTime(url:String,isVSRT:Boolean=false):void{
		var urlLoader:URLLoader= new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,(isVSRT)?setLatestStuff_VSRT : setLatestStuff_SHRT_MEDM);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,  lastUpdateTimeLoadFailed);
			urlLoader.load(new URLRequest(url));
		}
		
		private function lastUpdateTimeLoadFailed(e:Event):void{
			showAlertDialogOnScreenTop("Failed to load lastUpdate.up2date","IOErrorEvent.IO_ERROR");
		}	
		
		private function meXmlLoadFailed(e:Event):void{
			showAlertDialogOnScreenTop("Failed to load basedOn.properties","IOErrorEvent.IO_ERROR");
		}	
		
		[Bindable]public var ac_date_VSRT:ArrayCollection;
		[Bindable]public var ac_date_SHRT_MEDM:ArrayCollection;
//		private var d:uint = 2;  //표출일수
//		private var t:uint = 24;  //1시간간격 일24회
		private var d:uint = 7;  //표출일수
		private var t:uint = 24;  //6시간간격 일4회
		public function setLatestStuff_VSRT(event:Event=null, mostRecentStuff="yyyymmddhhmm"):void {
			var dArr:ArrayCollection = new ArrayCollection();	
			var dStr:String = (event)? StringUtils.trim(event.target.data) : StringUtils.trim(mostRecentStuff);
			var dFrom:Date = DateMgr.str2Date(dStr);
			var dFrom_LST:Date = ObjectUtil.copy(dFrom) as Date;
			dFrom_LST = DateMgr.addHours(dFrom,9); // LST
			for(var i:int = 0; i < d*t; i++){
				var lbl:String = DateMgr.getYYYYMMDDStr(dFrom_LST);
				lbl = lbl.substring(0,4)+'년 ' + lbl.substring(4,6) + '월 ' + lbl.substring(6,8) + '일 ' + lbl.substring(8,10) + ' LST'
					
				dArr.addItem({label: lbl,  data:DateMgr.getYYYYMMDDStr(dFrom,'JJNN')});
				dFrom = DateMgr.addHours(dFrom,-1) //1시간 간격
				dFrom_LST = DateMgr.addHours(dFrom_LST,-1) //1시간 간격
//				dFrom = DateMgr.addHours(dFrom,-6)
//				dFrom_LST = DateMgr.addHours(dFrom_LST,-6)
					
			}
			ac_date_VSRT = dArr;
			
		}
		
		private function setLatestStuff_SHRT_MEDM(event:Event):void {
			var dArr:ArrayCollection = new ArrayCollection();	
			var dStr:String = StringUtils.trim(event.target.data);
			var dFrom:Date = DateMgr.str2Date(dStr);
			var dFrom_LST:Date = ObjectUtil.copy(dFrom) as Date;
			dFrom_LST = DateMgr.addHours(dFrom,9); // LST
			for(var i:int = 0; i < 7*2; i++){
				var lbl:String = DateMgr.getYYYYMMDDStr(dFrom_LST);
				lbl = lbl.substring(0,4)+'년 ' + lbl.substring(4,6) + '월 ' + lbl.substring(6,8) + '일 ' + lbl.substring(8,10) + ' LST'
				dArr.addItem({label: lbl,  data:DateMgr.getYYYYMMDDStr(dFrom,'JJNN')});
				dFrom = DateMgr.addHours(dFrom,-12)
				dFrom_LST = DateMgr.addHours(dFrom_LST,-12)
					
			}
			ac_date_SHRT_MEDM = dArr;
		}
		
		private function meCompleteHandler(event:Event):void {
			//showAlertDialogOnScreenTop(event.target.data);
			properties = StringUtils.parseProperties(event.target.data);
		}
		
		public function getBasalModelStr(isMulti:Boolean, isMEDM:Boolean, baseModel:String, varName:String):String{
			var basedOn:String = '';
			var varType:String = (isMulti)? "MUL" : varName;
			if(properties != null){
				if(baseModel=="PMOS"){
					basedOn = properties["SHRT.RDPS_MOS." + varType]; 
				}else if(baseModel=="RDPS"){ //clear
					basedOn = properties["SHRT.RDPS." + varType]; 
				}else if(baseModel=="ECMWF"){
//					basedOn = properties[((isMEDM)? "MEDM":"SHRT") +".ECMWF_MOS." + varType]; 
					var s = ((isMEDM)? "MEDM":"SHRT") +".ECMWF_MOS." + varType; 
					basedOn = properties[s.toString()]; 
				}else if(baseModel=="EPSG"){ //clear
					basedOn = properties["MEDM.EPSG_MOS." + varType]; 
//				}else if(baseModel=="GDPS" || baseModel=="PMOS2"){ 
				}else if(baseModel=="GDPS"){ 
					basedOn = properties["MEDM.GDPS_MOS." + varType]; 
				}else if(baseModel=="SSPS"){ //clear
					basedOn = properties["SHRT.SSPS." + varType]; 
				}else if(baseModel=="BEST"){ //clear
					basedOn = "BEST";
				}
//				showAlertDialogOnScreenTop('isMulti='+isMulti+' / isMEDM='+isMEDM+' / baseModel='+baseModel+' / varName='+varName +'\n'+testStr ,'basedOn : ' +basedOn + ' / ' +varName);
			}else{
			}
			return  StringUtil.trim(basedOn);
		}
		
		public function getBasedOnStringMan(myKey:String):String{
			return properties[myKey];
		}
		
		
		[Bindable]private var chartDataInfo:Object;
		
		public function loadTimeseriesDataInfoResources(url:String):void{
			var urlLoader:URLLoader= new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,dataPropertyFileLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,  dataPropertyLoadFailed);
			urlLoader.load(new URLRequest(url));
		}
		
		private function dataPropertyLoadFailed(e:Event):void{
			showAlertDialogOnScreenTop("Failed to load timeseriesChartData.properties","IOErrorEvent.IO_ERROR");
		}	
		
		private function dataPropertyFileLoaded(event:Event):void {
//			showAlertDialogOnScreenTop(event.target.data);
			chartDataInfo = StringUtils.parseProperties(event.target.data);
		}
		
		/**
		 * typeFlag
		 * DIR: return base dir relative path
		 * PRFX: return filename prefix
		 * FULLABSPATH: DIR + PRFX 
		 * */
		//  SHRT.RDPS_MOS 	T3H 	201512190000 	5 	[isMulti]
		public function getTimeseriesDataPath(str:String, typeFlag:String='FULLPATH_EXT',isVSRT:Boolean=false):String{
			var path:String = '';
			if(chartDataInfo != null){
				var arr:Array = str.split(' ');
				//if(arr.length==0) //throw shit;
				if(typeFlag=='FULLPATH'){
//					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX']; 
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + getDirDatePath(arr[2]) + chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX']; 
				}else if(typeFlag=='DIR'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + getDirDatePath(arr[2]); 
				}else if(typeFlag=='PRFX'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX'] ; 
				}else if(typeFlag=='FULLPATH_EXT'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + getDirDatePath(arr[2]) + chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX']; 
					if(!isVSRT){
						path += '.'+getProperTimeString(arr[2])+'.xml'; //SHRT, MEDM 00, 12UTC 외에 시간 처리
					}else{
						path += '.'+arr[2]+'.xml';
					}
				}	
			}	
//			showAlertDialogOnScreenTop(StringUtil.trim(path) , typeFlag);
			return  StringUtil.trim(path);
		}
		
		//201512190000
		private function getDirDatePath(dStr:String):String{
			return dStr.substring(0,6) + '/' + dStr.substring(6,8) + '/';
		}
		
		//  SHRT.RDPS_MOS 	T3H 	201512190000 	5 	[isMulti]
		public function getTimeseriesDataPathByGivenProperty(str:String, dStr:String):String{
			var path:String = '';
			if(chartDataInfo != null){
				var arr:Array = str.split(' ');
//				path = chartDataInfo[str+'.DAOU'] + chartDataInfo[str+'.PRFX']; 
				path = chartDataInfo[str+'.DAOU'] + getDirDatePath(dStr) + chartDataInfo[str+'.PRFX']; 
				path += '.'+dStr+'.xml';
			}	
			trace('URL[' + StringUtil.trim(path) +']')
			return  StringUtil.trim(path);
		}
		
		
		// SHRT.RDPS_MOS POP 201512190000 5
		// PMOS2는 이제 바이 짜이찌엔 
		public function getTimeseriesDataBaseModel(str:String):String{
			var legacyName:String = '';
			var modelFalg:String = str.split(' ')[0];
			modelFalg = StringUtil.trim(modelFalg.split('.')[1]);
			if(modelFalg=='SSPS'){
				legacyName = 'SSPS';
			}else if(modelFalg=='PYEONGCHANG'){
				legacyName = 'PYEONGCHANG';
				legacyName = 'SSPS';
			}
			
			return  legacyName;
		}
		
		
//		//me2016 	백업용 
		public function getBaseModelIndex(baseModelName:String,isMEDM:Boolean,strChartType:String="whatEver"):int{
			var index:int;
			switch(baseModelName){
				case "BEST": index = (isMEDM)? 1 : 1; break;
				case "PMOS":  index = 2; break;
//				case "RDPS MOS":  index = 1+1; break; //BEST_MERG 2016  CheckBoxGroup_merged에서 RDPS MOS면 PMOS로 바꿔
				case "RDPS":  index = 3; break;
				case "EPSG":  index = 2; break;
				case "GDPS":  index = 3; break;
//				case "PMOS2": index = 2; break;
				case "ECMWF": index = (isMEDM)? 4 : 4; break;
			}
			if(isMEDM && strChartType=="S12" && baseModelName != "BEST"){
				index-=1;
			}
			return index;
		}
		
		
		public function isFileExist(dic:Dictionary,modelName:String):Boolean{
			if(modelName=="RDPS MOS") modelName="PMOS";//BEST_MERG 2016
			var isExist:Boolean;
			if(dic[modelName]){
				isExist = true;
			}else{
				isExist = false;
			}
			return isExist;
		}
		
	
		
		public  function xmlListToObjectArray(xmlList:XMLList, isTemperature:Boolean = false, isKindOfPrcp:Boolean=false):Array{
			var arr:Array = new Array();
			var arr_4assignMaxMin:Array = new Array();
			for each(var xml:XML in xmlList){
				var childs:XMLList = xml.attributes(); 
				var obj:Object = new Object();
				for each(var child:XML in childs){
					var nodeName:String = child.name().toString();
					var nodeValue:Number =  Number(child.(nodeName));//R12, S12 에어리어 시리즈 인터폴레이션 땜에 데이터를 뉴메릭으로 랩핑
					var nodeVal_str:String = child.(nodeName).toString();
					obj[nodeName] =(nodeName=='lst' || nodeName=='weight')? nodeVal_str:nodeValue;//me2016			            	
					
					if(isKindOfPrcp && nodeName=='pr90th'){
						if(!isNaN(nodeValue)) arr_4assignMaxMin.push(nodeValue);
					}else if(isTemperature){
						if(nodeName=='pr10th' || nodeName=='pr90th'){
							if(!isNaN(nodeValue)) arr_4assignMaxMin.push(nodeValue);
						}
					}
				}
				arr.push(new ObjectProxy(obj));
			}
			
			if(isTemperature){
				var maxVal:Number =  Math.max.apply(null, arr_4assignMaxMin)
				var minVal:Number =   Math.min.apply(null, arr_4assignMaxMin)
				//			    	Infinity
				if(maxVal != Infinity  && minVal != Infinity && !isNaN(maxVal)  && !isNaN(minVal) ){
					assignMaxMin(maxVal , minVal);
				}else{
					//						trace('! minMaxVal is not a number !\n\n');
				}
			}
			
			if(isKindOfPrcp){
				var maxPrcp:Number =  Math.max.apply(null, arr_4assignMaxMin);
				if(maxPrcp != Infinity && !isNaN(maxPrcp)){
					assignMaxPrcp(maxPrcp);
				}else{
					
				}
			}
			
			return arr;
		}					
		
		
		private function assignMaxMin(max:Number, min:Number):void{
			if(isNaN(peak_temperature) && isNaN(nadir_temperature)){
				trace("isNaN(peak_temperature) && isNaN(nadir_temperature)")
				peak_temperature = max;
				nadir_temperature = min;
			}else{
				if(max > peak_temperature){
					peak_temperature = max;
				} 
				if(min < nadir_temperature){
					nadir_temperature = min;
				}
			}
		}
		
		private function assignMaxPrcp(prcp:Number):void{
			if(isNaN(peak_prcp)){
				peak_prcp = prcp;
			}else{
				if(prcp > peak_prcp){
					peak_prcp = prcp;
					trace("[Prcp.] "+prcp)
				}
			}
		}
		
		
		
		private function iPad2(num:Number):String{
			return (num < 10)? '0'+num : num+'';
		}
		
		
		public function showAlertDialogOnScreenTop(message:String,title:String='noTitle'):void{
			var cornerGutter:Number = 20; 
			var topRightCorner:Alert =Alert.show(message,title);
			topRightCorner.width = 400;
			PopUpManager.centerPopUp(topRightCorner);
			topRightCorner.y = cornerGutter
			topRightCorner.y = 0;
		}
		
		
		private function getCloudCoverIndex(value:Object):uint{
			var val:Number = Number(value);
			if(0 <= val && val < 2.5)
				return 1;
			else if(2.5 <= val && val <5 )
				return 2;
			else if(5 <= val && val < 7.5)
				return 3;
			else if(7.5 <= val && val <= 10)
				return 4;
			else 	
				return 18;
		}
		
		
		private function getPrecipitationTypeIndex(dataSet:XML):String{
			var arr:ArrayCollection = new ArrayCollection([
				{type:"1.0", percentage: dataSet.@rain}, //rain
				{type:"2.0", percentage: dataSet.@sleet}, //sleet
				{type:"3.0", percentage: dataSet.@snow} //snow
			]);
			var sortField:SortField = new SortField();
			sortField.name = "percentage";
			sortField.numeric = true;
			sortField.descending = true;
			var numericDataSort:Sort = new Sort();
			numericDataSort.fields = [sortField];
			arr.sort = numericDataSort;
			arr.refresh();
			var ptyPercentagePoint:Number = Number(arr[0].percentage) + Number(arr[1].percentage) + Number(arr[2].percentage); 
			return (ptyPercentagePoint < 50)? "0.0" : arr[0].type.toString();
		}
		
		
		
		public function renameDscendantAttributes(epsgXml:XML,varType:String,grCode:Number):XML{
			if(varType=='MMX' || varType=='R12'){
				for each(var node:XML in epsgXml.regionGroup[grCode].descendants("@median")){
					node.setName("val");
				}
			}else if(varType=="SKY"){
				for each(var node:XML in epsgXml.regionGroup[grCode].descendants("@median")){
					node.parent().@median = getCloudCoverIndex(node.parent().@median);
					node.setName("val");
				}
			}else if(varType=="PTY"){
				for each(var node:XML in epsgXml.regionGroup[grCode].descendants("@rain")){
					if(node){
						node.parent().@rain = getPrecipitationTypeIndex(node.parent());
						node.setName("val");
					}
					
				}
			}	
			
			return epsgXml;
		}
		
		
//		private ARR_BASED_ON:Array = new Array();
		public function insertModel(mdls:Array, str_models:String):void{
//			str_models.length>4
			if(str_models.indexOf("+")!=-1){
				var currMdls:Array = str_models.split("+");
				for each(var mdlStr:String in currMdls){
					if(mdlStr.length>=3){
						if(!CheckArray2see_ifModelAlreadyExistsBeforePush(mdls,mdlStr)){ 
							mdls.push(mdlStr);
						}
					}
				}
			}else{
				
				if(str_models.length>=3){
					if(!CheckArray2see_ifModelAlreadyExistsBeforePush(mdls,str_models)){ 
						mdls.push(str_models);
					}
				}
			}
		}
		
		private function CheckArray2see_ifModelAlreadyExistsBeforePush(arr:Array, mdl:String):Boolean{
			// if mdl isn't already in the array  : FALSE
			return (arr.indexOf(mdl) == -1)? false : true;   
		}				
		
		public function getBaseModelLabel_SHRT_BEST_MULTI(arr_basedOn:Array,str_target:String){
			if(arr_basedOn.length > 0){
				if(arr_basedOn.length==1){
//					str_target += "BEST("+arr_basedOn[0]+")";							
					str_target += "("+arr_basedOn[0]+")";							
				}else if(arr_basedOn.length>1){ 
					for(var i:int=0; i<arr_basedOn.length; i++){
						if(i==0){
							str_target+="("+arr_basedOn[i];
						}else if(i==arr_basedOn.length-1){
							str_target+="+"+arr_basedOn[i]+")";
						}else{ 
							str_target+="+" + arr_basedOn[i];
						}
					}
				}
			}
			return str_target;
		}
		
		
	
		
		public function getBaseXML(dic:Dictionary, modelName:String, isMEDM:Boolean):XML{
			var str:String='';
			var baseXML:XML;
			if(dic['ECMWF']){
				if(modelName=='ECMWF'){
					str+='baseModel::';
					if(isMEDM){
						if(dic['GDPS']){
							baseXML = new XML(dic['GDPS']);
							str+='[GDPS MEDM]\n';
						}else if(dic['EPSG']){
							baseXML = new XML(dic['EPSG']); //adios
							str+='[EPSG MEDM]\n';
						}else if(dic['BEST']){
							baseXML = new XML(dic['BEST']); //adios
							str+='[BEST MEDM]\n';
						}else if(dic['ECMWF']){
							baseXML = new XML(dic['ECMWF']);
							str+='[ECMWF MEDM]\n';
						}
					}else{
						baseXML = new XML(dic['ECMWF']);
						str+='[ECMWF shrt]\n';
					}
				}
				str+='ECMWF isExists\n';
			}	
			if(dic['RDPS']){
				if(modelName=='RDPS'){
					baseXML = new XML(dic['RDPS']);
					str+='baseModel::';
				}
				str+='RDPS isExists\n';
			}
			if(dic['PMOS']){
				if(modelName=='PMOS'){
					baseXML = new XML(dic['PMOS']);
					str+='baseModel::';
				}
				str+='MOS isExists\n';
			}
			if(dic['GDPS']){
				if(modelName=='GDPS'){
					baseXML = new XML(dic['GDPS']);
					str+='baseModel::';
				}
				str+='GDPS isExists\n';
			}	
			if(dic['EPSG']){ //adios
				if(modelName=='EPSG'){
					baseXML = new XML(dic['EPSG']);
					str+='baseModel::';
				}
				str+='EPSG MEDM isExists\n';
			}	
			//doejeon Oct2015	
			if(dic['BEST']){
				if(modelName=='BEST'){
					baseXML = new XML(dic['BEST']);
					str+='baseModel::';
				}
				str+='BEST isExists\n';
			}
			return baseXML;
		}
		
		public function getMostRecnetDateTimeMan(key:String){
			var dateTimeArr:Array = new Array();
			dateTimeArr.push("lastUpdate.vsrt");
			dateTimeArr.push("lastUpdate.shrt");
			dateTimeArr.push("lastUpdate.medm");
			DJFUpdateTimeGetter.getInstance().getLastUpdateTime(dateTimeArr);
		}
		
		
	} //cls
	
}

 //pkg

class CommonUtilEnforcer{}