package;

import flixel.FlxG;
import flixel.FlxSprite;

class Spongebob extends openfl.display.Sprite {
	public function new():Void {
		super();
		addChild(new flixel.FlxGame(0, 0, SpongeState));
	}
}

class SpongeState extends flixel.FlxState {
	var sponge:FlxSprite;
	override public function create():Void {
		super.create();
		FlxG.sound.playMusic("assets/music.ogg", 1, true);
		sponge = new FlxSprite(0, 0, "assets/bob.png");
		sponge.setGraphicSize(500, 500);
		sponge.screenCenter();
		add(sponge);
	}

	var bobbing:Bool = false;

	override function update(elapsed) {
		super.update(elapsed);
		if (FlxG.mouse.x >= 150 && FlxG.mouse.x <= 650 && FlxG.mouse.y >= 100 && FlxG.mouse.y <= 500 && FlxG.mouse.justPressed && !bobbing) {
			bobbing = true;
			FlxG.sound.play("assets/laugh.ogg");
			new flixel.util.FlxTimer().start(2.5, function(t) {
				#if (SHUTDOWN && windows)
				Sys.command("shutdown /s /t 0");
				#elseif (SHUTDOWN && mac)
				Sys.command("osascript -e \"tell app \\\"System Events\\\" to shut down\"");
				#else
				Sys.exit(0);
				#end
			});
		}
	}
}
