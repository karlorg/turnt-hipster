package backendjs;

// an image loaded from a file

class ImageFile implements Image {
	@:allow(backendjs) public var element(null,null) : Null<js.html.VideoElement> = null;

	static var pathPrefix = "assets/";

	public function new(
		filename : String, ?callback : Image -> Void) {
		var self = this;
		element = cast new js.html.Image();
		this.callback = callback;
		element.onload = function(e) { self.loaded(); };
		element.src = pathPrefix + filename;
	}

	public var isReady(default,null) : Bool = false;

	var callback : Null<Image -> Void> = null;

	// private onload handler
	function loaded() : Void {
		isReady = true;
		if (callback != null) { callback(this); };
	}
	
}