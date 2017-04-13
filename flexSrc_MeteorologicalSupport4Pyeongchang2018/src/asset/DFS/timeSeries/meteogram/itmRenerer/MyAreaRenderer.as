package asset.DFS.STN_NPPM.meteogram.itmRenerer
{ 
import mx.core.IDataRenderer; 
import mx.skins.ProgrammaticSkin; 
import mx.charts.series.items.AreaSeriesItem; 
import mx.charts.series.renderData.AreaSeriesRenderData; 
import flash.display.Graphics; 

public class MyAreaRenderer extends ProgrammaticSkin implements IDataRenderer 
{ 
private var _data:AreaSeriesRenderData; 

public function get data():Object 
{ 
return _data; 
} 

public function set data(d:Object):void 
{ 
_data = d as AreaSeriesRenderData; 
} 

override protected function updateDisplayList(width:Number, height:Number):void 
{ 
super.updateDisplayList(width, height); 

var g:Graphics = graphics; 

g.clear(); 
g.moveTo(width,height); 
g.beginFill(0xFF0000); 

for (var index:String in _data.filteredCache) 
{ 
var item:AreaSeriesItem = _data.filteredCache[index]; 

g.lineTo(item.x, item.y); 
} 
g.endFill(); 
} 
} 
} 