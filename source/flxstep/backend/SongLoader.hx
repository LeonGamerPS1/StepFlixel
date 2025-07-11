package flxstep.backend;

import moonchart.formats.BasicFormat.FormatDifficulty;
import moonchart.formats.StepMania;

// dance singles only.... one strumline! fuck two!
class SongLoader
{
	static public function getStepMania(songName:String = "Asgore-Test"):StepMania
	{
		var pathSM:String = Paths.getPath('songs/$songName/CHART.sm');
		var stepManiaData = new StepMania().fromFile(pathSM);


		return stepManiaData; // please dont you dare fail me stepmania
	}
}
