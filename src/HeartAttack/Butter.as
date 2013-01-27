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
		
		public function Butter()
		{
			super();
			
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
						_dashTimer.start(1, 1, startDash);
						_dashState = DASH_REV_UP;
						
						if(dX >= 0)
							_dashSpeed = 200;
						else
							_dashSpeed = -200;
					}
					break;
				case DASH_DASHING:
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
	}
}