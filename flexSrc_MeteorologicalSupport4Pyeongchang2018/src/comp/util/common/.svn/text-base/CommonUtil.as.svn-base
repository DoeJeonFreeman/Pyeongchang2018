package comp.util.common{
	import asset.DFS.timeSeries.meteogram.style.ChartStyleAssets;
	
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
	import mx.managers.PopUpManager;
	import mx.resources.ResourceBundle;
	import mx.utils.ObjectProxy;
	import mx.utils.StringUtil;
	
	import org.as3commons.lang.StringUtils;
	
	
	/**
	 * 
	 * 2016.05.31 
	 * 
	 * 1. replace getBasalModelStr() with resourceBundle.properties
	 * 2. implements ??? in php
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
//					colour = ChartStyleAssets.SC_MEDM_EPSG.color; //active는 얘쓰고
//					colour = ChartStyleAssets.SC_SHRT_KWRF.color; //backup은 얘쓰고
					colour = ChartStyleAssets.SC_SHRT_RDPS.color; //djf2016 중기BEST가 빨간색. 기존 EPSG는 단기 RDAPS와 동일한 오렌지컬러로 변경
				}
			}
			return colour;
		}
		
		/**
		 * 2016년 3월 단기BEST 현업적용하면서 사용 안함.setBasedOnStr()에서 얘 호출했었는데 이제 안씀
		 * 모델비교시 베이스모델임. 
		 * */
		/**
		public function getBasedOnStr(baseModelName:String,isMEDM:Boolean,isMMX:Boolean=false,isR12:Boolean=false):String{}

		 * */
//Flex 3		
//		var listViewtooltip:String = ResourceManager.getInstance().getString("strings", "listViewtooltipKey");
//  Flex 2 St.
//		[ResourceBundle("vars")]
//		private static var vars:ResourceBundle;
//		vars.getString("SHRT.RDPS_MOS." + varType) 
		
		[Bindable]private var properties:Object;
		
		public function loadBaseModelResources(url:String):void{
		var urlLoader:URLLoader= new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,meCompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,  meXmlLoadFailed);
			urlLoader.load(new URLRequest(url));
		}
		
		private function meXmlLoadFailed(e:Event):void{
			showAlertDialogOnScreenTop("Failed to load basedOn.properties","IOErrorEvent.IO_ERROR");
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
		public function getTimeseriesDataPath(str:String, typeFlag:String='FULLPATH_EXT'):String{
			var path:String = '';
			if(chartDataInfo != null){
				var arr:Array = str.split(' ');
				//if(arr.length==0) //throw shit;
				if(typeFlag=='FULLPATH'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX']; 
				}else if(typeFlag=='DIR'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] ; 
				}else if(typeFlag=='PRFX'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX'] ; 
				}else if(typeFlag=='FULLPATH_EXT'){
					path = chartDataInfo[arr[0]+'.'+arr[1]+'.DAOU'] + chartDataInfo[arr[0]+'.'+arr[1]+'.PRFX']; 
					path += '.'+arr[2]+'.xml';
				}	
			}	
			trace('URL[' + StringUtil.trim(path) +']')
			return  StringUtil.trim(path);
		}
		//  SHRT.RDPS_MOS 	T3H 	201512190000 	5 	[isMulti]
		public function getTimeseriesDataPathByGivenProperty(str:String, dStr:String):String{
			var path:String = '';
			if(chartDataInfo != null){
				var arr:Array = str.split(' ');
				path = chartDataInfo[str+'.DAOU'] + chartDataInfo[str+'.PRFX']; 
				path += '.'+dStr+'.xml';
			}	
			trace('URL[' + StringUtil.trim(path) +']')
			return  StringUtil.trim(path);
		}
		// SHRT.RDPS_MOS POP 201512190000 5
		/** PMOS2는 이제 없어 !!!!!! */
		/** PMOS2는 이제 없어 !!!!!! */
		/** PMOS2는 이제 없어 !!!!!! */
		public function getTimeseriesDataBaseModel(str:String):String{
			var legacyName:String = '';
			var modelFalg:String = str.split(' ')[0];
			modelFalg = StringUtil.trim(modelFalg.split('.')[1]);
			if(modelFalg=='RDPS_MOS'){
				legacyName = 'PMOS';
			}else if(modelFalg=='RDPS'){
				legacyName = 'RDPS';
			}else if(modelFalg=='ECMWF_MOS'){
				legacyName = 'ECMWF';
			}else if(modelFalg=='BEST'){
				legacyName = 'BEST';
			}else if(modelFalg=='SSPS'){
				legacyName = 'SSPS';
			}else if(modelFalg=='EPSG_MOS'){
				legacyName = 'EPSG';
			}else if(modelFalg=='GDPS_MOS'){
				legacyName = 'GDPS';
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
//		
		public function getBaseModelIndex2(dic:Dictionary,modelName:String,isMEDM:Boolean):int{
			var str:String='';
			var index:int;
			
			if(!isMEDM){
				
				if(dic['PMOS']){
					index = 1;
				}else if(dic['RDPS']){
					index = 2;
//				}else if(dic['KWRF']){
//					index = 3;
				}else if(dic['ECMWF']){
					index = 3;
				}
				
			}else{
//				if(modelName=='PMOS2'){  //MMX
//					if(dic['GDPS']){
//						index = 1;
//					}else{
//						index = 2;
//					}
//				}else{                  // other MEDM var
					if(dic['GDPS']){
						index = 1;
					}else{
						index = 2;
					}
//				}	
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
		
		//adios
		//
		public function getBaseXML(dic:Dictionary, modelName:String, isMEDM:Boolean):XML{
			//			if(modelName=="EPSG"){
			//				
			//			}
			var str:String='';
			var baseXML:XML;
//			if(dic['KWRF']){
//				if(modelName=='KWRF'){
//					if(dic['PMOS']){
//						baseXML = new XML(dic['PMOS']);
//						str+='axisProvider:: PMOS\n'
//					}else if(dic['RDPS']){
//						baseXML = new XML(dic['RDPS']);
//						str+='axisProvider:: RDPS\n'
//					}else if(dic['ECMWF']){
//						baseXML = new XML(dic['ECMWF']);
//						str+='axisProvider:: ECMWF\n'
//					}else{
//						baseXML = new XML(dic['KWRF']);
//					}
//					str+='baseModel::';
//				}
//				str+='[KWARF]\n';
//			}
			if(dic['ECMWF']){
				if(modelName=='ECMWF'){
					str+='baseModel::';
					if(isMEDM){
//						if(dic['PMOS2']){
//							baseXML = new XML(dic['PMOS2']);
//							str+='[PMOS2 MEDM]\n';
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
//			if(dic['PMOS2']){
//				if(modelName=='PMOS2'){
//					baseXML = new XML(dic['PMOS2']);
//					str+='baseModel::';
//				}
//				str+='PMOS2 MEDM isExists\n';
//			}	
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
			
			
//			showAlertDialogOnScreenTop(str, 'CommonUtil.getBaseXML()' + modelName+ ',isMEDM:' +isMEDM );
			
			return baseXML;
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
					
					//멀티차트 기온 민맥스 및 최고 강수 뽑기					
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
			
			//			    if(isTemperature)	
			//				//멀티차트 기온 민맥스 뽑기					
			if(isTemperature){
				var maxVal:Number =  Math.max.apply(null, arr_4assignMaxMin)
				var minVal:Number =   Math.min.apply(null, arr_4assignMaxMin)
				//			    	Infinity
				if(maxVal != Infinity  && minVal != Infinity && !isNaN(maxVal)  && !isNaN(minVal) ){
					//						trace('Temperature minMax count(n):: '+arr_4assignMaxMin.length +'\nMax:: ' + maxVal + ' / Min:: ' +minVal );
					assignMaxMin(maxVal , minVal);
				}else{
					//						trace('! minMaxVal is not a number !\n\n');
				}
			}
			
			//멀티차트 기온 민맥스 뽑기					
			if(isKindOfPrcp){
				var maxPrcp:Number =  Math.max.apply(null, arr_4assignMaxMin);
				//			    	trace("maxPrcp. " + maxPrcp+"\n")
				if(maxPrcp != Infinity && !isNaN(maxPrcp)){
					//			    		trace("fxxkin\' a")
					assignMaxPrcp(maxPrcp);
					
				}else{
					//			    		trace("fxxk..")
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
		
		/**
		 * 2016-02-17 
		 * 앙상블 PTY와 동일하게  중기PTY모델비교 역시 ==> 무강수를 제외한 강수형태의 합이 50 미만일 경우 강수형태를 무강수로 변경. 
		 * */
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
//					CommonUtil.getInstance().showAlertDialogOnScreenTop(lbl_bestMdl,"ARR_BASED_ON.size: "+ARR_BASED_ON.length);
			}
			return str_target;
		}
		
		
	} //cls
	
}

 //pkg

class CommonUtilEnforcer{}