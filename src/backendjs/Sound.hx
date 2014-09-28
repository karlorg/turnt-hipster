package backendjs;

/*
  The abstract base class for all playable sounds.

  Outside of this module, treat this interface as a complete black box.

  Users within this module can access the field `element` which is an HTML Audio
  element.
 */
interface Sound {
	@:allow(backendjs) public var element(null,null) : Null<js.html.AudioElement>;
	public function play() : Void;
}
