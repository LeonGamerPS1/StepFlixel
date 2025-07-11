package flxstep.object;

using flixel.util.FlxDestroyUtil;

class Playfield extends FlxGroup
{
	public var receptors:FlxTypedSpriteGroup<Receptor>;
    public var sustains:FlxTypedGroup<Sustain>;


	public var bot(default, null):Bool = true;
    public var speed:Float = 1.2;

	public function new()
	{
		super(0);
		receptors = new FlxTypedSpriteGroup<Receptor>();
		add(receptors);

        sustains = new FlxTypedGroup<Sustain>();
		add(sustains);

		generateReceptors();
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
}
