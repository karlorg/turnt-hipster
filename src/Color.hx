class Color {
	public var red(default,null) : Int;
	public var green(default,null) : Int;
	public var blue(default,null) : Int;

	/*
	  Create a color from RGB values from 0--255.
	 */
	public function new(r : Int, g : Int, b : Int) {
		red   = Util.clampInt(r, 0, 255);
		green = Util.clampInt(g, 0, 255);
		blue  = Util.clampInt(b, 0, 255);
	}

    public static var black(default,null) = new Color(0,0,0);
}