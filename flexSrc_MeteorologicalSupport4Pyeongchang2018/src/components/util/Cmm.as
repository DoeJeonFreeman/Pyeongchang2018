package components.util{
	import flash.geom.Point;
	
	import mx.charts.chartClasses.LegendData;
	import mx.charts.series.PieSeries;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.controls.ComboBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.ValidationResultEvent;
	import mx.managers.CursorManager;
	import mx.utils.ObjectUtil;
	
	/**
	 * 		공통 Utility로 static const 전역 변수와 static function 들로 구성.
	 * */
	public class Cmm{
		import flash.external.ExternalInterface;
		import mx.formatters.NumberFormatter;
		import mx.rpc.events.FaultEvent;
		import mx.collections.Sort;
		import mx.collections.SortField;
		
		/**
		 * 		HttpService 요청 시 root url
		 * */
		public static const ROOT_URL:String = ExternalInterface.call("getHttpDataRoot");
		
		/**
		 * 		영업기회 단위: 백만원(1,000,000)
		 **/
		public static const DW_OPPORTUNITY:int = 1000000;
		
		
		/**
		 * 		영업기회 단위: 천원(1,000)
		 **/
		public static const DW_SM_OPPORTUNITY:int = 1000;
		
		/**
		 * 		선택 가능 단위
		 **/
		public static const UNIT_DATA:Array = [
				 {label:"단위:원", data:"1"}
				,{label:"단위:천원", data:"1000.0"}
				,{label:"단위:백만원", data:"1000000.0"}
				,{label:"단위:억원", data:"100000000.0"}];
		
		/**
		 * 		단위 기본 선택
		 **/
		public static const DEFAULT_UNIT_INDEX:int = 2;
		
		
		/**
	   	 * 		sect sum field adding word
	   	 **/
	   	public static const ADD_FIELD_NAME_SUM :String = "";
		
		/**
		 * 		통합분석 공통 색상 1
		 **/
		public static const color1:uint = 0x0066FF;		//color 테스트 - 내부 패널
		
		/**
		 * 		통합분석 공통 색상 2
		 **/
		public static const color2:uint = 0xFFFFFF;		//color 테스트 - 외부 패널
		
		/**
		 * 		통합분석 공통 색상 3
		 **/
		public static const color3:uint = 0xFFFFFF;		//color 테스트 - 외부 패널 bg
		
		/**
		 * 		msc 컴포넌트의 색상
		 **/
		public static const mscColors:Array = ["","#228B22","#AC39A7","#FF5099"];		//msc 타입 칼라
		
		/**
		 * 		msp 컴포넌트의 색상
		 **/
		public static const mspColors:Array = ["","",""];		//msp 타입 칼라
	    
	    /**
		 * 		차트 배경색의 Alpha (Main 에서 공통적으로 사용됨)
		 **/
		public static const wallsFillAlpha:Number = 0;
		
		public static function compareAttributeValue(xml:XML, name:String, value:String="true", valueIs:Boolean=true):Boolean{
			name="@"+name.replace("@","");
			var isTrue:Boolean;
			if(valueIs){
				isTrue = xml.hasOwnProperty(name) && String(xml[name])==value;
			}else{
				isTrue = xml.hasOwnProperty(name) && String(xml[name])!=value;
			}
			return isTrue;
		}
		
		/**
		 * 		숫자 포멧<br>
		 * 		######.# => ###,###.#<br>
		 * 		반올림
		 **/
		public static function numberFormat(num:String, precision:Number=0, danwi:Number=1):String {
			var result:String;
			if(num != "N/A"){
				var f:NumberFormatter = new NumberFormatter();
				f.precision = precision;
				f.rounding = "nearest";
				result = f.format(parseFloat(num)/danwi);
				/* //버전업하고 필요없는듯 
				if ( Number(result) < 1 && Number(result) > 0 ){
					result = "0" + result;
				} */
			}else{
				if(num == ""){
					result="0";
				}else{
					result = num;
				}
			}
			return result;
		}
		
		/**
		 * 		percent (%) 구하기 <br>
		 * 		예)	3/2 = 1.5<br>
		 * 			getPer(2,3) = 2
		 **/
		public static function getPer(parent:String, child:String):String{
			if(child=="NaN")
				child="0";
			var result:Number = Cmm.getOriginNumber(child)/Cmm.getOriginNumber(parent)*100;
			var str:String;
			if(isNaN(result))
				str = "N/A";
			else
				str = Cmm.numberFormat(String(result));
				
			if(parent == "0")
				str = "N/A";
			return str;
		}
		
		public static function makeDate(dateStr:String):Date{
			var date:Date = new Date();
			//trace(dateStr+">>>"+getOriginDate(dateStr));
			dateStr = getOriginDate(dateStr);
			if(dateStr.length>=4){
				date.fullYear = int(dateStr.substring(0,4));
				if(dateStr.length>=6){
					date.month = int(dateStr.substring(4,6))-1;
					if(dateStr.length>=8){
						date.date = int(dateStr.substring(6,8));
						if(dateStr.length>=10){
							date.hours = int(dateStr.substring(8,10));
							if(dateStr.length>=12){
								date.minutes = int(dateStr.substring(10,12));
								if(dateStr.length>=14){
									date.seconds = int(dateStr.substring(12,14));
								}
							}
						}
					}
				}
			}
			//trace("date.hours>>>"+date.hours);
			return date;
		}
		
		public static function addZeroNumber(value:int, jarisu:int = 2):String{
			var str:String = String(value);
			while(str.length < jarisu){
				str = "0"+str;
			}
			return str;
		}
		
		public static function setComboBoxLabel(combo:ComboBox, label:String):void{
			var isSearch:Boolean=false;
			for each(var item:Object in combo.dataProvider){
				if(label == item.data){
					combo.selectedItem = item;
					isSearch=true;
					break;
				}
			}
			//밑은 나중에 지워야함.
			if(!isSearch){
				combo.selectedIndex = combo.dataProvider.length-1;//0;
			}
		}
		
		/**
		 * 		날짜 포멧 <br>
		 * 		yyyyMMdd => yyyy.MM.dd
		 **/
		public static function dateFormat(dateStr:String) : String{
			if(dateStr != "")
				dateStr = dateStr.substring(0,4)+"."+dateStr.substring(4,6)+"."+dateStr.substring(6,8);
			return dateStr;
		}
		
		/**
		 * 		날짜 포멧 <br>
		 * 		yyyyMMdd => yyyy.MM
		 **/
		public static function dateFormatYYYYMM(dateStr:String) : String{
			if(dateStr != "")
				dateStr = dateStr.substring(0,4)+"."+dateStr.substring(4,6);
			return dateStr;
		}
		
		/**
		 * 		날짜 포멧 <br>
		 * 		yyyyMMdd => yy.MM.dd
		 **/
		public static function dateFormatYYMMDD(dateStr:String) : String{
			if(dateStr != "")
				dateStr = dateStr.substring(2,4)+"."+dateStr.substring(4,6)+"."+dateStr.substring(6,8);
			return dateStr;
		}
		
		/**
		 * 		HttpService 실패 함수
		 **/
		public static function faultHandler(value:FaultEvent):void{
        	CursorManager.removeBusyCursor();
        	trace("[HTTPSERVICE:faultHandler]\n"+value);
        	Alert.show(value.toString());
        }
        
        /**
		 * 		WebService 실패 함수
		 **/
        public static function webServiceFaultHandler(event:FaultEvent):void{
	   		CursorManager.removeBusyCursor();
	 		//Alert.show(event.toString());
		}
		
		/**
		 * 		Array 오름차순 정렬
		 **/
		public static function orderByBigger(array:ArrayCollection, field:String = "", isNumber:Boolean = false):ArrayCollection{
			var sort:Sort = new Sort();
			if(field != ""){
        		//SortField("필드명", 대소문자구분여부, 내림차순/올림차순, 문자/숫자 구분)
        		sort.fields = [new SortField(field, false, false, isNumber)];
   			}
        	array.sort = sort;
        	array.refresh();
        	return array;
        }
        
        /**
		 * 		Array 오름차순 정렬
		 **/
		public static function orderByBiggerXml(array:XMLListCollection, field:String = "", isNumber:Boolean = false):XMLListCollection{
			var sort:Sort = new Sort();
			if(field != ""){
        		sort.fields = [new SortField(field, false, false, isNumber)];
   			}
        	array.sort = sort;
        	array.refresh();
        	return array;
        }
        
		/**
		 * 		Array 내림차순 정렬
		 **/
		public static function orderBySmaller(array:ArrayCollection, field:String = "", isNumber:Boolean = false):ArrayCollection{
			var sort:Sort = new Sort();
			if(field != ""){
        		sort.fields = [new SortField(field, false, true, isNumber)];
   			}
        	array.sort = sort;
        	array.refresh();
        	return array;
        }
        
        /**
		 * 		Array 내림차순 정렬
		 **/
		public static function orderBySmallerXml(array:XMLListCollection, field:String = "", isNumber:Boolean = false):XMLListCollection{
			var sort:Sort = new Sort();
			if(field != ""){			  //필드,화살표 밑으로인지,큰게 위로인지,숫자정렬인지
        		sort.fields = [new SortField(field, false, true, isNumber)];
   			}
        	array.sort = sort;
        	array.refresh();
        	return array;
        }
        
        /**
         * 		DataGrid 숫자 정렬
         **/
        public static function orderNumber(itemA:Object, itemB:Object):int {
		    if (parseFloat(itemA.PRE_AMT) > parseFloat(itemB.PRE_AMT)) {
		        return -1;
		    } else if (parseFloat(itemA.PRE_AMT) < parseFloat(itemB.PRE_AMT)) {
		        return 1;
		    } else {
		        return 0;
		    } 
		}
		
		/**
		 * 		xml attribute 값을 object로
		 **/
		public static function setPropertyOfAttribute(item:XML, obj:Object):Object{
			var newObject:Object = new Object();
			
			var properties:Array = ObjectUtil.getClassInfo(obj).properties;
			for each(var propertyName:String in properties){
				var attributeName:String = obj[propertyName];
				if(item.hasOwnProperty(attributeName)){
					newObject[propertyName] = item[attributeName];
				}
			}
			return newObject;
		}
		
		/**
		 * 		xml attribute 값을 object로
		 **/
		public static function xmlToObject(item:XML):Object{
			var newObject:Object = new Object();
			
			for each(var att:XML in item.attributes()){
				newObject[att.name().toString().replace("@","")] = att;
			}
			return newObject;
		}
		
		/**
		 * 		xml attribute 값을 get방식 parameter로
		 **/
		public static function xmlToParam(item:XML):String{
			var str:String = "?";
			
			for each(var att:XML in item.attributes()){
				var key:String = att.name().toString().replace("@","");
				var value:String = att;
				
				str+=key+"="+value+"&";
			}
			return str;
		}
		
		/**
		 * 		날짜 형식에 특수문자 제외
		 **/
		public static function getOriginDate(txt:String):String{
        	return txt.replace(/[ -.:]/g,"");
        }
        
		/**
		 * 		숫자 형식에 특수문자 제외
		 **/
		public static function getOriginNumber(txt:String):Number{
        	return parseFloat(txt.replace(/\,/g,""));
        }
		
		/**
		 * 		페이지 이동 (variableProperty.js)<br>
		 * 		menunum : 메뉴 ID<br>
		 * 		pageid  : page 명
		 **/
		public static function moveToPage(menunum:String, pageid:String):void{
			ExternalInterface.call("movePage", menunum, pageid);
		}	
		
		/**
		 * 		Y축 숫자  (100 단위 마다) ',' 표시
		 **/
		public static function verticalAxisLabelFnc(labelValue:Object, previousValue:Object, axis:Object):String{
			return Cmm.numberFormat(String(labelValue));
		}
		
		/**
		 * 		X축 월 표시
		 **/
		public static function monthLabelFnc(labelValue:Object, previousValue:Object, axis:Object, categoryItem:Object):String{
			return int(labelValue)+"월";
		}
		
		/**
		 * 		데이터 그리드에 숫자 (100 단위 마다) ',' 표시
		 **/
		public static function dataGridColumnLabelFnc(item:Object, column:DataGridColumn):String{
	  		return Cmm.numberFormat(item[column.dataField]);
	 	}
	 	
	 	/**
		 * 		데이터 그리드에 날짜 (YYYY.MM.DD) 표시
		 **/
		public static function dataGridColumnLabelFncDate(item:Object, column:DataGridColumn):String{
	  		return Cmm.dateFormat(item[column.dataField]);
	 	}
	 	
	 	/**
		 * 		% 값을 기준으로 글자 색 정의<br>
		 * 		100 이상 : 파랑<br>
		 * 		 80 이상 : 검정<br>
		 * 		 80 이하 : 빨강<br>
		 * 		 N/A   : 회색
		 **/
	 	public static function getStateColor(percentLabel:String):Object{
	 		var returnObj:Object;
	 		var percentVal:Number = Cmm.getOriginNumber(percentLabel.substring(0,percentLabel.indexOf(" %")));
  			if(isNaN(percentVal)){
  				returnObj = {color:"#C0C0C0"};
  			}else{
	  			percentVal >= 100 
	  				? returnObj = {color:"#0000ff"} 
	  				: percentVal >= 80 
	  					? returnObj = {color:"#000000"}
	  					: returnObj = {color:"#ff0000"}
	  			;
  			}
  			return returnObj;
	 	}
	 	
	 	/**
		 * 		% 값을 기준으로 글자 정의<br>
		 * 		100 이상    : 양호<br>
		 * 		100 이하    : 미달
		 **/
	 	public static function getStateLabel(percentLabel:String):String{
	 		var returnObj:String;
	 		var percentVal:Number = Cmm.getOriginNumber(percentLabel.substring(0,percentLabel.indexOf(" %")));
	  			percentVal >= 100 ? returnObj = "양호" : returnObj="미달";
  			return returnObj;
	 	}
	 	
		/**
		 * 		위치 이동값 반환 코드
		 * 		target의 중심 값
		 **/
		public static function getDistancePoint(moveObj:*, target:*):Point{
			var resultPoint:Point;
			
			if(moveObj.stage != null && target.stage != null)
			{
				var point1:Point = new Point(moveObj.stage.x, moveObj.stage.y);
				point1 = moveObj.localToGlobal(point1);
				var point2:Point = new Point(target.stage.x + target.width/2, target.stage.y + target.height/2);
				point2 = target.localToGlobal(point2);
				resultPoint = new Point(point2.x - point1.x, point2.y - point1.y);
			}
			return resultPoint;
		}
		
		public static function getRightTopPoint(moveObj:*, target:*):Point{
			var resultPoint:Point;
			resultPoint = getDistancePoint(moveObj, target);
			if(resultPoint){
				resultPoint = new Point(resultPoint.x - target.width/2, resultPoint.y - target.height/2);
			}
			return resultPoint;
		}
		
		
		public static const RECT_POINT_RIGHT_TOP:int = 3;
		public static const RECT_POINT_RIGHT_MIDDLE:int = 4;
		public static const RECT_POINT_RIGHT_BOTTOM:int = 5;
		public static const RECT_POINT_LEFT_TOP:int = 1;
		public static const RECT_POINT_LEFT_MIDDLE:int = 8;
		public static const RECT_POINT_LEFT_BOTTOM:int = 7;
		public static const RECT_POINT_MIDDLE_TOP:int = 2;
		public static const RECT_POINT_MIDDLE_BOTTOM:int = 6;
		public static const RECT_POINT_CENTER:int = 0;
		
		/**
		 * 	바둑판 무늬 일때만 적용
		 *  아닐땐 최단 거리 구해야함.
		 **/
		public static function getShortestPoint(f, t):Object{
			var obj:Object = new Object();
			obj.fromPoint=RECT_POINT_CENTER;
			obj.toPoint=RECT_POINT_CENTER;
			
			if(f.x > t.x){
				if(f.y > t.y){
					obj.fromPoint = RECT_POINT_RIGHT_BOTTOM;
					obj.toPoint = RECT_POINT_LEFT_TOP;
				}else if(f.y < t.y){
					obj.fromPoint = RECT_POINT_LEFT_BOTTOM;
					obj.toPoint = RECT_POINT_RIGHT_TOP;
				}else if(f.y == t.y){
					obj.fromPoint = RECT_POINT_LEFT_MIDDLE;
					obj.toPoint = RECT_POINT_RIGHT_MIDDLE;
				}
			}else if(f.x < t.x){
				if(f.y > t.y){
					obj.fromPoint = RECT_POINT_RIGHT_TOP;
					obj.toPoint = RECT_POINT_LEFT_BOTTOM;
				}else if(f.y < t.y){
					obj.fromPoint = RECT_POINT_RIGHT_BOTTOM;
					obj.toPoint = RECT_POINT_LEFT_TOP;
				}else if(f.y == t.y){
					obj.fromPoint = RECT_POINT_RIGHT_MIDDLE;
					obj.toPoint = RECT_POINT_LEFT_MIDDLE;
				}
			}else if(f.x == t.x){
				if(f.y > t.y){
					obj.fromPoint = RECT_POINT_MIDDLE_TOP;
					obj.toPoint = RECT_POINT_MIDDLE_BOTTOM;
				}else if(f.y < t.y){
					obj.fromPoint = RECT_POINT_MIDDLE_BOTTOM;
					obj.toPoint = RECT_POINT_MIDDLE_TOP;
				}else if(f.y == t.y){
					obj.fromPoint = RECT_POINT_CENTER;
					obj.toPoint = RECT_POINT_CENTER;
				}
			}
			return obj;
		}
		
		/**
		 * 		Legend에 전체 데이터 sum값 표시 <br>
		 *  	Chart.updateComplete = "Cmm.resetLegendData(columnChart)"
		 **/
		public static function resetLegendData(chart:Object, preWord:String ="(", afterWord:String=")"):void{
			var dp:Array = chart.legendData;
			for (var i:int = 0; i < dp.length; i++){
				var curList:Array = (dp[i] as Array);
	            if (!curList){
	                var series:Object = Object(LegendData(dp[i]).element);
					var yField:String;
						yField = series.yField;
					
					var sum:Number=0;
					for each(var xml:XML in XMLList(chart.dataProvider)){
						sum+=Number(xml[yField]);
					}
					
					var label:String = series.displayName;
					if(label.indexOf(preWord) != -1)
						label = label.substring(0,label.indexOf(preWord));
					
					series.displayName = 
						label + preWord + Cmm.numberFormat(String(sum)) + afterWord;
	            }
			}
		}
		
		/**
		 * 		3.0 upgrade 후 파이차트 라벨 잔상 버그
		 **/
		public static function resetPie(pie:PieSeries):void{
        	pie.setStyle("font-weight","nomal");
        	pie.setStyle("font-weight","bold");
        }
        
        /**
		 * 		무작위 색상
		 **/
        public static function getRandomColor():uint{
	        //var colors:Array = [0x7FCEFF, 0x96C792, 0xFF8000, 0xFFF000, 0x2080D0, 0x30C0FF, 0xFFFF80, 0x808080, 0x2080D0, 0x30C0FF];
        	//trace(colors[random0to9()]);
        	return int(Math.random()*4294967295);
        }
        
        /**
		 * 		0~9 무작위 숫자
		 **/
        public static function random0to9():int{
        	return int(Math.random()*10);
        }
        
        public static function getParametersObject():Object{
			var parametersObject:Object = new Object();
			
			var parameterSource:String = ExternalInterface.call("getParameters");
			//Alert.show("parameterSource:"+parameterSource);
			if(parameterSource){
				var parameters:Array = parameterSource.split(";");
				for each(var parameter:String in parameters){
					var name:String = parameter.split(":")[0];
					var value:String = parameter.split(":")[1];
					
					parametersObject[name] = value;
				}
			}
			return parametersObject;
		}
		
		public static function validate(validationResultEvents:Array):String{
			for each(var validationResultEvent:ValidationResultEvent in validationResultEvents){
				if(validationResultEvent.type == ValidationResultEvent.INVALID){
					return ValidationResultEvent.INVALID;
				}
			}
			return ValidationResultEvent.VALID;
		}
	}
}