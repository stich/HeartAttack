package
{
	import org.flixel.*;
	
	public class Heart extends FlxSprite
	{
		[Embed(source="megaman.png")] private var heartArt:Class;	//Graphic of the heart.
		
		private var _attackTimer:FlxTimer;
		private var _attacking:Boolean;
		
		public function Heart()
		{
			super(FlxG.width/2-8, FlxG.height/2-8);
			loadRotatedGraphic(heartArt,32,-1,false,true);
			_attackTimer = new FlxTimer();
		}
		
		//The main game loop function
		override public function update():void
		{
			super.update();
			
			//This is where we handle moving our char
			velocity.x = 0;
			velocity.y = 0;
			if(FlxG.keys.LEFT)
				velocity.x -= 40;
			if(FlxG.keys.RIGHT)
				velocity.x += 40;
			if(FlxG.keys.UP)
				velocity.y -= 40;
			if(FlxG.keys.DOWN)
				velocity.y += 40;
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				//Space bar was pressed! Do an attack here.
				
				// start attack timer
				_attacking = true
				_attackTimer.start(0.2, 1, finishAttack);
			}
		}
		
		public function finishAttack(Timer:FlxTimer):void
		{
			_attacking = false;
		}
		
		public function isAttacking():Boolean
		{
			return _attacking;
		}
	}
}