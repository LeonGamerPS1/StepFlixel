package flxstep.object;

import moonchart.formats.BasicFormat.BasicNote;

class Note extends FlxSkewedSprite
{
	public var data:BasicNote;
	public var skin:String = "simple";

	public function new(data:BasicNote, ?skin:String = "simple")
	{
		super();
		this.data = data;

		reload();
	}

	var lastSkin:String = null;

	public var angles = Receptor.angles;

	function reload()
	{
		if(data == null)
			return;
		lastSkin = skin;
		loadGraphic(Paths.image('noteskins/$skin/note')); // getting width and height
		loadGraphic(Paths.image('noteskins/$skin/note'), true, Math.floor(width), Math.floor(height));

		animation.add('static', [0]);

		playAnim('static', true);
		updateHitbox();
		playAnim('static', true);
		angle = angles[data.lane % angles.length];
		antialiasing = true;
	}

	public function init(data:BasicNote, ?skin:String = "simple")
	{
		this.data = data;
		this.skin = skin;
		reload();
		return this;
	}

	public function playAnim(s:String, force:Bool)
	{
		animation.play(s, force);
		centerOffsets();
		centerOrigin();
	}
}
