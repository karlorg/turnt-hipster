class Entity {
	public var id : Int;
	public var components : List<Component>;

	static private var nextId : Int = 0;

	public function new() {
		id = nextId++;
		components = new List();
	}

	public function hasComponent(tag : Component.ComponentTag) : Bool {
		for (comp in components) {
			if (comp.tag == tag) {
				return true;
			}
		}
		return false;
	}
}