package backendjs;

import js.Browser.window;

class Hooks {

	private static var rAFid : Null<Int> = null;

	/* Setup the backend and set a ready-callback.

	   You must call this method to signal the backend to do whatever
	   preparation is necessary.
	 */
	public static inline function onReady(cb : Void -> Void) : Void {
		window.onload = cast cb;
	}

	public static function eachFrame(cb: Void -> Void) : Void {
		var theFunc : Null<Void -> Void> = null;
		var rAFFunc : js.html.RequestAnimationFrameCallback = function(e) {
			theFunc();
			return true;
		}
		theFunc = function () {
			cb();
			rAFid = window.requestAnimationFrame(rAFFunc);
		}
		rAFid = window.requestAnimationFrame(rAFFunc);
	}

	public static inline function stopFrames() : Void {
		if (rAFid != null) {
			window.cancelAnimationFrame(rAFid);
			rAFid = null;
		};
	}
}