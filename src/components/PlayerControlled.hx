package components;
import Component;

class PlayerControlled implements Component {
	public var tag(default,null) : ComponentTag;

	public var facing : Facing;

	public function new() {
		tag = ComponentTag.PlayerControlled;
		facing = Neutral;
	}
}

enum Facing {
	Up;
	Down;
	Left;
	Right;
	Neutral;
}