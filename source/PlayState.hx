package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var dude:Dude;
	public var overlay:FlxSprite;

	override public function create()
	{
		super.create();

		dude = new Dude();
		
		add(dude.flashlight);
		add(dude);
		
		dude.screenCenter();
		dude.y += dude.height * 0.65;

		overlay = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		overlay.alpha = 0.8;
		add(overlay);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		#if debug
		if (FlxG.keys.justReleased.R)
			overlay.alpha = (overlay.alpha == 0.8) ? 0.2 : 0.8; 
		#end
	}
}
