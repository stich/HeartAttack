package HeartAttack
{
	import flash.display.MovieClip;
	
	import org.flixel.*;
	
	public class Heart extends HeartActor
	{
//		[Embed(source="megaman.png")] private var heartArt:Class;	//Graphic of the heart.
//		[Embed(source="HeartAttack.fla")] private var heartArt:Class;	//Graphic of the heart.
		
		private var _heartStand:MovieClip;
		private var _heartWalk:MovieClip;
		private var _heartPunch1:MovieClip;
		private var _heartPunch2:MovieClip;
		private var _heartAttack:MovieClip = null;
		
		private var _attackTimer:FlxTimer;
		private var _attacking:Boolean = false;
		
		public function Heart()
		{
			super(FlxG.width/2-8, FlxG.height/2-8);
//			loadGraphic(heartArt, false, true);
			_heartStand = new HeartStand();
			_heartWalk = new HeartWalk();
			_heartPunch1 = new Punch1();
			_heartPunch2 = new Punch2();
			
			antialiasing = true;
			this.origin = new FlxPoint(75, 95);
			
			loadMovieClip(_heartStand, 150, 192, true, true);
//			loadRotatedGraphic(heartArt,32,-1,false,true);
			_attackTimer = new FlxTimer();
		}
		
		protected override function idle():void
		{
			if( !isIdle() && !isAttacking() )
			{
				trace("idling");
				loadMovieClip(_heartStand, 150, 192, true, true, restartAnimation);
			}
		}
		protected override function run():void
		{
			if( !isRunning() && !isAttacking() )
			{
				trace("running");
				loadMovieClip(_heartWalk, 150, 192, true, true, restartAnimation);
			}
		}
		protected function punchWeak():void
		{
			if( !isPunching() )
			{
				trace("Punching");
				_attacking = true;
				
				var theClip:MovieClip = _heartPunch2;//Math.random() > 0.5 ? _heartPunch1 : _heartPunch2;
				loadMovieClip(theClip, 250, 192, true, true, didFinishPunch);
				_frameTime = 500;
		
			}
		}
		
		private function isPunching():Boolean
		{
			return _attacking;// || _mc == _heartPunch1 || _mc == _heartPunch2;
		}
		private function isRunning():Boolean
		{
			return _mc == _heartWalk;
		}
		private function isIdle():Boolean
		{
			return _mc == _heartStand;
		}
		
		protected function didFinishPunch():void
		{
			trace("Finished punching");
			_attacking = false;
			
 			idle(); //restart the animation frmo the beginning IE: loop
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
			
			if( FlxG.keys.justPressed("SPACE") )
			{
				//Space bar was pressed! Do an attack here.
				
				// start attack timer
//				_attackTimer.start(0.2, 1, finishAttack);
				punchWeak();
			}
		}
		
//		public function finishAttack(Timer:FlxTimer):void
//		{
//			_attacking = false;
//		}
		
		public override function isAttacking():Boolean
		{
			return _attacking;
		}
	}
}