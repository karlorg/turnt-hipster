typedef SimpleTileDefinition = {
	name : String,
	file : String,
	draw_bounds : {
		left : Int, top : Int, right : Int, bottom : Int },
	surface_bounds : {
		left : Int, top : Int, right : Int, bottom : Int },
};

class TileDefinitions {
	public static var aspectRatio = 83 / 101;

	public static var simpleDefinitions : Array<SimpleTileDefinition> = [
		{
			"name": "grass",
			"file": "images/grass.png",
			"draw_bounds": { "left": 0, "top": 0, "right": 8, "bottom": 8 },
			"surface_bounds": { "left": 0, "top": 0, "right": 8, "bottom": 8 } }

	];
}
