package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	//bar/ball variables
	var ballDim = 25; var barHeight = 125; var barWidth = 25;
	var ball:FlxSprite; var player:FlxSprite; var comp:FlxSprite;
	var wallTop:FlxSprite; var wallBottom:FlxSprite;
	var walls:FlxGroup; var paddles:FlxGroup;
	
	
	override public function create()
	{
		super.create();
		ball = new FlxSprite(); player = new FlxSprite();
		ball.makeGraphic(ballDim, ballDim, FlxColor.WHITE);
		ball.x = FlxG.width/2 - ball.width/2;
		ball.y = FlxG.height/2 - ball.height/2;

		ball.velocity.y = 200;
		ball.velocity.x = -200;
		ball.elasticity = 1;

		player.makeGraphic(barWidth, barHeight, FlxColor.WHITE);
		player.x = 25;
		player.y = FlxG.height/3; player.immovable = true;
		comp = new FlxSprite();
		comp.makeGraphic(barWidth, barHeight, FlxColor.WHITE);
		comp.x = FlxG.width - 50;
		comp.y = FlxG.height/3; comp.immovable = true;

		paddles = new FlxGroup();
		paddles.add(player); paddles.add(comp);

		wallTop = new FlxSprite(0,0);
		wallTop.makeGraphic(FlxG.width, 4, FlxColor.BLACK);
		wallTop.immovable = true;
		add(wallTop);
		wallBottom = new FlxSprite(0,FlxG.height - 4);
		wallBottom.makeGraphic(FlxG.width, 4, FlxColor.BLACK);
		wallBottom.immovable = true;
		add(wallBottom);
		
		walls = new FlxGroup();
		walls.add(wallTop); walls.add(wallBottom);
		add(ball); add(player); add(comp);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(ball, walls); FlxG.collide(ball, paddles);
		if (FlxG.keys.pressed.UP)
		{
			player.y -= 200 * elapsed;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			player.y += 200 * elapsed;
		}

		if (player.y <= 0){
			player.y = 0;
		}
		if (player.y > FlxG.height - player.height)
		{
			player.y = FlxG.height - player.height;
		}

		if (ball.x < 0 - 25 || ball.x > FlxG.width){
			ball.x = FlxG.width/2 - ball.width/2;
			ball.y = FlxG.height/2 - ball.height/2;
		}

		if (ball.y <= 0){
			ball.y = 0;
		}
		if (ball.y > FlxG.height - ball.height)
		{
			ball.y = FlxG.height - ball.height;
		}


		comp.y = ball.y - 50;
	}
}
