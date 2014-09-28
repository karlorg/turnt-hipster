package backendjs;

class Screen implements DrawingSurface {

	var canvas : js.html.CanvasElement;
	var ctx : js.html.CanvasRenderingContext2D;
	var resizeCallbacks : Array<Int -> Int -> Void>;

    private function new() {
		canvas = cast js.Browser.document.getElementById('main-canvas');
		ctx = canvas.getContext('2d');
		resizeCallbacks = [];
	}

	static var instance : Null<Screen> = null;

	static public function getInstance() : Screen {
		if (instance == null) {
			instance = new Screen();
		}
		return instance;
	}

	/*
	  Get the current screen width in pixels.
	 */
	public function getWidth() : Int {
		return canvas.width;
	}

	/*
	  Get the current screen height in pixels.
	 */
	public function getHeight() : Int {
		return canvas.height;
	}

	/*
	  Register a callback for screen resize events.

	  Callback will be passed the new width and height in pixels.
	 */
	public function registerResizeCallback(cb: Int -> Int -> Void) : Void {
		// actually we don't ever call this yet.  Maybe later the canvas will be
		// auto-resized to fit the window, in which case we'll need this.
		resizeCallbacks.push(cb);
	}

	public function removeResizeCallback(cb: Int -> Int -> Void) : Void {
		var gotOne = true;
		do {
			gotOne = resizeCallbacks.remove(cb);
		} while (gotOne == true);
	}

	public function clear(color : Color) : Void {
		var red = StringTools.hex(color.red, 2);
		var green = StringTools.hex(color.green, 2);
		var blue = StringTools.hex(color.blue, 2);
		ctx.fillStyle = "#" + red + green + blue;
		ctx.fillRect(0, 0, getWidth(), getHeight());
	}

	public function fill(
		color : Color,
		left : Int, top : Int, width : Int, height : Int) : Void {
		var red = StringTools.hex(color.red, 2);
		var green = StringTools.hex(color.green, 2);
		var blue = StringTools.hex(color.blue, 2);
		ctx.fillStyle = "#" + red + green + blue;
		ctx.fillRect(left, top, width, height);
	}

	public function blit(
		image : Image,
		sx : Int, sy : Int, sw : Int, sh : Int,
		dx : Int, dy : Int, ?dw : Int, ?dh : Int) : Void {
		ctx.drawImage(
			image.element, sx, sy, sw, sh, dx, dy, dw, dh);
	}

}