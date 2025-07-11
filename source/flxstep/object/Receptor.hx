package flxstep.object;

class Receptor extends FlxSkewedSprite
{
	public var data:Int = 0;
	public var skin:String = "simple";
	public var light:FlxSkewedSprite;
	public var glow:FlxSkewedSprite;

	public function new(data:Int = 0, ?skin:String = "simple")
	{
		super();
		this.data = data;
		this.skin = skin;
		glow = new FlxSkewedSprite();
		light = new FlxSkewedSprite();
		reload();
	}

	var lastSkin:String = null;

	public static var angles = [90, 0, 180, -90];

	function reload()
	{
		if (lastSkin == skin)
			return;
		lastSkin = skin;
		loadGraphic(Paths.image('noteskins/$skin/receptor')); // getting width and height
		loadGraphic(Paths.image('noteskins/$skin/receptor'), true, Math.floor(width / 2), Math.floor(height));

		animation.add('static', [1]);
		animation.add('light', [0]);

		playAnim('static', true);
		updateHitbox();
		playAnim('static', true);
		angle = angles[data % angles.length];

		glow.loadGraphic(Paths.image('noteskins/$skin/glow'));
		glow.centerOffsets();
		glow.centerOrigin();
		glow.antialiasing = true;
		antialiasing = true;
		light.frames = frames;
		light.animation.copyFrom(animation);
		light.animation.play('light');
		light.updateHitbox();
		light.centerOffsets();
		light.centerOrigin();
	}

	public function playAnim(s:String, force:Bool)
	{
		animation.play(s, force);
		centerOffsets();
		centerOrigin();
	}

	override function draw()
	{
		super.draw();
		if (light != null) // i dont know how to do any better :sob:
		{
			light.setPosition(x, y);

			light.alpha = FlxMath.lerp(0, light.alpha, Math.exp(-FlxG.elapsed * 4));

			light.angle = angle;
			light.skew.set(skew.x, skew.y);
			light.draw();
		}

		if (glow != null) // i dont know how to do any better :sob:
		{
			glow.setPosition(x, y);
			glow.skew.set(skew.x, skew.y);
			glow.x -= 15 * (glow.width / 96);
			glow.y -= 15 * (glow.height / 96);
			glow.alpha = FlxMath.lerp(0, glow.alpha, Math.exp(-FlxG.elapsed * 1));

			glow.angle = angle;
			glow.draw();
		}
	}
}
