package HeartAttack
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	public class HeartActor extends FlxSprite
	{
		public function HeartActor(X:Number, Y:Number, graphic:Class = null)
		{
			super(X, Y, graphic);
		}
		
		protected function addAnimations():void
		{
			addAnimation("runLeft", [0]);
			addAnimation("runRight",[0]);
			addAnimation("idle",[0]);
		}
		
		public override function update():void
		{
			super.update();
			
			var velX:Number = velocity.x;
			if( velX > 0 )
			{
				this.facing = FlxObject.RIGHT;
				play("runRight");
			}
			else if( velX < 0 )
			{
				this.facing = FlxObject.LEFT;
				play("runLeft");
			}
			else
				play("idle");
		}
	}
}