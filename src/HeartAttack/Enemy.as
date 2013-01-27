package HeartAttack
{
	import org.flixel.*;
	import HeartAttack.HeartActor;

	public class Enemy extends HeartActor
	{
		[Embed(source="frostman.png")] private var spriteResrc:Class;	//Graphic of the enemy.
		
		protected static const dashDistance:Number = 20;
		
		public function Enemy()
		{
			super(Math.random()*FlxG.width, Math.random()*FlxG.height);
			
//			loadRotatedGraphic(spriteResrc,32,-1,false,true);
			loadGraphic(spriteResrc, false, true);
			
			this.health = 100;
		}
		
		override public function update():void
		{
			
			super.update();
		}
	}
}