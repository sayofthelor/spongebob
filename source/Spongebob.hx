package;

import flixel.addons.plugin.FlxMouseControl;
import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;

class Spongebob extends openfl.display.Sprite {
	public function new():Void {
		super();
		addChild(new flixel.FlxGame(0, 0, SpongeState));
	}
}

class SpongeState extends flixel.FlxState {
	var sponge:FlxExtendedSprite;
	override public function create():Void {
		super.create();
		FlxG.sound.playMusic("assets/music.ogg", 1, true);
		FlxG.plugins.add(new FlxMouseControl());
		sponge = new FlxExtendedSprite(0, 0, "assets/bob.png");
		FlxMouseControl.addToStack(sponge);
		sponge.enableMouseClicks(false, true);
		sponge.mousePressedCallback = handleMousePress;
		sponge.setGraphicSize(500, 500);
		sponge.screenCenter();
		add(sponge);
	}

	var bobbing:Bool = false;

	function handleMousePress(s, x, y) {
		if (!bobbing) {
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
