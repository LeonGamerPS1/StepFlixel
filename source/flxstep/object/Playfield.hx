package flxstep.object;

import flixel.util.FlxColor;
import moonchart.formats.BasicFormat.BasicNote;

using flixel.util.FlxDestroyUtil;

class Playfield extends FlxGroup
{
	public var notes:FlxTypedGroup<Note>;
	public var receptors:FlxTypedSpriteGroup<Receptor>;
	public var sustains:FlxTypedGroup<Sustain>;

	public var bot(default, null):Bool = true;
	public var speed:Float = 1.2;

	public var unspawnNotes:Array<BasicNote> = [];

	public function new()
	{
		super();

		notes = new FlxTypedGroup<Note>();
		add(notes);

		receptors = new FlxTypedSpriteGroup<Receptor>();
		add(receptors);

		sustains = new FlxTypedGroup<Sustain>();
		add(sustains);

		generateReceptors();
		camera.flash(FlxColor.BLACK, 0.5);
	}

	function generateReceptors()
	{
		receptors.clear();

		for (i in 0...4)
		{
			var receptor:Receptor = new Receptor(i);
			receptor.x += receptor.width * i;
			receptors.add(receptor);
		}

		receptors.y = 50;
		receptors.screenCenter(X); // middle scroll....
	}

	public function beat(b:Float)
	{
		for (i in receptors)
			i.light.alpha = 1;
	}
	override function update(elapsed:Float)
	{
		if (unspawnNotes[0].time <= Conductor.songPosition + (1500 / speed))
		{
			var note:Note = notes.recycle(Note).init(unspawnNotes[0], receptors.members[unspawnNotes[0].lane % receptors.members.length].skin);
			unspawnNotes.remove(unspawnNotes[0]);
			note.visible = true;
		}
		super.update(elapsed);
		notes.forEachAlive(function(note:Note)
		{
			var receptor:Receptor = receptors.members[note.data.lane % receptors.members.length];
			if (bot && note.data.time <= Conductor.songPosition)
			{
				receptor.glow.alpha = 1;
				note.kill();
			}
		});
	}
}
