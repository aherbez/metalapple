package;

import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.filters.GlowFilter;
import nme.display.BlendMode;

import nme.text.TextField;
import nme.text.TextFieldAutoSize;

import Main;

class CodeLetter extends Sprite
{
	private var _codeText:TextField;
	private var _plainText:TextField;

	private var _codeLetter:String;

	private var _highlight:Sprite;

	public function new(c:String)
	{
		super();
		
		_codeLetter = c;
		// this.graphics.lineStyle(1, 0x0000FF, 1);
		this.graphics.beginFill(0x0000FF, 0.01);
		this.graphics.drawRect(-15, 0, 30, 50);
		this.graphics.endFill();
		
		_codeText = new TextField();
		_codeText.defaultTextFormat = Registry.codeTF;
		_codeText.embedFonts = true;
		_codeText.mouseEnabled = false;
		_codeText.blendMode = BlendMode.SCREEN;
		_codeText.width = 50;
		_codeText.x = -25;
		_codeText.text = c;
		_codeText.filters = [new GlowFilter(0x000000,0.8,5,5,10)];
		addChild(_codeText);

		_plainText = new TextField();
		_plainText.defaultTextFormat = Registry.plainTF;
		_plainText.embedFonts = true;
		_plainText.mouseEnabled = false;
		_plainText.height = 100;
		// _plainText.autoSize = TextFieldAutoSize.CENTER;
		_plainText.width = 30;
		_plainText.x = -15;
		_plainText.y = -30;
		addChild(_plainText);

		_highlight = new Sprite();
		_highlight.graphics.lineStyle(2, 0xFF0000, 1);
		_highlight.graphics.drawRoundRect(-15, 0, 30, 50, 5);
		addChild(_highlight);
		_highlight.visible = false;

		addEventListener(MouseEvent.CLICK, Registry.game.clickedCodeLetter);
	}

	public function solved():Bool
	{
		return (_plainText.text == _codeLetter);
	}

	public function setHiglight(b:Bool):Void
	{
		_highlight.visible = b;
	}

	public function codeLetter():String
	{
		return _codeLetter;
	}

	public function setPlainLetter(?l:String = null):Void
	{
		if (l != null)
		{
			_plainText.text = l;
		}
		else
		{
			_plainText.text = '';
		}
	}
}