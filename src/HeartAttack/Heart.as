package HeartAttack
{
	import flash.display.MovieClip;
	
	import org.flixel.*;
	
	public class Heart extends FlxSprite //HeartActor
	{
//		[Embed(source="megaman.png")] private var heartArt:Class;	//Graphic of the heart.
//		[Embed(source="HeartAttack.fla")] private var heartArt:Class;	//Graphic of the heart.
		[Embed(source="heart_sheet.png")] private var heartArt:Class;
		
		static private var idleFrames:Array = [0, 1, 2];
		static private var walkingFrames:Array = [3, 4, 5];
		static private var punchFrames1:Array = [6, 7, 8, 9];
		static private var punchFrames2:Array = [10, 11, 12, 13];
		
		static private var IDLE:int = 0;
		static private var WALKING:int = 1;
		static private var PUNCH1:int = 2;
		static private var PUNCH2:int = 3;
		
		private var _heartStand:MovieClip;
		private var _heartWalk:MovieClip;
		private var _heartPunch1:MovieClip;
		private var _heartPunch2:MovieClip;
		private var _heartAttack:MovieClip = null;
		
		private var _attackTimer:FlxTimer;
		private var _attacking:Boolean = false;
		
		private var _animState:int;
		
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
			
			//loadMovieClip(_heartStand, 150, 192, true, true);
			loadGraphic(heartArt, true, true, 200, 200);
			addAnimation("idle", idleFrames, 8, true);
			addAnimation("walking", walkingFrames, 8, true);
			addAnimation("punch1", punchFrames1, 8, false);
			addAnimation("punch2", punchFrames2, 8, false);
			addAnimationCallback(animationChanged);
			play("idle");
			
			_animState = IDLE;
//			loadRotatedGraphic(heartArt,32,-1,false,true);
			_attackTimer = new FlxTimer();
		}
		
		/*protected override function idle():void
		{
			if( !isIdle() && !isAttacking() )
			{
				trace("idling");
				_frameTime = 83;
				//loadMovieClip(_heartStand, 150, 192, true, true, restartAnimation);
				
			}
		}*/
		/*protected override function run():void
		{
			if( !isRunning() && !isAttacking() )
			{
				trace("running");
				_frameTime = 83;
				//loadMovieClip(_heartWalk, 150, 192, true, true, restartAnimation);
			}
		}*/
		protected function punchWeak():void
		{
			var theClip:MovieClip
			
			if( !isPunching() )
			{
				trace("Punching");
				_attacking = true;
				_animState = PUNCH1;
				
				play("punch1", true);
				theClip = _heartPunch2;//Math.random() > 0.5 ? _heartPunch1 : _heartPunch2;
				//loadMovieClip(theClip, 250, 192, true, true, didFinishPunch);
				//_frameTime = 200;
			}
			else if(_animState != PUNCH2)
			{
				_animState = PUNCH2;
				
				play("punch2", true);
				//theClip = _heartPunch1;//Math.random() > 0.5 ? _heartPunch1 : _heartPunch2;
				//loadMovieClip(theClip, 250, 192, true, true, didFinishPunch);
				//_frameTime = 200;
			}
		}
		
		private function isPunching():Boolean
		{
			return _attacking;// || _mc == _heartPunch1 || _mc == _heartPunch2;
		}
	/*	private function isRunning():Boolean
		{
			return _mc == _heartWalk;
		}
		private function isIdle():Boolean
		{
			return _mc == _heartStand;
		}*/
		
		protected function didFinishPunch():void
		{
			trace("Finished punching");
			_attacking = false;
			
			//restartAnimation();
 			//idle(); //restart the animation frmo the beginning IE: loop
		}
		
		//The main game loop function
		override public function update():void
		{
			super.update();
			
			if( FlxG.keys.justPressed("SPACE") )
			{
				//Space bar was pressed! Do an attack here.
				
				// start attack timer
				//				_attackTimer.start(0.2, 1, finishAttack);
				punchWeak();
			}
			
			if(_attacking)
			{
				velocity.x = 0;
				velocity.y = 0;
				return;
			}
			
			//This is where we handle moving our char
			var walking:Boolean = false;
			
			velocity.x = 0;
			velocity.y = 0;
			if(FlxG.keys.LEFT)
			{
				velocity.x -= 120;
				facing = FlxObject.LEFT;
				walking = true;
			}
			if(FlxG.keys.RIGHT)
			{
				velocity.x += 120;
				facing = FlxObject.RIGHT;
				walking = true;
			}
			if(FlxG.keys.UP)
			{
				velocity.y -= 120;
				walking = true;
			}
			if(FlxG.keys.DOWN)
			{
				velocity.y += 120;
				walking = true;
			}
			
			if(walking)
			{
				if(_animState != WALKING)
				{
					play("walking", true);
					_animState = WALKING;
				}
			}
			else
			{
				if(_animState != IDLE)
				{
					play("idle", true);
					_animState = IDLE;
				}
			}
		}
		
//		public function finishAttack(Timer:FlxTimer):void
//		{
//			_attacking = false;
//		}
		
		private function animationChanged(name:String, frameNum:uint, frameIndex:uint):void
		{
			if(name == "punch1" && frameIndex == 9)
			{
				_attacking = false;
			}
			
			if(name == "punch2" && frameIndex == 13)
			{
				_attacking = false;
			}
		}
		
		public function isAttacking():Boolean
		{
			return _attacking;
		}
	}
}