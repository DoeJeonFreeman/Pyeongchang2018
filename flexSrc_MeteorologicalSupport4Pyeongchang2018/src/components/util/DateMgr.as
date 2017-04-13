package components.util{
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.formatters.DateFormatter;
	
	
	
	public class DateMgr{
		
		public function DateMgr(){}
		
		
		public static function getMonth(monthString:String, padDigit:uint=2):String{
			var months = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
			for (var i:int=0; i<months.length; i++){
				if (months[i] == monthString) {
					var n:uint = i+1;
					var ret:String = n+'';
					while( ret.length < padDigit ){
						ret="0" + ret;
					}
					return ret;
				}
			}
			// not a valid month string
			return "-1DONTPISSMEOFF";
		}
		
		// 00UTC 17 Nov 2016
		public static function convertUTCStr2LST(utcTime:String):String{
//			DateField.stringToDate(dStr,"JJ DD MMM YYYY") returns null
			utcTime = utcTime.replace('UTC',''); 
			var arr:Array = utcTime.split(' ');
			utcTime = arr[3] + getMonth(arr[2]) + arr[1] + arr[0];
			var d:Date = addHours(str2Date(utcTime),9);
			return getYYYYMMDDStr(d,"KST_TRAILING") + "LST " + getYYYYMMDDStr(d,"KST_LEADING");
		}
		
		public static function getYYYYMMDDStr(dateObj:Date, type:String=null):String{
			var dateFormatter:DateFormatter = new DateFormatter();
			if(!type){
				dateFormatter.formatString = 'YYYYMMDDJJ';
			}else if(type=='dotSeparator'){
				dateFormatter.formatString = 'YYYY.MM.DD JJ';
			}else if(type=='preference'){
				dateFormatter.formatString = 'YYYY.MM.DD JJ:NN';
			}else if(type=='slash'){
				dateFormatter.formatString = 'YYYY-MM-DD JJ';
			}else if(type=="JJNN"){
				dateFormatter.formatString = 'YYYYMMDDJJNN';
			}else if(type=="TRAIL_UTC"){
				dateFormatter.formatString = 'YYYY년 MM월 DD 일 JJ시';
			}else if(type=="KST_LEADING"){
				dateFormatter.formatString = 'DD MMM YYYY';
			}else if(type=="KST_TRAILING"){
				dateFormatter.formatString = 'JJ';
			}
			return dateFormatter.format(dateObj);
		}
		
		
		public static function addShashIntoYYYYMMDD(dateStr:String):String{
				return dateStr.substring(0,4)+'/'+dateStr.substring(4,6)+'/'+dateStr.substring(6,8);
		}
			
		
		
		public static function str2Date(dateStr:String):Date{
			var date:Date = new Date();
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
			return date;
		}
		
		
		
		
		/**
		 * 		날짜 형식에 특수문자 제외
		 **/
		public static function getOriginDate(txt:String):String{
//			trace('DateMgr.getOriginDate(' + txt +') :: ' +txt.replace(/[ -.:]/g,""))
//        	return txt.replace(/[ -.:]/g,"");
//			trace('DateMgr.getOriginDate(' + txt +') :: ' +txt.replace(/(\/)/g, ""));
			return txt.replace(/(\/)/g, "");
        }
        
		/**
		 * 		숫자 형식에 특수문자 제외
		 **/
		public static function getOriginNumber(txt:String):Number{
        	return parseFloat(txt.replace(/\,/g,""));
        }
		
		
		public static function addWeeks(date:Date, weeks:Number):Date { 
           return addDays(date, weeks*7); 
        } 
       
       
       public static function addDays(date:Date, days:Number):Date { 
           return addHours(date, days*24); 
       } 
       
       
       public static function addHours(date:Date, hrs:Number):Date { 
           return addMinutes(date, hrs*60); 
       } 
       
       
       public static function addMinutes(date:Date, mins:Number):Date { 
           return addSeconds(date, mins*60); 
       } 
       
       
       public static function addSeconds(date:Date, secs:Number):Date { 
           var mSecs:Number = secs * 1000; 
           var sum:Number = mSecs + date.getTime(); 
           return new Date(sum); 
       } 
       
       
       public static function getDiff(dateTarget:Date, dateActual:Date):Object { 
              
          var MILLISECONDS_PER_DAY:int = 1000 * 60 * 60 * 24; 
          var MILLISECONDS_PER_HOUR:int = 1000 * 60 * 60; 
          var MILLISECONDS_PER_MIN:int = 1000 * 60; 
          var MILLISECONDS_PER_SEC:int = 1000; 
              
            var diff:Number = dateTarget.getTime()- dateActual.getTime(); 
            var swapBool : Boolean = false; 
            if(diff < 0) { 
                // in case of dateActual is bigger than dateTarget so swap it 
                swapBool = true; 
                var td : Date = dateActual; 
                dateActual = dateTarget; 
                dateTarget = td; 
                diff = dateTarget.getTime()- dateActual.getTime(); 
            } 
            var num:Number = diff/MILLISECONDS_PER_DAY; 
            var d : int = Math.floor(num); 
            var str : String = "Day:" + d.toString(); 
            diff = diff - ( d* MILLISECONDS_PER_DAY ); 
            num = diff/MILLISECONDS_PER_HOUR; 
            var h : int = Math.floor(num); // Hour diff 
            str += " Hour:" + h.toString(); 
            diff = diff - ( h* MILLISECONDS_PER_HOUR ); 
            num = diff/MILLISECONDS_PER_MIN; 
            var m : int = Math.floor(num); // Min diff 
            str += " Min:" + m.toString(); 
            diff = diff - ( m* MILLISECONDS_PER_MIN ); 
            num = diff/MILLISECONDS_PER_SEC; 
            var s : int = Math.floor(num); // Sec diff 
            str += " Sec:" + s.toString(); 
            var retObj : Object = new Object(); 
            retObj.diffStr = str; // it my require string in own format u can modify by own way 
            retObj.swapBool = swapBool; // in case a date need to be swap 
            return retObj; 
       } 
       
       
        public static function getDayString(date:Date):String { 
            var c : int = date.day; 
            var str:String = null; 
            switch(c) 
            { 
                case 0: 
                    str = "Sunday"; 
                    break; 
                case 1: 
                    str = "Monday"; 
                    break; 
                case 2: 
                    str = "Tuesday"; 
                    break; 
                case 3: 
                    str = "Wednesday"; 
                    break; 
                case 4: 
                    str = "Thursday"; 
                    break; 
                case 5: 
                    str = "Friday"; 
                    break; 
                case 6: 
                    str = "Saturday"; 
                    break; 
                default: 
                    break; 
            } 
            return str; 
        } 
       
           public static function checkDate(d1:Date, d2:Date):Boolean { 
            if(d2.getFullYear() > d1.getFullYear()) 
            { return true; } 
            else if(d2.getFullYear() == d1.getFullYear()) { 
                if(d2.month > d1.month) 
                    { return true; } 
                else if(d2.month == d1.month) { 
                    if(d2.date >= d1.date) 
                        { return true; } 
                    else 
                        { return false; } 
                   } 
                else 
                { return false; } 
              }     
            else 
                  { return false; } 
        } 



	} //class
	
}//package