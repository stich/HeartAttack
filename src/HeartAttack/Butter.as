package HeartAttack
{
	import org.flixel.*;

	public class Butter extends Enemy
	{
		private static const CLOSE_IN_DIST_X:Number = 400;
		private static const CLOSE_IN_DIST_Y:Number = 50;
		private static const DASH_BOUNDS:Number = 100;
		
		private static const DASH_LINE_UP:int = 0;
		private static const DASH_REV_UP:int = 1;
		private static const DASH_DASHING:int = 2;
		
		private var _dashTimer:FlxTimer;
		private var _dashState:int;
		private var _dashSpeed:Number;
		
		private static var WALK_FRAMES:Array = [0, 1, 2];
		private static var REV_UP_FRAMES:Array = [3];
		private static var DASH_FRAMES:Array = [4, 5, 6];
		private static var DASH_HOLD_FRAMES:Array = [7];
		
		private static var WALK:int = 0;
		private static var REV_UP:int = 1;
		private static var DASH:int = 2;
		
		private var _animState:int;
		
		[Embed(source="butter_sheet.png")] private var spriteResrc:Class;	//Graphic of the enemy.
		
		public function Butter()
		{
			super(Math.random()*FlxG.width, Math.random()*FlxG.height);
			
			loadGraphic(spriteResrc, true, true, 200, 200);
			
			addAnimation("walking", WALK_FRAMES, 8, true);
			addAnimation("rev_up", REV_UP_FRAMES, 8, true);
			addAnimation("dash", DASH_FRAMES, 8, true);
			addAnimation("dash_hold", DASH_HOLD_FRAMES, 8, true);
			
			addAnimationCallback(finishAnimation);
			
			_animState = WALK;
			
			play("walking", true);
			
			_dashTimer = new FlxTimer();
			_dashState = DASH_LINE_UP;
		}
		
		public override function update():void
		{
			super.update();
			
			var player:Heart = PlayState.playerHeart;
			
			var dX:Number = (player.x + player.width*0.5) - (this.x + this.width*0.5);
			var dY:Number = (player.y + player.height*0.5) - (this.y + this.height*0.5);
			
			velocity.x = 0;
			velocity.y = 0;
			
			switch(_dashState)
			{
				case DASH_LINE_UP:
					if(dX > 0)
						facing = FlxObject.RIGHT;
					else
						facing = FlxObject.LEFT;
					
					// try to first get into distance with player on the X-axis
					if(Math.abs(dX) > CLOSE_IN_DIST_X)
					{
						if(dX >= 0)
							velocity.x = 50;
						else if(dX < 0)
							velocity.x = -50;
					}
					
					if(Math.abs(dY) > CLOSE_IN_DIST_Y)
					{
						if(dY >= 0)
							velocity.y = 50;
						else if(dY < 0)
							velocity.y = -50;
					}
					
					if(Math.abs(dX) <= CLOSE_IN_DIST_X && Math.abs(dY) <= DASH_BOUNDS)
					{
						// count one second before going into a dash.
						_dashTimer.start(2, 1, startDash);
						_dashState = DASH_REV_UP;
						
						_animState = REV_UP;
						
						play("rev_up", true);
						
						if(dX >= 0)
							_dashSpeed = 200;
						else
							_dashSpeed = -200;
					}
					else if(_animState != WALK)
					{
						_animState = WALK;
						play("walking", true);
					}
					break;
				case DASH_DASHING:
					if(_animState != DASH)
					{
						_animState = DASH;
						play("dash", true);
					}
					
					if( (_dashSpeed > 0 && this.x >= (FlxG.width - 50)) || (_dashSpeed <= 0 && this.x <= 50) )
					{
						// go back to the line up state
						_dashState = DASH_LINE_UP;
					}
					else
					{
						velocity.x = _dashSpeed;
					}
					break;
			}
		}
		
		private function startDash(timer:FlxTimer):void
		{
			_dashState = DASH_DASHING;
			_dashTimer.stop();
		}
		
		private function finishAnimation(name:String, frameNum:int, frameIndex:int):void
		{
			if(name == "dash" && frameIndex == 6)
			{
				play("dash_hold", true);
			}
		}
	}
}