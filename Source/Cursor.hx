package;

import nme.display.Sprite;

class Cursor extends Sprite
{
	static public var CURSOR_GLASS:Int = 1;
	static public var CURSOR_HAND:Int = 2;

	private var _glass:ImgSprite;
	private var _hand:ImgSprite;


	public function new()
	{
		super();

		this.mouseEnabled = false;
		this.mouseChildren = false;

		_glass = new ImgSprite('assets/magglass.png');
		_glass.x = -27;
		_glass.y = -27;
		addChild(_glass);
	}
}