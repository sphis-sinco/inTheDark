package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var dude:Dude;

	override public function create()
	{
		super.create();

		dude = new Dude();
		
		add(dude.flashlight);
		add(dude);
		
		dude.screenCenter();
		dude.y += dude.height * 0.65;

		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(0,0,0,Std.int(255 / 0.8))));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
