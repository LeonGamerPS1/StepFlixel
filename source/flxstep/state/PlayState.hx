package flxstep.state;

import flixel.sound.FlxSound;
import moonchart.formats.StepMania;

class PlayState extends FlxState
{
	public var playfield:Playfield;

	static public var song:StepMania;

	public var music:FlxSound;

	override public function create()
	{
		song = SongLoader.getStepMania();
		Conductor.setBPM(song.data.BPMS[0].bpm);
		Conductor.songPosition = -Conductor.msPerBeat * 5;
		Conductor.onBeat = beat;
		music = FlxG.sound.load('assets/music/${song.data.MUSIC}');

		super.create();
		playfield = new Playfield();
		playfield.speed = song.getChartMeta().scrollSpeeds.get('Hard') ?? 1.2;
		for (note in song.getNotes())
			playfield.unspawnNotes.push(note);

		add(playfield);
	}

	var started:Bool = false;

	override public function update(elapsed:Float)
	{
		if (!started)
		{
			Conductor.songPosition += elapsed * 1000;
			Conductor.updatePosition(Conductor.songPosition);
			if (Conductor.songPosition >= 0)
				start();
		}
		else
		{
			Conductor.updatePosition(music.time);
		}
		super.update(elapsed);
	}

	public function beat(b:Float)
	{
		for (change in song.data.BPMS)
		{
			if (b > change.beat)
				Conductor.setBPM(change.bpm);
		}
		b = Math.ffloor(b);
		playfield.beat(b);
	}

	public function start()
	{
		started = true;
		music.play();
	}
}
