/**
 *
 * User: tmshv
 * Date: 10/10/12
 * Time: 2:30 PM
 */
package {
import flash.events.EventDispatcher;

import mx.core.IFlexAsset;

public class InfiniteGrid extends EventDispatcher {
    public var cellBuilder:ICellBuilder;

    private var cells:Array = new Array();
    private var dict:Object = new Object();

    public function InfiniteGrid(builder:ICellBuilder) {
        cellBuilder = builder;
    }

    public function cell(x:int, y:int):ICell {
        var name:String = x+"_"+y;
        var cell:ICell;
        if(dict[name] == undefined) dict[name] = cellBuilder.createCell(x, y);
        return dict[name];
    }

    public function forEach(callback:Function):void{
        for each(var c:ICell in dict){
            callback(c);
        }
    }

//    public function cell(x:int, y:int):ICell {
//        var name:String = x+"_"+y;
//        var cell:ICell;
//        try {
//            cell = cells[x][y];
//        }catch(error:Error){
//            cell = cellBuilder.createCell(x, y);
//            if(cells[x] == undefined) cells[x] = new Array();
//            cells[x][y] = cell;
//        }
//        return cell;
//    }
}
}
