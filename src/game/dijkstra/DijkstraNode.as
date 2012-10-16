package game.dijkstra {
import flash.geom.Point;

public class DijkstraNode extends Point {
	public var cost:Number = -1;
	public var parent:DijkstraNode; // Needed to return a solution (trackback)
	public var walkable:Boolean; 	// Taken from the original tile

	function DijkstraNode(x:int, y:int, walkable:Boolean = true) {
		super(x, y);
		this.walkable = walkable;
	}
}
}