import Component;
import components.DrawAsPlainSquare;
import components.Position;

enum MapTile {
	Blank;
	Wall;
	Dot;
	Player;
}

class GameMap {
	// charMap is filled in by the __init__ function and is used internally
	// to map characters in ASCII representations of maps to the MapTile
	// enum above
	static private var charMap : Map<String,MapTile>;

	static function __init__() {
		charMap = new Map();
		charMap.set("#", Wall);
		charMap.set(" ", Blank);
		charMap.set(".", Dot);
		charMap.set("P", Player);
	}

	private var tiles : Array<Array<Entity>>;
	public var playerX(default,null) : Int = 0;
	public var playerY(default,null) : Int = 0;

	private static var wallColor : Color = new Color(10, 10, 255);

	public function new(data : String, width : Int) {
		tiles = [];
		var y = 0;
		while (y * width < data.length) {
			var row : Array<Entity> = [];

			// TODO: this whole thing needs to add to the tile array exactly one
			// entity per grid position so that getTile() can always return an
			// entity and because the iterator we provide assumes (internally)
			// that there are exactly x*y entities in the tile array.
			//
			// Can we redesign to avoid this requirement?  Seems fragile.

			for (x in 0...width) {
				var theTile = charMap.get(data.charAt(y*width + x));

				switch (theTile) {
					case Blank:
						row.push(makeBlank(x, y));

					case Wall:
						row.push(makeWall(x, y));

					case Dot:
						row.push(makeBlank(x, y));
						Game.entities.push(makeDot(x, y));
						// if another dot to the right or below, add 2 extra
						// dots in between us and them
						if (x < width - 1
						&& charMap.get(data.charAt(y*width + x + 1)) == Dot) {
							Game.entities.push(makeDot(x + 0.33, y));
							Game.entities.push(makeDot(x + 0.66, y));
						}
						if (y * width < data.length - 1
						&& charMap.get(data.charAt((y+1)*width + x)) == Dot) {
							Game.entities.push(makeDot(x, y + 0.33));
							Game.entities.push(makeDot(x, y + 0.66));
						}

					case Player:
						row.push(makeBlank(x, y));
						playerX = x; playerY = y;
				}
			}

			tiles.push(row);
			y += 1;
		}
	}

	private function makeBlank(x : Int, y : Int) : Entity {
		var entity = new Entity();
		entity.components.add(new Position(x, y));
		return entity;
	}

	private function makeWall(x : Int, y : Int) : Entity {
		var entity = new Entity();
		entity.components.add(new Position(x, y));
		entity.components.add(new DrawAsPlainSquare(
			wallColor, 1.0, 1.0));
		entity.components.add(components.BlocksMovement.theInstance);
		return entity;
	}
		
	private function makeDot(x : Float, y : Float) : Entity {
		var entity = new Entity();
		entity.components.add(new Position(x, y));
		entity.components.add(new DrawAsPlainSquare(
			new Color(255, 255, 30), 0.1, 0.1));
		return entity;
	}

	public function getTile(x : Int, y : Int) : Entity {
		if (y >= 0 && y < tiles.length
		&& x >= 0 && x < tiles[y].length) {
			return tiles[y][x];
		} else {
			var entity = new Entity();
			entity.components.add(new Position(x, y));
			entity.components.add(new DrawAsPlainSquare(
				wallColor, 60, 60));
			//			entity.components.add(BlocksMovement);
			return entity;
		}
	}

	public inline function getWidth() : Int {
		return tiles[0].length;
	}

	public inline function getHeight() : Int {
		return tiles.length;
	}

	public function iterator() : Iterator<Entity> {
		return new GameMapIter(this);
	}

	public static inline var basicMap = (
		"########" +
		"#......#" +
		"#.## #.#" +
		"#.#  #.#" +
		"#.# ##.#" +
		"#...P..#" +
		"########"
	);
}

@:access(GameMap) class GameMapIter {
	var map : GameMap;
	var y : Int;
	var x : Int;

	public function new(map_ : GameMap) {
		map = map_;
		y = x = 0;
	}

	public inline function hasNext() : Bool {
		return y < map.tiles.length;
	}

	public function next() : Entity {
		var result = map.tiles[y][x];
		x += 1;
		if (x >= map.tiles[0].length) {
			x = 0;
			y += 1;
		}
		return result;
	}
}
