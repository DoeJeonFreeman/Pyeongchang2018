package components.util{
	
	public class CSV2ARR{
		
		
		private static var instance:CSV2ARR = new CSV2ARR();
		
		//Flex는 생성자 접근제어자를 private로 못함
		public function CSV2ARR(){
			if(instance){
				throw new Error("negative..u cannot create a new instance of CSV2ARR haha.. plz use CSV2ARR.getInstance() method");
			}
		}
		
		public static function getInstance():CSV2ARR{
			return instance;
		}
		
		
		/**
		 *  Made By Jaume Mussons - Castellar del Vallès (Barcelona)
		 *  Feel free to use this code the way you want, but keeping the author's name. Thanks!
		 *
		 *  Parse a csv standard file format string data to an array.
		 *
		 *  The process is divided in two steps:
		 *   1 - We prepare the string for an easier split operation. To do so, we replace all the &quot;&quot; groups with
		 *       XX and then replace all the characters inside &quot;.. ...... &quot; with X. This is done to get the mapping
		 *       for the field locations so its really easier to split the string without caring about scaped chars.
		 *
		 *   2 - With the optimized string as a reference, we find all the field positions on the real string, as we
		 *       know that they are the same lenght so we can cut the real one using the modified one as a reference.
		 */
		public function csvTextToArray(str:String):Array{
		
			// STEP 1: Prepare the reference string replacing unwanted characters --------------------------------------
		
			var found:Boolean = false;
			var aux:String = ""; // define the string that will be used as the reference to split the data
		
			for(var i:int=0; i<str.length; i++){
		
				// Two double cuotes are always replaced when found adjacent
				if(str.charAt(i) == '"' && str.charAt(i+1) == '"'){
					aux += 'XX';
					i+=2;
				}
		
				// finding a " means the start or end of a scaped field
				if(str.charAt(i) == '"')
					found = !found;
		
				// if we are currently inside a scaped field, we will be replacing all the characters with X, otherwise leave them untouched
				if(found)
					aux += 'X';
				else
					aux += str.charAt(i);
			}
		
			// STEP 2: Split the real data ----------------------------------------------------------------------------
			// Note that we use vectors when possible to improve performance
		
			var result:Array = new Array(); // to store the result
			var reference_vec:Vector.<String> = Vector.<String>(aux.split("\n")); // Cut all the csv lines from the reference string
			var j:int = reference_vec[0].length + 1; // Point the j index to the start of the firs line afther the headers containing column names
			var keys:Vector.<String> = Vector.<String>(reference_vec.shift().split(",")); // Get an array with all the column headers, that are located on the first line of the string
		
			for each(var line:String in reference_vec){
		
				if(line != ""){
		
					var resultfields:Array = new Array();
					var fields:Vector.<String> = Vector.<String>(line.split(","));
		
					// Loop throught all the reference fields and find the real position on the real string
					for (i=0; i<fields.length; i++){
		
						// Get the real field on the aux string
						aux = str.slice(j, j + fields[i].length);
						j += fields[i].length + 1;
		
						// Check if we need to restore scaped field. If field starts with " we remove first and last chars
						// And then replace all the "" groups with simple ". This restores the field to its real value
						if(aux.charAt(0) == '"')
							aux = aux.substr(1,aux.length - 2).replace(/""/g, '"');
		
						// store the field on the result array under it's corresponding column key
						resultfields[keys[i]] = aux;
						
					}
					result.push(resultfields);
				}
		
			}
		
			return result;
		
		}


	}//class
}//package