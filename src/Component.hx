enum ComponentTag {
	PlayerControlled;
	Position;
	MovesInMaze;
	DrawAsPlainSquare;
	Edible;
	BlocksMovement;
}

interface Component {
	public var tag(default,null) : ComponentTag;
}
