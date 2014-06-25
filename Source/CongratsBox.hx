package;

import nme.display.Sprite;
import motion.Actuate;

class CongratsBox extends Sprite
{
	private static var ENV_START_Y:Int = 50;

	private var _letter:ImgSprite;
	private var _envelope:ImgSprite;

	public function new()
	{
		super();

		_letter = new ImgSprite('assets/letterpage.png');
		addChild(_letter);

		_envelope = new ImgSprite('assets/envelop.png');
		_envelope.y = ENV_START_Y;
		addChild(_envelope);

		_letter.x = (_envelope.width - _letter.width)/2;

	}

	public function showMessage():Void
	{
		com.eclecticdesignstudio.motion.Actuate.tween(_envelope,1,{y: 820});


	}
}