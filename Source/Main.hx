import nme.display.Sprite;

import nme.events.MouseEvent;
import nme.Assets;
import nme.text.Font;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.ui.Mouse;
import nme.Lib;
import nme.events.KeyboardEvent;
import motion.Actuate;


class Main extends Sprite 
{
	private var _riddleText:String = 'Fur of orange fur of black All the better for my attack';
	static private var _riddleAnswers:Array<String> = ['tiger','a tiger', 'tigers'];
	private var _codeLetters:Array<CodeLetter>;

	private var _codedLetterClicked:String = null;
	private var _plainLetterClicked:String = null;

	private var _background:ImgSprite;

	private var _letterInput:LetterInput;

	private var _cursor:Cursor;
	private var _answerInput:AnswerInput;

	private var _congratsBox:CongratsBox;

	private var _riddleTranslated:Bool;

	public function new () 
	{	
		super ();
		
		setupFonts();

		Mouse.hide();

		_riddleTranslated = false;

		_cursor = new Cursor();

		_background = new ImgSprite('assets/background.jpg');
		addChild(_background);

		Registry.game = this;	

		_codeLetters = new Array<CodeLetter>();
		
		_riddleText = _riddleText.toUpperCase();

		var currX:Int = 165;
		var currY:Int = 155;

		var cl:CodeLetter;
		var c:String;

		for (i in 0..._riddleText.length)
		{
			// trace(_riddleText.substr(i, 1));
			
			c = _riddleText.substr(i,1);

			if (c != ' ' && c != '.')
			{
				cl = new CodeLetter(c);
				cl.x = currX;
				cl.y = currY;

				addChild(cl);
				_codeLetters.push(cl);
			}

			currX += 30;
			if (currX > 530)
			{
				currX = 165;
				currY += 90;
			}

		}

		_letterInput = new LetterInput();
		_letterInput.x = (600 - _letterInput.width)/2;
		_letterInput.y = (800 - _letterInput.height - 50);
		addChild(_letterInput);
		_letterInput.visible = false;
		
		addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);

		_answerInput = new AnswerInput();
		_answerInput.x = (600 - _answerInput.width)/2;
		_answerInput.y = 800 - _answerInput.height - 50;
		addChild(_answerInput);
		_answerInput.visible = false;

		addChild(_cursor);

		_congratsBox = new CongratsBox();
		_congratsBox.x = -_congratsBox.width - 10; // (600 - _congratsBox.width)/2;
		_congratsBox.y = 50;

		addChild(_congratsBox);

		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private function onKeyUp(?e:KeyboardEvent):Void
	{
		if (e.keyCode == 13 && _answerInput.visible)
		{
			checkAnswer();
		}
		/*
		if (e.keyCode == 32)
		{
			triggerEndMessage();
		}
		*/
	}

	public function mouseMove(?e:MouseEvent):Void
	{
		_cursor.x = e.stageX;
		_cursor.y = e.stageY;
	}

	public function setupFonts()
	{
		var codeFont:Font = Assets.getFont('assets/Dethek_Stone.ttf');

		Registry.codeTF = new TextFormat(codeFont.fontName, 50, 0x4f4437);	
		Registry.codeTF.align = TextFormatAlign.CENTER;

		var plainFont:Font = Assets.getFont('assets/news.ttf');
		Registry.plainTF = new TextFormat(plainFont.fontName, 30, 0x000000);	
		Registry.plainTF.align = TextFormatAlign.CENTER;

		Registry.plainTFsm = new TextFormat(plainFont.fontName, 20, 0x000000);	
		Registry.plainTFsm.align = TextFormatAlign.CENTER;
	}



	public function setLetter(code:String, plain:String):Void
	{
		for (cl in _codeLetters)
		{
			if (cl.codeLetter() == code)
			{
				cl.setPlainLetter(plain);
			}

		}
	}

	public function clickedPlainLetter(c:String):Void
	{

		for (l in _codeLetters)
		{
			l.setHiglight(false);
		}

		// trace('CLICKED PLAIN LETTER: ' + c);
		if (_codedLetterClicked != null)
		{
			setLetter(_codedLetterClicked, c);
		}

		_letterInput.visible = false;

		checkText();

		// _cursor.visible = true;
		// Mouse.hide();
	}

	private function triggerEndMessage():Void
	{
		// trace('CONGRATS!');
		var newX:Int = Std.int((600 - _congratsBox.width)/2);

		Actuate.tween(_congratsBox,1,{x: newX}).onComplete(_congratsBox.showMessage);

	}

	private function checkAnswer():Void
	{
		var ansGiven:String = _answerInput.getAnswer();
		var ansFound:Bool = false;

		for (a in _riddleAnswers)
		{
			if (ansGiven == a)
			{
				ansFound = true;
			}
		}

		if (ansFound)
		{
			_answerInput.visible = false;
			triggerEndMessage();
		}
		else
		{
			_answerInput.wrongResponse();
		}
	}

	private function checkText():Void
	{
		var solved:Bool = true;

		for (l in _codeLetters)
		{
			if (!l.solved())
			{
				solved = false;
			}
		}
		// solved = true;

		if (solved)
		{
			_answerInput.visible = true;
			_answerInput.setFocus();
			_riddleTranslated = true;
		}
		else
		{
			_cursor.visible = true;
			Mouse.hide();			
		}
	}

	public function clickedCodeLetter(?e:MouseEvent):Void
	{
		if (_riddleTranslated) return;

		var cl:CodeLetter = cast(e.target, CodeLetter);
		if (cl != null)
		{
			_codedLetterClicked = cl.codeLetter();

			for (l in _codeLetters)
			{
				l.setHiglight(_codedLetterClicked == l.codeLetter());
			}
		}

		_letterInput.visible = true;
		_cursor.visible = false;
		Mouse.show();
	}

	public function clickedLetter(?e:MouseEvent):Void
	{
	
		var cl:CodeLetter = cast(e.target, CodeLetter);
		if (cl != null)
		{
			// trace('CLICKED ON A: ' + cl.codeLetter());
			setLetter(cl.codeLetter(), 'A');
		}
	}
	

	
}
















