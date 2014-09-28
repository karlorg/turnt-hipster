package systems;

import backend.Keyboard.isKeyDown;

import Component;
import Component.ComponentTag;
import components.Position;
import components.PlayerControlled;
import components.PlayerControlled.Facing;

private typedef Input = {
	var x : Int;
	var y : Int;
}

class PlayerControlSystem implements System {
	public function new() {}

	public function update(dt : Float) : Void {
		var input = getInput();

		for (entity in Game.entities) {
			var pos : Null<Position> = null;
			var pc : Null<PlayerControlled> = null;
			for (comp in entity.components) {
				switch (comp.tag) {
					case ComponentTag.Position:
						pos = cast comp;
					case ComponentTag.PlayerControlled:
						pc = cast comp;
					default:
				}
			}

			// if entity is eligible
			if (pos != null && pc != null) {
				var tileX : Int = Math.round(pos.x);
				var tileY : Int = Math.round(pos.y);

				// update facing based on input
				if (input.x != 0) {
					// if vpos close enough to a grid line
					if (Math.abs(pos.y - Math.fround(pos.y)) < 0.1) {
						if (input.x > 0
						// if no wall in the way
						&& !Game.map.getTile(tileX + 1, tileY)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pc.facing = Facing.Right;
						} else if (input.x < 0
						// if no wall in the way
						&& !Game.map.getTile(tileX - 1, tileY)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pc.facing = Facing.Left;
						}
					}

				} else if (input.y != 0) {
					// if hpos close enough to a grid line
					if (Math.abs(pos.x - Math.fround(pos.x)) < 0.1) {
						if (input.y > 0
						// if no wall in the way
						&& !Game.map.getTile(tileX, tileY + 1)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pc.facing = Facing.Down;
						} else if (input.y < 0
						// if no wall in the way
						&& !Game.map.getTile(tileX, tileY - 1)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pc.facing = Facing.Up;
						}
					}
				}

				var speed = 0.1;
				// process movement based on facing
				switch (pc.facing) {
					case Facing.Right:
						pos.x += speed;
						if (Game.map.getTile(Math.floor(pos.x) + 1, tileY)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pos.x = Math.ffloor(pos.x);
						}
					case Facing.Left:
						pos.x -= speed;
						if (Game.map.getTile(Math.ceil(pos.x) - 1, tileY)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pos.x = Math.fceil(pos.x);
						}
					case Facing.Down:
						pos.y += speed;
						if (Game.map.getTile(tileX, Math.floor(pos.y) + 1)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pos.y = Math.ffloor(pos.y);
						}
					case Facing.Up:
						pos.y -= speed;
						if (Game.map.getTile(tileX, Math.ceil(pos.y) - 1)
						.hasComponent(ComponentTag.BlocksMovement)) {
							pos.y = Math.fceil(pos.y);
						}
					default:
				}

				// slide player toward nearest gridline parallel to direction
				// of travel
				if (pc.facing == Facing.Right || pc.facing == Facing.Left) {
					if (pos.y > Math.fround(pos.y)) {
						pos.y -= speed;
						if (pos.y < Math.fround(pos.y)) {
							pos.y = Math.fround(pos.y);
						}
					} else if (pos.y < Math.fround(pos.y)) {
						pos.y += speed;
						if (pos.y > Math.fround(pos.y)) {
							pos.y = Math.fround(pos.y);
						}
					}
				} else if (pc.facing == Facing.Up || pc.facing == Facing.Down) {
					if (pos.x > Math.fround(pos.x)) {
						pos.x -= speed;
						if (pos.x < Math.fround(pos.x)) {
							pos.x = Math.fround(pos.x);
						}
					} else if (pos.x < Math.fround(pos.x)) {
						pos.x += speed;
						if (pos.x > Math.fround(pos.x)) {
							pos.x = Math.fround(pos.x);
						}
					}
				}

			}
		}
	}

	private function getInput() : Input {
		var inputX : Int = 0;
		var inputY : Int = 0;
		
		if (backend.Gamepads.isConnected()) {
			var pad = backend.Gamepads.getState(0);
			var stickX = pad.axis(0);
			var stickY = pad.axis(1);
			// if stick is more than 0.2 units from center
			if (stickX * stickX + stickY * stickY > 0.2 * 0.2) {
				// move vert or horiz based on angle
				if (Math.abs(stickX) > Math.abs(stickY)) {
					// horizontal movement
					inputX = if (stickX > 0) 1 else -1;
				} else {
					// vertical movement
					inputY = if (stickY > 0) 1 else -1;
				}
			} else {
				// no significant stick movement, check d-pad
				var dpadX = pad.axis(6);
				var dpadY = pad.axis(7);
				inputX = Std.int(dpadX);
				inputY = Std.int(dpadY);
			}
		}
		
		// keypresses override gamepad
		if (isKeyDown("w")) {
			inputY = -1;
		} else if (isKeyDown("a")) {
			inputX = -1;
		} else if (isKeyDown("s")) {
			inputY = 1;
		} else if (isKeyDown("d")) {
			inputX = 1;
		}

		return { x : inputX, y : inputY };
	}
}