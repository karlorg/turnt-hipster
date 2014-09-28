package components;
import Component;

class DrawAsPlainSquare implements Component {
	public var tag(default,null) : ComponentTag;

	public var color : Color;
	public var w : Float;
	public var h : Float;

	public function new(color_ : Color, w_ : Float, h_ : Float) {
		tag = ComponentTag.DrawAsPlainSquare;
		color = color_;
		w = w_;
		h = h_;
	}
}