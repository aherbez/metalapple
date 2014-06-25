package;

import nme.display.Sprite;
import nme.text.TextField;
import nme.events.MouseEvent;

class LetterInput extends Sprite
{
	private static var LETTERS:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	private static var BUTTON_SIZE:Int = 30;

	private var _letterBtns:Array<Sprite>;

	private var _letterOffset:Int = 10;
	private var _letterSpacingX:Int = 50;
	private var _letterSpacingY:Int = 40;

	private var _lettersPerRow:Int = 0;

	public function new()
	{
		super();

		this.graphics.lineStyle(3, 0x000000, 1);
		this.graphics.beginFill(0x444444, 0.5);
		this.graphics.drawRoundRect(0, 0, 500, 150, 20);

		_letterBtns = new Array<Sprite>();

		var btn:Sprite;
		var c:String;
		var txt:TextField;

		var xpos:Int = _letterOffset;
		var ypos:Int = _letterOffset;

		for (i in 0...LETTERS.length)
		{
			c = LETTERS.substr(i,1);

			btn = new Sprite();
			txt = new TextField();
			txt.mouseEnabled = false;
			txt.embedFonts = true;
			txt.defaultTextFormat = Registry.plainTFsm;
			txt.text = c;
			txt.width = BUTTON_SIZE;
			txt.height = BUTTON_SIZE + 10;
			txt.x = 0;
			txt.y = (BUTTON_SIZE - txt.textHeight)/2;
			

			btn = new Sprite();
			btn.graphics.lineStyle(2, 0x000000, 1);
			btn.graphics.beginFill(0x888888, 1);
			btn.graphics.drawRoundRect(0, 0, BUTTON_SIZE, BUTTON_SIZE, 5);

			btn.addChild(txt);

			btn.x = xpos;
			btn.y = ypos;

			addChild(btn);
			xpos += _letterSpacingX;

			if (xpos >= 480)
			{
				if (_lettersPerRow == 0) _lettersPerRow = i + 1;
				xpos = _letterOffset;
				ypos += _letterSpacingY;
			}
			/*
			var f:MouseEvent->Void = function(?e:MouseEvent):Void
			{
				var newC:String = c;
				Registry.game.clickedPlainLetter(newC);
			}

			btn.addEventListener(MouseEvent.CLICK, f);
			*/
		}

		addEventListener(MouseEvent.CLICK, clickedLetter);

	}


	public function clickedLetter(?e:MouseEvent):Void
	{
		var xRaw:Int = Std.int(e.stageX - this.x - _letterOffset);
		var yRaw:Int = Std.int(e.stageY - this.y - _letterOffset);

		xRaw = Std.int(xRaw / _letterSpacingX);
		yRaw = Std.int(yRaw / _letterSpacingY);

		var cIndex:Int = yRaw * _lettersPerRow + xRaw;
		
		if (cIndex >= 26) return;

		var c:String = LETTERS.substr(cIndex, 1);

		// trace('CLICKED ON ' + c);
		Registry.game.clickedPlainLetter(c);
	}


}