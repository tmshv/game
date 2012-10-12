/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 8:22 PM
 */
package {
import flash.events.IEventDispatcher;

public interface IHero extends IEventDispatcher, IWorldObject{
    function get visibility():uint;
}
}
