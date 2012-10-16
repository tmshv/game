package game.dijkstra {
import flash.geom.Point;

public class Dijkstra {
	// Checks if a given array contains the object specified.
	private static function hasElement(a:Vector.<DijkstraNode>, e:DijkstraNode):Boolean {
		for (var i:int = 0; i < a.length; ++i) {
			if (a[i] == e) return true;
		}
		return false;
	}

	// Remove an element from an array
	private static function removeFromArray(a:Array, e:Object):Boolean {
		for (var i:int = 0; i < a.length; i++) {
			if (a[i] == e) {
				a.splice(i, 1);
				return true;
			}
		}
		return false;
	}

	// The dimensions of the entire map
	private var width:int;
	private var height:int;

	private var _start:DijkstraNode;				// Our start node
	private var _map:Vector.<DijkstraNode>;		// must be two-dimensional array containing AStarNodes;
	public var _opened:Vector.<DijkstraNode>;		// open set: nodes to be considered
	public var _closed:Vector.<DijkstraNode>;	// closed set: nodes not to consider anymore

	public function Dijkstra(width:int, height:int) {
		this.width = width;
		this.height = height;

		_map = new Vector.<DijkstraNode>(width * height, true);
		_opened = new Vector.<DijkstraNode>();
		_closed = new Vector.<DijkstraNode>();

		for (var x:int = 0; x < width; x++) {
			for (var y:int = 0; y < height; y++) {
				_map[x * height + y] = new DijkstraNode(x, y);
			}
		}
	}

	public function setWalkable(x:int, y:int, walkable:Boolean):void {
		if (isNotOutOfBounds(x, y)) _map[x * height + y].walkable = walkable;
		else throw new ArgumentError('cell is out of bounds');
	}

	public function isWalkable(x:int, y:int):Boolean {
		if (isNotOutOfBounds(x, y)) {
			return _map[x * height + y].walkable;
		} else {
			throw new ArgumentError('cell is out of bounds');
		}
	}

	public function getWalkable(targetCell:Point, direction:String = "-1", myCell:Point = null):Point {
		var targetX:int = targetCell.x;
		var targetY:int = targetCell.y;
		if (isNotOutOfBounds(targetX, targetY)) {
			var node:DijkstraNode = new DijkstraNode(targetX, targetY);
			var all_neighbors:Vector.<DijkstraNode> = allNeighbors(node);
			var dir:String = direction;
			var neighborCell:Point;

			if (dir != "-1") {
				neighborCell = getNeighborCell(dir, all_neighbors);
			} else if (myCell) {
				var dX:int = myCell.x - targetCell.x;
				var dY:int = myCell.y - targetCell.y;
				var dir1:String;
				var dir2:String;
				var dirAdd:String;

				// задаем две точки у цели
				if (dX >= 0) dir1 = "180";
				else dir1 = "0";

				if (dY >= 0) dir2 = "90";
				else dir2 = "270";

				if (Math.abs(dX) >= Math.abs(dY)) {
					dir = dir1;
					dirAdd = dir2;
				} else {
					dir = dir2;
					dirAdd = dir1;
				}
				neighborCell = getNeighborCell(dir, all_neighbors, dirAdd);
			} else {
				neighborCell = null;
			}
			return neighborCell;
		} else {
			throw new ArgumentError('cell is out of bounds');
		}
	}

	public function solve(limit:int, aStart:Point):Vector.<DijkstraNode> {
		_start = new DijkstraNode(aStart.x, aStart.y);
		_opened.length = 0;
		_closed.length = 0;

		_opened.push(_start);
		_start.parent = null;

		while (_opened.length > 0) {
			var node:DijkstraNode = _opened.shift();
			_closed.push(node);
			if (node.cost < limit) {
				for each(var n:DijkstraNode in neighbors(node)) {
					var newCost:int = node.cost + 1; // 1 - cost

					if (n.cost == -1 || newCost < n.cost) {
						n.cost = newCost;
						if (!hasElement(_opened, n)) {
							_opened.push(n);
							n.parent = node;
						}
					}
				}
			}
		}

		var results:Vector.<DijkstraNode> = new Vector.<DijkstraNode>();

		for (var i:int = 0; i < _closed.length; ++i) {
			var nn:DijkstraNode = _closed[i];
			if (nn.cost < limit)
				results.push(nn);

			nn.cost = -1;
		}

		//		for (var ii:int = 0; ii < width * height; ++ii)
		//			assert(mMap[ii].cost == -1);

		return results;
	}

	// Return a node's neighbors, IF they're walkable
	private function neighbors(node:DijkstraNode):Vector.<DijkstraNode> {
		var x:int = node.x;
		var y:int = node.y;
		var n:DijkstraNode;
		var a:Vector.<DijkstraNode> = new Vector.<DijkstraNode>();

		// W
		if (x > 0) {
			n = _map[(x - 1) * height + y];
			if (n.walkable)
				a.push(n);
		}

		// E
		if (x < width - 1) {
			n = _map[(x + 1) * height + y];
			if (n.walkable)
				a.push(n);
		}

		// N
		if (y > 0) {
			n = _map[x * height + y - 1];
			if (n.walkable)
				a.push(n);
		}

		// S
		if (y < height - 1) {
			n = _map[x * height + y + 1];
			if (n.walkable)
				a.push(n);
		}

		return a;
	}

	// Return a node's neighbors
	private function allNeighbors(node:DijkstraNode):Vector.<DijkstraNode> {
		var x:int = node.x;
		var y:int = node.y;
		var n:DijkstraNode;
		var a:Vector.<DijkstraNode> = new Vector.<DijkstraNode>;

		// N
		if (x > 0) {
			n = _map[(x - 1) * height + y];
			if (n.walkable)
				a.push(n);
			else
				a.push(null);
		}
		else
			a.push(null);
		// S
		if (x < width - 1) {
			n = _map[(x + 1) * height + y];
			if (n.walkable)
				a.push(n);
			else
				a.push(null);
		}
		else
			a.push(null);
		// W
		if (y > 0) {
			n = _map[x * height + y - 1];
			if (n.walkable)
				a.push(n);
			else
				a.push(null);
		}
		else
			a.push(null);
		// E
		if (y < height - 1) {
			n = _map[x * height + y + 1];
			if (n.walkable)
				a.push(n);
			else
				a.push(null);
		}
		else
			a.push(null);

		return a;
	}

	private function getNeighborCell(dir:String, allNeighbors:Vector.<DijkstraNode>, dirAdd:String = ""):Point {
		var limit:uint = 0;
		while (limit < 4) {
			switch (dir) {
				case "0":
					if (allNeighbors[0]) {
						return new Point(allNeighbors[0].x, allNeighbors[0].y);
					}
					else {
						if (dirAdd != "")
							dir = dirAdd;
						else
							dir = "90";
						limit++;
					}
					break;
				case "90":
					if (allNeighbors[3]) {
						return new Point(allNeighbors[3].x, allNeighbors[3].y);
					}
					else {
						if (dirAdd != "")
							dir = dirAdd;
						else
							dir = "180";
						limit++;
					}
					break;
				case "180":
					if (allNeighbors[1]) {
						return new Point(allNeighbors[1].x, allNeighbors[1].y);
					}
					else {
						if (dirAdd != "")
							dir = dirAdd;
						else
							dir = "270";
						limit++;
					}
					break;
				case "270":
					if (allNeighbors[2]) {
						return new Point(allNeighbors[2].x, allNeighbors[2].y);
					}
					else {
						if (dirAdd != "")
							dir = dirAdd;
						else
							dir = "0";
						limit++;
					}
					break;
			}
		}
		return null;
	}

	private function isNotOutOfBounds(x:int, y:int):Boolean {
		return x >= 0 && x < width && y >= 0 && y < height;
	}
}
}