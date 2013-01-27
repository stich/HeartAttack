package HeartAttack
{
	import HeartAttack.Enemy;
	
	import org.flixel.*;
	
	public class ChargingEnemy extends Enemy
	{
//		private chargerSpeed:Number = 30.0;
		private var speed:Number = 30.0;
		
		[Embed(source="bacon_sheet.png")] private var spriteResrc:Class;	//Graphic of the enemy.
		
		static private var WALK_FRAMES:Array = [0, 1, 2];
		static private var HURT_FRAMES:Array = [3, 4, 5];
		
		static private var WALK:int = 0;
		static private var HURT:int = 1;
		
		private var _animState:int;
		
		public function ChargingEnemy($speed:Number)
		{
			super(Math.random()*FlxG.width, Math.random()*FlxG.height);
			
			loadGraphic(spriteResrc, true, true, 200, 200);
			
			addAnimation("walking", WALK_FRAMES, 8, true);
			addAnimation("hurt", HURT_FRAMES, 8, false);
			addAnimationCallback(finishAnimation);
			
			play("walking", true);
			
			speed = $speed;
			
			this.maxVelocity = new FlxPoint(speed, speed);
		}
		
		public override function update():void
		{
			if(_animState == HURT)
			{
				super.update();
				return;
			}
			
			var thePlayer:Heart = PlayState.playerHeart;
			
			var dX:Number = thePlayer.x - this.x;
			var dY:Number = thePlayer.y - this.y;
			
			if( Math.abs(dX) < dashDistance && Math.abs(dY) < dashDistance )
			{
				//dash
				dX = 2000.0 / dX;
				dY = 2000.0 / dY;
				
				maxVelocity = new FlxPoint(speed * 10.0, speed * 10.0);
			}
			else
				maxVelocity = new FlxPoint(speed, speed);
			
			this.acceleration = new FlxPoint(dX,dY);
			
			super.update();
			
			var velX:Number = velocity.x;
			if( velX > 0 )
			{
				this.facing = FlxObject.RIGHT;
			}
			else if( velX < 0 )
			{
				this.facing = FlxObject.LEFT;
			}
		}
		
		public override function hurt(Damage:Number):void
		{
			play("hurt", true);
			_animState = HURT;
			
			if(facing == FlxObject.RIGHT)
			{
				velocity.x = -100;
			}
			else
			{
				velocity.x = 100;
			}
			
			super.hurt(Damage);
		}
		
		private function finishAnimation(name:String, frameNum:int, frameIndex:int):void
		{
			if(name == "hurt" && frameIndex == 5)
			{
				_animState = WALK;
				play("walking", true);
			}
		}
	}
}