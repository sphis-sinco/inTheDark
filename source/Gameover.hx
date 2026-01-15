import flixel.util.FlxColor;
import flixel.sound.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class Gameover extends FlxState
{
	public var screenImg:FlxSprite;

	override public function new(screen:String = 'caught')
	{
		super();
		screenImg = new FlxSprite(0, 0, 'gameover/$screen'.png());
	}

	override function create()
	{
		super.create();

		add(screenImg);
		FlxG.sound.play('gameover/gore'.wav());

		FlxG.camera.flash(FlxColor.RED);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ANY)
		{
			screenImg.visible = false;
			FlxG.sound.play('gameover/laugh'.wav(), 1.0, false, null, true, function()
			{
				FlxG.switchState(() -> new PlayState());
			});
		}
	}
}
