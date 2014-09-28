import backend.Hooks;

import Component;
import components.DrawAsPlainSquare;
import components.Position;
import components.PlayerControlled;
import systems.DrawSystem;
import systems.PlayerControlSystem;

class Main {
	static function main() {
		Hooks.onReady(function() { Main.init(); });
	}

	static var playerControlSystem = new PlayerControlSystem();
	static var drawSystem : Null<DrawSystem> = null;
	static var dotSound : Null<backend.Sound> = null;

	static function init() : Void {
		backend.Gamepads.setup();
		backend.Keyboard.setup();
		Game.map = new GameMap(GameMap.basicMap, 8);
		var player = new Entity();
		player.components.add(new PlayerControlled());
		// player.components.add(new MovesInMaze(3.5));
		player.components.add(new DrawAsPlainSquare(
			playerColor, 1.0, 1.0));
		player.components.add(new Position(Game.map.playerX, Game.map.playerY));
		Game.entities.add(player);
		drawSystem = new DrawSystem();
		dotSound = new backend.SoundFile("sounds/dot.wav");
		Hooks.eachFrame(Main.frame);
	}

	static private var playerColor = new Color(255, 255, 30);

	static private var lastFrameTime : Float = 0.0;

	static function frame() : Void {
		if (lastFrameTime < 1.0) {
			lastFrameTime = haxe.Timer.stamp();
			return;
		}
		var timeNow = haxe.Timer.stamp();
		var elapsed = timeNow - lastFrameTime;
		if (elapsed > 0.2) { elapsed = 0.2; }
		lastFrameTime = timeNow;

		playerControlSystem.update(elapsed);
		drawSystem.update(elapsed);
	}

}
