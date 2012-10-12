/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 8:16 PM
 */
package {
import ru.gotoandstop.math.Calculate;

public class RandomCellBuilder implements ICellBuilder {
    public function RandomCellBuilder() {
    }

    public function createCell(x:int, y:int):ICell {
        var cell:Cell = new Cell(x, y);
        cell.color = 0xff000000 | Calculate.random(0, 1000000, true);
        return cell;
    }
}
}
