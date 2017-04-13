package asset.DFS.timeSeries.meteogram.itmRenerer
{
    import flash.display.*;
    
    import mx.core.IDataRenderer;
    import mx.skins.*;

    public class DashedLine_doe extends ProgrammaticSkin implements IDataRenderer
    {
        private var _lineSegment:Object;
        public var length:Number = 0.5;
        public var gap:Number = 0.1;
        public var lineAlpha:Number = 1;
        public var lineWeight:Number = 2;

        public function DashedLine_doe()
        {
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            _lineSegment = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function drawDashedLine(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:Object) : Object
        {
            var _loc_13:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            param1.lineStyle(lineWeight, param6, lineAlpha);
            var _loc_8:* = param4 - param2;
            var _loc_9:* = param5 - param3;
            var _loc_10:* = _loc_8;
            var _loc_11:* = _loc_9;
            var _loc_12:* = _loc_13;
            _loc_13 = Math.sqrt(_loc_10 * _loc_10 + _loc_11 * _loc_11);
            var _loc_14:Number = 0;
            var _loc_15:* = length + gap;
            var _loc_16:* = _loc_13 / _loc_15;
            _loc_10 = _loc_10 / _loc_13;
            _loc_11 = _loc_11 / _loc_13;
            var _loc_17:* = param7.mode;
            var _loc_18:* = param7.count;
            var _loc_19:int = 0;
            while (_loc_19 < _loc_13)
            {
                
                _loc_20 = _loc_10 * _loc_19 + param2;
                _loc_21 = _loc_11 * _loc_19 + param3;
                _loc_22 = _loc_20 + _loc_10;
                _loc_23 = _loc_21 + _loc_11;
                if (_loc_17)
                {
                    if (_loc_22 > param4)
                    {
                        _loc_22 = param4;
                        _loc_23 = param5;
                    }
                    param1.moveTo(_loc_20, _loc_21);
                    param1.lineTo(_loc_22, _loc_23);
                }
                _loc_18 = _loc_18 + 1;
                if (_loc_17)
                {
                    if (_loc_18 >= length)
                    {
                        _loc_17 = false;
                        _loc_18 = 0;
                    }
                }
                else if (_loc_18 >= gap)
                {
                    _loc_17 = true;
                    _loc_18 = 0;
                }
                _loc_19 = _loc_19 + 1;
            }
            param7.mode = _loc_17;
            param7.length = _loc_18;
            return param7;
        }// end function

        public function get data() : Object
        {
            return _lineSegment;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("lineStroke");
            var _loc_4:* = getStyle("form");
            graphics.clear();
            var _loc_5:* = Object(_lineSegment).items as Array;
            var _loc_10:Object = {mode:true, count:0};
            var _loc_11:int = 1;
            while (_loc_11 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[(_loc_11 - 1)].x;
                _loc_7 = _loc_5[(_loc_11 - 1)].y;
                _loc_8 = _loc_5[_loc_11].x;
                _loc_9 = _loc_5[_loc_11].y;
                _loc_10 = drawDashedLine(graphics, _loc_6, _loc_7, _loc_8, _loc_9, _loc_3.color, _loc_10);
                _loc_11 = _loc_11 + 1;
            }
            return;
        }// end function

    }
}
