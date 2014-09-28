class Util {
	public inline static function clampInt(
		value : Int, min : Int, max : Int) : Int {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}
}