package systems;

import backend.Screen;
import Component;
import components.DrawAsPlainSquare;
import components.Position;

class DrawSystem implements System {
	private var screen : Screen;

	public static inline var pixelsPerTile : Float = 30.0;
	private static var clearColor = Color.black;

	public function new() {
		screen = Screen.getInstance();
	}

	public function update(dt : Float) : Void {
		screen.clear(clearColor);
		if (Game.map != null) {
			for (entity in Game.map) {
				processEntity(entity);
			}
		}
		for (entity in Game.entities) {
			processEntity(entity);
		}
	}

	private function processEntity(entity : Entity) : Void {
		var daps : Null<DrawAsPlainSquare> = null;
		var pos : Null<Position> = null;
		for (comp in entity.components) {
			switch (comp.tag) {
				case ComponentTag.DrawAsPlainSquare:
					daps = cast comp;
				case ComponentTag.Position:
					pos = cast comp;
				default:
			}
		}
		if (daps != null && pos != null) {
			screen.fill(
				daps.color,
				Std.int((pos.x + 0.5 - daps.w * 0.5) * pixelsPerTile),
				Std.int((pos.y + 0.5 - daps.w * 0.5) * pixelsPerTile),
				Std.int(daps.w * pixelsPerTile),
				Std.int(daps.h * pixelsPerTile));
		}
	}

}