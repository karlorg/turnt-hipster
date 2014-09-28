package backendjs;

import js.Browser.window;

class Keyboard {

	private static var states : Map<String,Bool> = new Map();

	public static inline function setup() : Void {
		for (c in "abcdefghijklmnopqrstuvwxyz".split("")) {
			states.set(c, false);
		}
		window.addEventListener("keydown", keydownHandler);
		window.addEventListener("keyup", keyupHandler);
	}

	private static function keydownHandler(e : Dynamic) : Void {
		if (e.defaultPrevented) { return; }
		states.set(e.key, true);
	}

	private static function keyupHandler(e : Dynamic) : Void {
		if (e.defaultPrevented) { return; }
		states.set(e.key, false);
	}

	public static inline function isKeyDown(key : String) : Bool {
		return states.exists(key) && states.get(key);
	}

}
