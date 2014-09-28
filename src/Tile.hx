import backend.Image;

/*
  A tile that can be repeatedly drawn onto a surface.

  Each tile knows how to draw itself in order to position its upper surface in a
  given position on the drawing surface.
 */
interface Tile {
	public function draw(
		surface : DrawingSurface,
		left : Int, top : Int, width : Int, height : Int) : Void;
}

class SimpleTile implements Tile {
	public var aspectRatio(default,null) : Float;

	var image : Image;
	var srcLeft : Int;
	var srcTop : Int;
	var srcWidth : Int;
	var srcHeight : Int;
	var surfLeft : Int;
	var surfTop : Int;
	var surfWidth : Int;
	var surfHeight : Int;

	@:allow(TileBank) private function new(
		image : Image,
		dbl : Int, dbt : Int, dbr : Int, dbb : Int,
		sbl : Int, sbt : Int, sbr : Int, sbb : Int) {
		this.image = image;
		srcLeft = dbl;
		srcTop = dbt;
		srcWidth = dbr - dbl;
		srcHeight = dbb - dbt;
		surfLeft = sbl;
		surfTop = sbt;
		surfWidth = sbr - sbl;
		surfHeight = sbb - sbt;
	}

	public function draw(
		surface : DrawingSurface,
		left : Int, top : Int, width : Int, height : Int) : Void {
		var xscale = width / surfWidth;
		var yscale = height / surfHeight;
		surface.blit(
			image,
			srcLeft, srcTop, srcWidth, srcHeight,
			Math.round(left - ((surfLeft - srcLeft) * xscale)),
			Math.round(top  - ((surfTop  - srcTop ) * yscale)),
			Math.round(srcWidth * xscale),
			Math.round(srcHeight * yscale));
	}

}
