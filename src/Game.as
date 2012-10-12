package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

import ru.gotoandstop.math.Calculate;

import ru.gotoandstop.ui.ScreenElement;

//[SWF(width=1280, height=800, frameRate=100, backgroundColor=0x000000)]
[SWF(width=500, height=500, frameRate=30)]

public class Game extends ScreenElement{
    public var grid:GridWorld;
    public var hero:IHero;
    public var canvas:BitmapData;
    public var canvas2:BitmapData;
    public var cellSize:uint = 10;
    public var cellMargin:uint = 1;

    public function Game() {
    }

    override protected function onStage():void {
        super.onStage();
        setBasicStageLayout();

        hero = new Hero();

        grid = new GridWorld(new RandomCellBuilder());
        grid.putObject(100, 100, hero);

        var s:uint = 500;

        canvas = new BitmapData(s, s, true, 0x00000000);
        canvas2 = new BitmapData(s, s, true, 0x00000000);
        push(new Bitmap(canvas));
        push(new Bitmap(canvas2), {x:s+1});

        enableLoop();
//        loop();
    }

    override protected function loop():void {
        var cellx:int = mouseX / (cellSize + cellMargin);
        var celly:int = mouseY / (cellSize + cellMargin);
        hero.cell = grid.cell(cellx, celly);

        canvas.fillRect(canvas.rect, 0xff000000);
        var list:Vector.<ICell> = grid.getCellsAroundObject(hero, hero.visibility);
        for each(var cell:ICell in list) {
            var rect:Rectangle = new Rectangle(0, 0, cellSize, cellSize);
            rect.x = cell.x * (cellSize+cellMargin);
            rect.y = cell.y * (cellSize+cellMargin);
            canvas.fillRect(rect, (cell as Cell).color);
        }

        canvas2.fillRect(canvas2.rect, 0xff000000);
        grid.forEach(c2);
    }

    private function c2(cell:ICell):void{
        var rect:Rectangle = new Rectangle(0, 0, cellSize, cellSize);
        rect.x = cell.x * (cellSize+cellMargin);
        rect.y = cell.y * (cellSize+cellMargin);
        canvas2.fillRect(rect, (cell as Cell).color);
    }
}
}
