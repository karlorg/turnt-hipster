package backendjs;

import js.Browser.window;
import js.Browser.navigator;

class Gamepads {

	private static var pads : Array<Dynamic> = [];

	public static inline function setup() : Void {
		window.addEventListener("gamepadconnected", Gamepads.connectHandler);
		window.addEventListener(
			"gamepaddisconnected", Gamepads.disconnectHandler);
	}

	private static function connectHandler(e : Dynamic) : Void {
		pads[e.gamepad.index] = e.gamepad;
	}

	private static function disconnectHandler(e : Dynamic) : Void {
		pads.remove(e.gamepad);
	}

	public static inline function isConnected() : Bool {
		return (pads.length > 0);
	}

	public static function getState(index : Int) : GamepadState {
		if (!isConnected()) {
			throw "no gamepads connected!";
		}
		// var pad : Dynamic = null;
		// var index : Int = 0;
		// do {
		// 	pad = pads[index++];
		// } while (pad.id == null);
		return new GamepadState(navigator.getGamepads()[index]);
	}
}
