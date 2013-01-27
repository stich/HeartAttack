package HeartAttack
{
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		[Embed(source="frostman.png")] private var spriteResrc:Class;	//Graphic of the enemy.
		
		private var _health:int;
		
		public function Enemy()
		{
			super(Math.random()*FlxG.width, Math.random()*FlxG.height);
			
			loadRotatedGraphic(spriteResrc,32,-1,false,true);
			_health = 100;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}