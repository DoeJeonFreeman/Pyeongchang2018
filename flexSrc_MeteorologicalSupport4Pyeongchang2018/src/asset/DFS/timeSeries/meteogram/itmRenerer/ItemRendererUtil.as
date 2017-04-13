package asset.DFS.timeSeries.meteogram.itmRenerer{
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	
	
	public class ItemRendererUtil{
		
		public static function createWithProperties(renderer:Class, properties:Object):IFactory{
			var factory:ClassFactory = new ClassFactory(renderer);
			factory.properties = properties;
			return factory;
		}		

	}
}