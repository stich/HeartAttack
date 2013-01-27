package
{
	import HeartAttack.Butter;
	import HeartAttack.ChargingEnemy;
	import HeartAttack.Enemy;
	import HeartAttack.Heart;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public static var playerHeart:Heart;			//Refers to the little player playerShip
		//public var bullets:FlxGroup;	//A list of the bullets you shoot at the asteroids
		public var enemies:FlxGroup;	//A list of all the asteroids 
		//public var timer:Number;		//A timer to decide when to make a new asteroid
		
		override public function create():void
		{
			FlxG.mouse.hide();
			var i:uint;
			var sprite:FlxSprite;
			
			//scatter some stars around the background
			for(i = 0; i < 100; i++)
			{
				sprite = new FlxSprite(FlxG.random()*FlxG.width,FlxG.random()*FlxG.height);
				sprite.makeGraphic(1,1);
				sprite.active = false;
				add(sprite);
			}
			
			playerHeart = new Heart();
			add(playerHeart);
			
			enemies = new FlxGroup();
			
			var count:int;
			
//			for(count = 0; count < 5; ++count)
//			{
//				enemies.add(new Enemy());
//			}
			for(count = 0; count < 8; ++count)
			{
				enemies.add(new ChargingEnemy(Math.random() * 40.0));
			}
			
			enemies.add(new Butter());
			add(enemies);
			
			//Initialize the list of asteroids, and generate a few right off the bat
			/*asteroids = new FlxGroup();
			add(asteroids);
			spawnAsteroid();
			spawnAsteroid();
			spawnAsteroid();
			
			//Initialize the playerShip and add it to the layer
			playerShip = new PlayerShip();
			add(playerShip);
			
			//Then instantiate the bullets you fire at your enemies.
			var numBullets:uint = 32;
			bullets = new FlxGroup(numBullets);
			for(i = 0; i < numBullets; i++)
			{
				//Instantiate a new 2x8 generic sprite offscreen
				sprite = new WrapSprite(-100, -100);
				sprite.makeGraphic(8, 2);
				sprite.width = 10;		//We're going to exaggerate the bullet'sprite bounding box a little
				sprite.height = 10;
				sprite.offset.x = -1;
				sprite.offset.y = -4;
				sprite.exists = false;
				bullets.add(sprite);	//Add it to the array of player bullets
			}
			add(bullets);*/
		}
		
		//The main game loop function
		override public function update():void
		{
			super.update();
			
			FlxG.overlap(playerHeart, enemies, handleCollision);
			
			//Count down the new asteroid timer
			/*timer -= FlxG.elapsed;
			if(timer <= 0)
				spawnAsteroid();
			
			//Pretty much always call the main game loop's parent update.
			//This goes and calls update on all the objects you added to this state
			super.update();
			
			//Perform collisions between the different objects.  Overlap will
			// check to see if any of those sprites touch, and if they do, it will
			// call kill() on both of them, which sets 'exists' to false, and 'dead' to true.
			//You can optionally pass it a callback function if you want more detailed reactions.
			FlxG.overlap(bullets, asteroids, stuffHitStuff);	//Check to see if any bullets overlap any asteroids
			FlxG.overlap(asteroids, playerShip, stuffHitStuff);	//Check to see if any asteroids overlap the playerShip
			FlxG.collide(asteroids);	//Bounce asteroids off each other
			
			//If the player died, reset the game
			if(!playerShip.exists)
				FlxG.resetState();*/
		}
		
		//Simple overlap handler that just calls "kill()" on the overlapping objects.
		//In this game, this is called whenever bullets overlap an asteroid,
		// or when an asteroid overlaps the player's ship.
		protected function stuffHitStuff(Object1:FlxObject,Object2:FlxObject):void
		{
			Object1.kill();
			Object2.kill();
		}
		
		protected function handleCollision(Object1:FlxObject, Object2:FlxObject):void
		{
			var player:Heart = null;
			var enemy:Enemy = null;
			
			if(Object1 is Enemy && Object2 is Heart)
			{
				player = Object2 as Heart;
				enemy = Object1 as Enemy;
			}
			
			if(Object2 is Enemy && Object1 is Heart)
			{
				player = Object1 as Heart;
				enemy = Object2 as Enemy;
			}
			
			if(player != null && enemy != null)
			{
				if(player.isAttacking())
				{
					var playerCenterX:Number = player.x + player.frameWidth*0.5;
					var enemyCenterX:Number = enemy.x + enemy.frameWidth*0.5;
					
					if(player.facing == FlxObject.LEFT && playerCenterX >= enemyCenterX)
						enemy.hurt(0);
					else if(player.facing == FlxObject.RIGHT && playerCenterX <= enemyCenterX)
						enemy.hurt(0);
				}
			}
		}
		
		//This function resets the timer and adds a new asteroid to the game
		private function spawnAsteroid():void
		{
			//Create a new asteroid and add it to the group
			/*var asteroid:Asteroid = asteroids.recycle(Asteroid) as Asteroid;
			asteroid.create();
			timer = 1+FlxG.random()*4;	//Reset the timer
			*/
		}
	}
}