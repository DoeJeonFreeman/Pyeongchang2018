package components.util{
import flash.display.Graphics;
import mx.charts.ChartItem;
import mx.charts.series.items.ColumnSeriesItem;
import mx.charts.series.items.LineSeriesItem;
import mx.controls.Label;
import mx.core.IDataRenderer;
import mx.core.UIComponent;

public class AverageLineRenderer extends UIComponent implements IDataRenderer
{
private var _chartItem:ChartItem;
private var _label:Label; // A label to place on the top of the column.

public function AverageLineRenderer():void
{
super();

// Add the label
_label = new Label();
addChild(_label);
_label.setStyle("color",0x000000);
}

public function get data():Object
{
return _chartItem;
}

public function set data(value:Object):void
{
if(value is ColumnSeriesItem)
{
_chartItem = value as ColumnSeriesItem;

if(_chartItem != null)
{
// Assigns the yValue to the label
if (ColumnSeriesItem(_chartItem).yValue!=null)
_label.text = "Average: " + ColumnSeriesItem(_chartItem).yValue.toString();
else
_label.text="";
}
}
}

override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
{

// Do it only for the first chartItem
if ( _chartItem.index == 0) 
{
super.updateDisplayList(unscaledWidth, unscaledHeight);

var g:Graphics = graphics;
g.clear();
g.beginFill(0xFF0000); // Red line, you can select your own color
// Draw the line across the chart. This is actually a rectangle with height 1.

//g.drawRect(-20,0,this.parent.width+20, 1);

g.drawRect(-100,0,this.parent.width+100, 1);
g.endFill();
//Place the label
_label.setActualSize(_label.getExplicitOrMeasuredWidth(),_label.getExplicitOrMeasuredHeight());
_label.move(unscaledWidth ,-15);
}

}
}
}