/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 8:33 PM
 */
package {
public class GridWorld extends InfiniteGrid {
    public var objects:Vector.<IWorldObject> = new Vector.<IWorldObject>();

    public function GridWorld(builder:ICellBuilder) {
        super(builder);
    }

    public function putObject(x:uint, y:uint, object:IWorldObject):void{
        var c:ICell = cell(x, y);
        object.cell = c;
        objects.push(object);
    }

    public function getCellsAroundObject(object:IWorldObject, adjacentCells:uint = 1):Vector.<ICell> {
        var min_x:int = object.cell.x - adjacentCells;
        var max_x:int = object.cell.x + adjacentCells;
        var min_y:int = object.cell.y - adjacentCells;
        var max_y:int = object.cell.y + adjacentCells;

        var list:Vector.<ICell> = new Vector.<ICell>();
        for(var x:int = min_x; x<max_x; x++) {
            for(var y:int = min_y; y<max_y; y++) {
                list.push(cell(x, y));
            }
        }
        return list;
    }
}
}
