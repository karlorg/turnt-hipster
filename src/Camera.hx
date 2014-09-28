import backend.Screen;

class Camera implements DrawingSurface {
	var screen : Screen;
	var left : Float;
	var top : Float;
	var scale : Float;

	public function new(screen : Screen) {
		this.screen = screen;
		left = 0.0; top = 0.0; scale = 1.0;
	}

	/*
	  Centre (`x`,`y`) on screen and set width shown to `w`.

	  If the screen's aspect ratio changes you'll have to call lookAt again to
	  update the camera.  It may be easiest to just call this once per frame
	  regardless of whether the camera has moved.
	*/
	public inline function lookAt(x : Float, y : Float, w : Float) : Void {
		var width = if (w==0) 0.1; else w;
		this.scale = this.screen.getWidth() / width;
		this.left = x - width / 2;
		this.top = y - this.screen.getHeight() / (this.scale * 2);
	}

	public function clear(color : Color) : Void {
		screen.clear(color);
	}

	public function blit(
		image : backend.Image,
		sx : Int, sy : Int, sw : Int, sh : Int,
		dx : Int, dy : Int, ?dw : Int, ?dh : Int) : Void {
		screen.blit(
			image, sx, sy, sw, sh,
			doX(dx), doY(dy),
			if (dw != null) { scaleX(dw); } else { null; },
			if (dh != null) { scaleY(dh); } else { null; });
	}

	/*
	  Transform map coord `x` to screen coord.
	*/
	private inline function doX(x : Float) : Int {
		return cast( (x - left) * scale );
	}

	/*
	  Transform map coord `y` to screen coord.
	*/
	private inline function doY(y : Float) : Int {
		return cast( (y - top) * scale );
	}

	private inline function scaleX(x : Float) : Int {
		return cast(x * scale);
	}

	private inline function scaleY(y : Float) : Int {
		return cast(y * scale);
	}

}