package 
{
	import org.flixel.*
	import HeartAttack.MenuState;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	//[Frame(factoryClass="Preloader")]
	
	public class HeartAttack extends FlxGame
	{
		public function HeartAttack()
		{
			super(640,480,MenuState,1,50,50);
			forceDebugger = true;
		}
	}
}