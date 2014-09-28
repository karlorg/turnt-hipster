interface DrawingSurface {
	public function clear(color : Color) : Void;
	public function blit(
		image : backend.Image,
		sx : Int, sy : Int, sw : Int, sh : Int,
		dx : Int, dy : Int, ?dw : Int, ?dh : Int) : Void;
}