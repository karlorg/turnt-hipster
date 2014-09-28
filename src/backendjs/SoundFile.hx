package backendjs;

// a sound loaded from a file

class SoundFile implements Sound {
	@:allow(backendjs) public var element(null,null) : Null<js.html.AudioElement> = null;

	static var pathPrefix = "assets/";

	public function new(
		filename : String, ?callback : Sound -> Void) {
		var self = this;
		element = cast new js.html.Audio();
		this.callback = callback;
		element.onload = function(e) { self.loaded(); };
		element.src = pathPrefix + filename;
	}

	public var isReady(default,null) : Bool = false;

	var callback : Null<Sound -> Void> = null;

	// private onload handler
	function loaded() : Void {
		isReady = true;
		if (callback != null) { callback(this); };
	}
	
	public function play() : Void {
		element.pause();
		element.currentTime = 0;
		element.play();
	}
}