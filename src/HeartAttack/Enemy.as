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
			
			addAnimation("runLeft", [0]);
			addAnimation("runRight",[0]);
			addAnimation("idle",[0]);
			
			_health = 100;
		}
		
		override public function update():void
		{
			super.update();
			
			var velX:Number = velocity.x;
			if( velX > 0 )
				play("runRight");
			else if( velX < 0 )
				play("runLeft");
			else
				play("idle");
			
		}
	}
}