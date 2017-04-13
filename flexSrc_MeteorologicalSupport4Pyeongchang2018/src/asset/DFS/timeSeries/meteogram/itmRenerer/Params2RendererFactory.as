package asset.DFS.STN_NPPM.meteogram.itmRenerer{
	
	
	
	import flash.utils.Dictionary;
	   
	import mx.core.IFactory;

   public class Params2RendererFactory implements IFactory{
   	
	    private var klass:Class;
	    private var args:*;
  
	 	public function Params2RendererFactory(args:*,klass:Class) {
			 this.args=args;
			 this.klass=klass;
		}
  
  		public function newInstance():*{
			var instance:Object = new klass;

			 for (var key:String in args) {
			    if (instance.hasOwnProperty(key)) {
			       instance[key] = args[key];
			    }
			 }
 
			 return instance;   
		}
  
  
  
   }//cls
   
}//pkg