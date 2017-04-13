package asset.DFS.STN_NPPM.meteogram.itmRenerer
{
import mx.charts.ChartItem;
import mx.charts.chartClasses.LegendData;
import mx.charts.series.items.LineSeriesItem;
import mx.controls.Label;
import mx.core.IDataRenderer;
import mx.core.UIComponent;
import mx.graphics.SolidColor;

public class LabeledRenderer2 extends UIComponent implements IDataRenderer
{
    private var _label:Label;
    
    //doe
 	public var solidColor:SolidColor = new SolidColor(0xFF0000);   
 	//doe
 	
    public function LabeledRenderer2():void
    {
        super();
        _label = new Label();
        addChild(_label);
        _label.setStyle("color",0xFFFFFF);        
    }
    private var _chartItem:ChartItem;

    public function get data():Object
    {
        return _chartItem;
    }

    public function set data(value:Object):void
    {
    // setData also is executed if there is a Legend Data 
   //defined for the chart. We validate that only chartItems are 
   //assigned to the chartItem class. 
   //와 대박 legendData가 얘 계속 호출하면서 캐스팅 에러 났었는데ㅋㅋㅋㅋㅋㅋㅋㅋㅋ
        if (value is LegendData) 
                return;
                
        if (_chartItem == value)
            return;
        _chartItem = ChartItem(value);

        if(_chartItem != null)
            _label.text = LineSeriesItem(_chartItem).yValue.toString();
    }

    private static const fills:Array = [0xFF0000,0x00FF00,0x0000FF,
                                        0x00FFFF,0xFF00FF,0xFFFF00,
                                        0xAAFFAA,0xFFAAAA,0xAAAAFF];     
    override protected function updateDisplayList(unscaledWidth:Number,
                                                  unscaledHeight:Number):void
    {
        super.updateDisplayList(unscaledWidth, unscaledHeight);
              
        
		_label.setActualSize(_label.getExplicitOrMeasuredWidth(),_label.getExplicitOrMeasuredHeight());
//        _label.move(unscaledWidth - _label.getExplicitOrMeasuredWidth()*0.5, unscaledHeight/2 - _label.getExplicitOrMeasuredHeight()/2);
        _label.move(unscaledWidth - _label.getExplicitOrMeasuredWidth()*0.5, unscaledHeight/2 - _label.getExplicitOrMeasuredHeight()/2);
        
        //doe
//        var ls:LineSeries = _chartItem.element as LineSeries;
//        solidColor = ls.getStyle("fill");
        graphics.beginFill(solidColor.color,0.5);
//        graphics.drawRect(unscaledWidth,unscaledHeight,20,15);
         graphics.drawRect(0-10,0-4,unscaledWidth*4,unscaledHeight*1.8);
//		graphics.drawCircle(unscaledWidth-2,unscaledHeight-4,12);
        //doe
        
    }

}
}