package asset.DFS.STN_NPPM.meteogram.itmRenerer
{
	 import mx.core.IDataRenderer;
    import mx.core.UIComponent;
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import mx.charts.ChartItem;
    import mx.graphics.LinearGradient;
    import mx.graphics.GradientEntry;
    import mx.graphics.Stroke;

    import flash.display.*;
    import flash.text.TextField;    
    import flash.text.TextFormat;
    import flash.text.Font;

        
    import mx.charts.ColumnChart;
    import mx.charts.chartClasses.LegendData;
    import mx.charts.chartClasses.IChartElement;
    import mx.charts.series.items.PlotSeriesItem;



    public class AnnotatedCircleItemRenderer extends UIComponent implements IDataRenderer
    {

        public function AnnotatedCircleItemRenderer():void
        {
            super();
        }

        private var _plotseriesItem:PlotSeriesItem;
    
        public function set data(value:Object):void
        {
              // setData also is executed if there is a Legend Data 
              //defined for the chart. We validate that only chartItems are 
              //assigned to the chartItem class. 
            if (value is LegendData) 
                return;
            
            this.toolTip = value.item.@txt.toString();
            _plotseriesItem = new PlotSeriesItem(value.element,value.item,value.index);
        }    
        public function get data():Object
        {
            return _plotseriesItem;
        }
                                                
        override protected function 
        updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            var circle:Shape = new Shape();
            var xPos:Number = width/2;
            var yPos:Number = height/2;
            var radius:Number = width/2 - 1;

            while (this.numChildren > 0)
            {
                this.removeChildAt(0);
            }
            
            var s:Stroke = new Stroke(0x001100,2);
                s.alpha = .5;
                s.color = 0xFFFFFF;
                s.apply(circle.graphics);

            circle.graphics.clear();
            circle.graphics.beginFill(0xFF0000);
            circle.graphics.drawCircle(xPos, yPos, radius);
            circle.graphics.endFill();
            this.addChild(circle);

            var format1:TextFormat = new TextFormat();
            format1.font = "Arial";
            format1.color = 0xFFFFFF;
            format1.size = 14;

            var myTextField2:TextField = new TextField();
            myTextField2.text = _plotseriesItem.item.@txt.toString();
            myTextField2.background = false;
            myTextField2.width = width;
            myTextField2.height= height;
            myTextField2.setTextFormat(format1);
            myTextField2.rotation=0;

            myTextField2.x = 3;
            myTextField2.y = 3;
            this.addChild(myTextField2);
          }
    }
}