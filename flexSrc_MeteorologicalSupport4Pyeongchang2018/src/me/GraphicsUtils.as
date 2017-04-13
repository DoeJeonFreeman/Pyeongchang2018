/*Copyright (c) 2006 Adobe Systems Incorporated

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package me {
  import mx.graphics.IStroke;
  import flash.display.Graphics;

  public class GraphicsUtils {
    public static function _drawDashedLine( target:Graphics, strokes:Array, pattern:Array,
                                            drawingState:DashStruct,
                                            x0:Number, y0:Number, x1:Number, y1:Number):void {
      var dX:Number = x1 - x0;
      var dY:Number = y1 - y0;
      var len:Number = Math.sqrt( dX * dX + dY * dY );
      dX /= len;
      dY /= len;
      var tMax:Number = len;
      var t:Number = -drawingState.offset;
      var patternIndex:int = drawingState.patternIndex;
      var strokeIndex:int = drawingState.strokeIndex;
      var styleInited:Boolean = drawingState.styleInited;

      while( t < tMax ) {
        t += pattern[patternIndex];
        if( t < 0 ) {
          var x:int = 5;
        }

        if( t >= tMax ) {
          drawingState.offset = pattern[patternIndex] - ( t - tMax );
          drawingState.patternIndex = patternIndex;
          drawingState.strokeIndex = strokeIndex;
          drawingState.styleInited = true;
          t = tMax;
        }

        if( styleInited == false ) {
          (strokes[strokeIndex] as IStroke).apply( target );
        }
        else {
          styleInited = false;
        }

        target.lineTo( x0 + t * dX, y0 + t * dY );

        patternIndex = ( patternIndex + 1 ) % pattern.length;
        strokeIndex = ( strokeIndex + 1 ) % strokes.length;
      }
    }

    public static function drawDashedLine( target:Graphics, strokes:Array, pattern:Array,
                                           x0:Number, y0:Number, x1:Number, y1:Number ):void {
      target.moveTo( x0, y0 );
      var struct:DashStruct = new DashStruct();
      _drawDashedLine( target, strokes, pattern, struct, x0, y0, x1, y1 );
    }

    public static function drawDashedPolyLine( target:Graphics, strokes:Array, pattern:Array,
                                               points:Array ):void {
      if( points.length == 0 ) { return; }
      var prev:Object = points[0];
      var struct:DashStruct = new DashStruct();

      target.moveTo( prev.x, prev.y );

      for( var i:int = 1; i < points.length; i++ ) {
        var current:Object = points[i];
        _drawDashedLine( target, strokes, pattern, struct,
                         prev.x, prev.y, current.x, current.y );
        prev = current;
      }
    }
  }
}

class DashStruct {
  public function init():void {
    patternIndex = 0;
    strokeIndex = 0;
    offset = 0;
  }
  public var patternIndex:int = 0;
  public var strokeIndex:int = 0;
  public var offset:Number = 0;
  public var styleInited:Boolean = false;
}