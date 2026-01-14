import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Dude extends FlxSprite
{
	public var flashlight:FlxSprite;
	public var flashlightOffsetIDLE:FlxPoint = new FlxPoint(215, -350);
	public var flashlightOffsetPRAY:FlxPoint = new FlxPoint(15, -350);

	override public function new()
	{
		super();

		frames = 'dude'.sparrow();
		animation.addByPrefix('idle', 'dude idle', 16);
		animation.addByPrefix('pray', 'dude pray', 16);
		animation.play('idle');
		updateHitbox();

		flashlight = new FlxSprite(0, 0, 'flashlightFX'.png());
		flashlight.alpha = 0.25;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		flashlight.setPosition(this.getGraphicMidpoint().x, this.getGraphicMidpoint().y);
		if (animation.name == 'idle')
		{
			flashlight.x += flashlightOffsetIDLE.x;
			flashlight.y += flashlightOffsetIDLE.y;
		}
		if (animation.name == 'pray')
		{
			flashlight.x += flashlightOffsetPRAY.x;
			flashlight.y += flashlightOffsetPRAY.y;
		}
	}
}
