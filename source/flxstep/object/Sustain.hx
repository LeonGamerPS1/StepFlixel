package flxstep.object;



class Sustain extends T // shortass name for the tiled sprite thing??
{
	var skin = "simple";

	public var length:Float = 1000;
	public var speed:Float = 1;

	public function new(?skin:String = "simple")
	{
		super();
		this.skin = skin;
		reload();
	}

	function reload()
	{
		var susbitmap = Paths.image('noteskins/$skin/hold').bitmap;

		loadGraphic(susbitmap, true, Std.int(susbitmap.width / 2) , Std.int(susbitmap.height));

		animation.add('holdpiece', [0]);
        animation.add('holdend', [1]);
		animation.play('holdpiece');
        updateHitbox();
        setTail('holdend'); // uhh i think this allows you to change the tail?
        
	}

	override function draw() // temporary test to see if the rendering words just fine :3
	{
        height = (length * speed * 0.45) + tailHeight();
       

		super.draw();
	}

    public function setPos(receptor:FlxSprite) {
        setPosition(receptor.getGraphicMidpoint().x -  (width  / 2),receptor.getGraphicMidpoint().y);
        return this;
    }
}
