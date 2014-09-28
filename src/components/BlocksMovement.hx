package components;
import Component;

class BlocksMovement implements Component {
	public var tag(default,null) : ComponentTag;

	private function new() {
		tag = ComponentTag.BlocksMovement;
	}

	public static var theInstance(default,null) : BlocksMovement = new BlocksMovement();
}