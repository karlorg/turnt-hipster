package components;
import Component;

class Position implements Component {
	public var tag(default,null) : ComponentTag;

	public var x : Float;
	public var y : Float;

	public function new(x_ : Float, y_ : Float) {
		tag = ComponentTag.Position;
		x = x_;
		y = y_;
	}
}