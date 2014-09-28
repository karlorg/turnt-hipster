package backendjs;

class GamepadState {
	private var pad : js.html.Gamepad;

	@:allow(backendjs) private function new(_pad : js.html.Gamepad) {
		pad = _pad;
	}

	public inline function numAxes() : Int {
		return pad.axes.length;
	}

	public inline function axis(index : Int) : Float {
		return pad.axes[index];
	}		
}
