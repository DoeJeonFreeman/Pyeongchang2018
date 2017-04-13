// ActionScript file
package asset.DFS.STN_NPPM.meteogram.itmRenerer
{
	import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import mx.charts.ChartItem;
    import mx.charts.chartClasses.ChartBase;
    import mx.charts.chartClasses.GraphicsUtilities;
    import mx.core.IDataRenderer;
    import mx.core.UIComponent;
    import mx.graphics.GradientEntry;
    import mx.graphics.IFill;
    import mx.graphics.LinearGradient;
    import mx.graphics.SolidColor;
    import mx.utils.ColorUtil;
    
    
    public class ColumnSeries3D extends UIComponent implements IDataRenderer
    {
        private var _data:Object = null;
        
        private var _sizeLimit:Number = 50;
        private var _zSize:Number = NaN;
        
        public function ColumnSeries3D()
        {
            super();
        }
        
        public function get data():Object
        {
            return _data;
        }
        
        public function set data( value:Object ):void
        {
            if( this._data != value )
            {
                _data = value;
            }
        }
        
        public function get sizeLimit():Number
        {
            return this._sizeLimit;
        }
        
        public function set sizeLimit( value:Number ):void
        {
            if( this._sizeLimit != value )
            {
                this._sizeLimit = value;
                this.invalidateDisplayList();
            }
        }
        
        
        public function get zSize():Number
        {
            return this._zSize;
        }
        
        public function set zSize( value:Number ):void
        {
            if( this._zSize != value )
            {
                this._zSize = value;
                this.invalidateDisplayList();
            }
        }
        
        private function findParentChart( obj:DisplayObject ):ChartBase
        {
            if( obj == null || obj.parent == null )
                return null;
            
            if( obj.parent is ChartBase )
                return ChartBase( obj.parent );
            
            return findParentChart( obj.parent );
        }
        
        protected override function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
        {
            super.updateDisplayList( unscaledWidth, unscaledHeight );
            
            this.graphics.clear();
            
            //Stack 타입인 경우에는 z index를 바꾸어야 하기 때문에 필요
            var chart:ChartBase = findParentChart( this );
            var seriesIndex:int = -1;
            if( chart != null )
            {
                var series:Array = chart.series as Array;
                
                for( var i:int = 0; i < series.length; i++ )
                {
                    if( series[i] == this._data.element )
                        seriesIndex = i;
                }
            }
            
            var fill:IFill;
            if( _data is ChartItem && _data.hasOwnProperty('fill') )
                fill = _data.fill;
            else
                fill = GraphicsUtilities.fillFromStyle(getStyle('fill'));
            
            var color:uint = GraphicsUtilities.colorFromFill(fill);
            
            var xx:Number = 0;
            var yy:Number = 0;
            var ww:Number = unscaledWidth;
            var hh:Number = unscaledHeight;
            
            if( isNaN( this._sizeLimit ) == false )
            {
                var sl:Number = Math.abs( this._sizeLimit );
                if( ww > sl )
                {
                    xx = ( ww - sl ) / 2;
                    ww = sl;
                }
            }
            
            var sx:Number = ww * 0.3;
            var sy:Number = ww * 0.3;
            
            if( isNaN( this._zSize ) == false )
            {
                var zs:Number = Math.abs( this._zSize );
                sx = zs;
                sy = zs;
            }
            
            if( hh == 0 )
            {
                return;
            }
            
            //var sc:SolidColor = new SolidColor( color );
            var sc2:SolidColor = new SolidColor( ColorUtil.adjustBrightness2( color, 40 ) );
            var sc3:SolidColor = new SolidColor( ColorUtil.adjustBrightness2( color, -20 ) );
            
            var lg:LinearGradient = new LinearGradient();
            lg.entries = [
                new GradientEntry( ColorUtil.adjustBrightness2( color, -10 ) ),
                new GradientEntry( ColorUtil.adjustBrightness2( color, 40 ), 0.6 ),
                new GradientEntry( ColorUtil.adjustBrightness2( color, 70 ) ) ];
            
            var rc:Rectangle;
            
            this.graphics.lineStyle();
            
            if( hh < 0 )
            {
                yy = hh;
                hh = Math.abs( hh );
            }
            
            rc = new Rectangle( xx, yy, ww, hh );
            lg.begin( this.graphics, rc);
            this.graphics.drawRect( rc.left, rc.top, rc.width, rc.height );
            lg.end( this.graphics );
            
            rc = new Rectangle( xx, yy - sy, ww + sx, sy );
            sc2.begin( this.graphics, rc);
            this.graphics.moveTo( rc.left, rc.top + sy );
            this.graphics.lineTo( rc.left + sx, rc.top );
            this.graphics.lineTo( rc.right, rc.top );
            this.graphics.lineTo( rc.right - sx, rc.bottom );
            sc2.end( this.graphics );
            
            rc = new Rectangle( xx + ww, yy - sy, sx, hh + sy );
            sc3.begin( this.graphics, rc);
            this.graphics.moveTo( rc.left, rc.top + sy );
            this.graphics.lineTo( rc.right, rc.top );
            this.graphics.lineTo( rc.right, rc.bottom - sy );
            this.graphics.lineTo( rc.left, rc.bottom );
            sc3.end( this.graphics );
            
            //Stack 타입인 경우에는 z index를 바꾸어야 하기 때문에 필요
            if( chart != null && chart.hasOwnProperty( "type" ) && Object( chart ).type == "stacked" )
            {
                this.parent.parent.setChildIndex( this.parent, seriesIndex );
            }
        }
    }
}