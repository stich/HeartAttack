package HeartAttack
{
	import HeartAttack.HeartActor;
	
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		protected static const dashDistance:Number = 20;
		
		public function Enemy(x:Number, y:Number)
		{
			super(Math.random()*FlxG.width, Math.random()*FlxG.height);
			
			this.health = 100;
		}
		
		override public function update():void
		{
			
			super.update();
		}
	}
}