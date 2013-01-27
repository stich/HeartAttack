package HeartAttack
{
	import org.flixel.*;
	import HeartAttack.Enemy;
	
	public class ChargingEnemy extends Enemy
	{
		private static const chargerSpeed:Number = 30.0;
		
		public function ChargingEnemy()
		{
			super();
			
			this.maxVelocity = new FlxPoint(chargerSpeed, chargerSpeed);
		}
		
		public override function update():void
		{
			var thePlayer:Heart = PlayState.playerHeart;
			
			var dX:Number = thePlayer.x - this.x;
			var dY:Number = thePlayer.y - this.y;
			
			this.acceleration = new FlxPoint(dX,dY);
		}
	}
}