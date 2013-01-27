package HeartAttack
{
	import org.flixel.*;
	import HeartAttack.Enemy;
	
	public class ChargingEnemy extends Enemy
	{
//		private chargerSpeed:Number = 30.0;
		private var speed:Number = 30.0;
		
		public function ChargingEnemy($speed:Number)
		{
			super();
			
			speed = $speed;
			
			this.maxVelocity = new FlxPoint(speed, speed);
		}
		
		public override function update():void
		{
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
		}
	}
}