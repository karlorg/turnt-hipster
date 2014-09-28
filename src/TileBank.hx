import TileDefinitions.SimpleTileDefinition;

class TileBank {

	static var tiles : Map<String,Tile> = new Map();

	public static function getTile(name : String) : Tile {
		if (!tiles.exists(name)) {
			throw 'tile $name missing from tileset';
		}
		return tiles.get(name);
	}

	/*
	  Create tiles from a definitions object.

	  This is likely to trigger image loading, so be sure and wait for the
	  ImageBank to be ready before attempting to use any tiles.
	 */
	public static function loadSimpleDefinitions(
		definitions : Array<SimpleTileDefinition>) : Void {
		for (d in definitions) {
			tiles.set(d.name, new Tile.SimpleTile(
				ImageBank.addImage(d.file),
				d.draw_bounds.left,
				d.draw_bounds.top,
				d.draw_bounds.right,
				d.draw_bounds.bottom,
				d.surface_bounds.left,
				d.surface_bounds.top,
				d.surface_bounds.right,
				d.surface_bounds.bottom));
		}
	}

}
