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

		super.create();
		playfield = new Playfield();
		playfield.speed = song.getChartMeta().scrollSpeeds.get('Hard') ?? 1.2;
		add(playfield);

		music = FlxG.sound.load('assets/music/${song.data.MUSIC}');
		music.play();
	
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
