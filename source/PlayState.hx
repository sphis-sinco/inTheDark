package;

import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var dude:Dude;

	public var dudeSameSpotVinwet:FlxSprite;
	public var dudeSameSpotTimer:FlxTimer = new FlxTimer();

	public var monster:FlxSprite;

	public var monsterCOOLDOWN:Int = 0;

	public var monsterWarning:Bool = false;
	public var monsterWarningSpr:FlxSprite;

	public var monsterAttacking:Bool = false;

	public var monsterLeftX:Float = 0;
	public var monsterRightX:Float = 0;

	public var timeSurvived:Int = 0;
	public var timeSurvivedTimer:FlxTimer = new FlxTimer();
	public var timeSurvivedText:FlxText;

	public var overlay:FlxSprite;

	override public function create()
	{
		super.create();

		dude = new Dude();

		add(dude.flashlight);
		add(dude);

		dude.screenCenter();
		dude.y += dude.height * 0.65;

		monster = new FlxSprite(0, 0, 'el monster'.png());
		randomMonsterMood();
		add(monster);
		monsterWarning = false;

		monsterLeftX = -monster.width * 5;
		monsterRightX = FlxG.width + monster.width * 5;

		monster.flipX = FlxG.random.bool(FlxG.random.float(0, 100));
		setMonsterPos();

		overlay = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		overlay.alpha = 0.8;
		add(overlay);

		monsterWarningSpr = new FlxSprite(0, 0, 'monete warning'.png());
		monsterWarningSpr.screenCenter();
		add(monsterWarningSpr);
		monsterWarningSpr.visible = false;

		dudeSameSpotVinwet = new FlxSprite(0, 0, 'move'.png());
		add(dudeSameSpotVinwet);

		timeSurvivedText = new FlxText(0, 4, 0, '');
		add(timeSurvivedText);

		timeSurvivedTimer.start(1, function(t)
		{
			timeSurvived++;
			
			timeSurvivedText.text = '$timeSurvived';
			if (timeSurvived > 60 * 60 * 24)
				timeSurvivedText.text = '${FlxMath.roundDecimal(((timeSurvived / 60) / 60) / 24, 2)} days...';
			else if (timeSurvived > 60 * 60)
				timeSurvivedText.text = '${FlxMath.roundDecimal((timeSurvived / 60) / 60, 2)}h';
			else if (timeSurvived > 60)
				timeSurvivedText.text = '${FlxMath.roundDecimal(timeSurvived / 60, 2)}m';
			else
				timeSurvivedText.text = '${timeSurvived}s';
		}, 0);
	}

	public function randomMonsterMood()
	{
		monsterWarning = false;
		monsterCOOLDOWN = FlxG.random.int(150, 3000);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timeSurvivedText.screenCenter(X);

		#if debug
		if (FlxG.keys.justReleased.R)
			overlay.alpha = (overlay.alpha == 0.8) ? 0.2 : 0.8;
		#end

		if (monsterCOOLDOWN > 0 && !monsterAttacking)
		{
			monsterCOOLDOWN -= 1;
		}
		else if (!monsterAttacking)
		{
			monsterAttacking = true;
			monsterWarning = true;
			new FlxTimer().start(FlxG.random.float(2, 4), function(t)
			{
				monsterWarning = false;
				randomMonsterMood();

				setMonsterPos();
				FlxTween.tween(monster, {x: (monster.flipX) ? monsterRightX : monsterLeftX}, FlxG.random.float(1, 3), {
					onComplete: function(t)
					{
						monster.flipX = !monster.flipX;
						randomMonsterMood();
						monsterAttacking = false;
					}
				});
			});
		}
		FlxG.watch.addQuick('monsterCOOLDOWN', monsterCOOLDOWN);

		monsterWarningSpr.visible = monsterWarning;

		if (FlxG.keys.justReleased.SPACE)
		{
			dude.flashlight.visible = !dude.flashlight.visible;

			dude.animation.play('idle');
			dudeSameSpotTimer.cancel();
			if (!dude.flashlight.visible)
			{
				dude.animation.play('pray');
				dudeSameSpotTimer.start(17, function(t)
				{
					trace('u will die');
				});
			}
		}

		if (dudeSameSpotTimer.active)
			dudeSameSpotVinwet.alpha = 0.25 * (dudeSameSpotTimer.elapsedTime / dudeSameSpotTimer.time);
		else
			dudeSameSpotVinwet.alpha = 0;

		if (monsterAttacking)
		{
			if (monster.overlaps(dude) && dude.animation.name == 'pray')
			{
				trace('u have been diddy touched');
			}
		}
	}

	public function setMonsterPos()
	{
		monster.screenCenter(Y);
		monster.y += monster.height * 0.25;
		if (monster.flipX)
			monster.x = monsterLeftX;
		else
			monster.x = monsterRightX;
	}
}
