/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 8:17 PM
 */
package {
import flash.geom.Point;

public class Cell implements ICell {
    public var color:uint;

    private var _x:int;
    private var _y:int;

    public function Cell(x:int,  y:int) {
        _x = x;
        _y = y;
    }

    public function get x():int {
        return _x;
    }

    public function get y():int {
        return _y;
    }


    public function toString():String {
        return new Point(x, y).toString();
    }
}
}
