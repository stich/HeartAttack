package HeartAttack
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	public class HeartActor extends FlxMovieClip
	{
		public function HeartActor(X:Number, Y:Number, graphic:Class = null)
		{
			super(X, Y);
		}
		
		protected function addAnimations():void
		{
			addAnimation("run", [0]);
			addAnimation("idle",[0]);
		}
		
		protected function run():void
		{
			play("run");
		}
		protected function idle():void
		{
			play("idle");
		}
		
		public function isAttacking():Boolean
		{
			return false;
		}
		
		public override function update():void
		{
			super.update();
			
			var velX:Number = velocity.x;
			if( velX > 0 )
			{
				this.facing = FlxObject.RIGHT;
				run();
			}
			else if( velX < 0 )
			{
				this.facing = FlxObject.LEFT;
				run();
			}
			else if( velocity.y != 0 )
			{
				run();
			}
			else if( !isAttacking() )
				idle();
		}
	}
}