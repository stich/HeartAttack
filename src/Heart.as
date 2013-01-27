package
{
	import org.flixel.*;
	
	public class Heart extends FlxSprite
	{
		[Embed(source="megaman.png")] private var heartArt:Class;	//Graphic of the heart.
		
		public function Heart()
		{
			super(FlxG.width/2-8, FlxG.height/2-8);
			loadRotatedGraphic(heartArt,32,-1,false,true);
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
				
				
			}
		}
	}
}