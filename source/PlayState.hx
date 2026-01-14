package;

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
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
