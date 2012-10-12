/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 8:23 PM
 */
package {
import flash.events.EventDispatcher;

public class Hero extends EventDispatcher implements IHero {
    private var _cell:ICell;

    public function Hero() {
    }

    public function get cell():ICell {
        return _cell;
    }

    public function set cell(value:ICell):void {
        _cell = value;
    }

    public function get visibility():uint {
        return 4;
    }
}
}
