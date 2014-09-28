package backendjs;

/*
  The abstract base class for all displayable images.

  Outside of this module, treat this interface as a complete black box.

  Users within this module can access the field `element` which is an HTML Image
  element.
 */
interface Image {
	@:allow(backendjs) public var element(null,null) : Null<js.html.VideoElement>;
}
