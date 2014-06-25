package;

import motion.Actuate;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFieldType;
import nme.text.TextFormatAlign;
import nme.Lib;

class AnswerInput extends Sprite
{
	private var _question:TextField;
	private var _textInput:TextField;

	public function new()
	{
		super();

		this.graphics.lineStyle(3, 0x000000, 1);
		this.graphics.beginFill(0x888888, 1);
		this.graphics.drawRoundRect(0, 0, 300, 100, 20);


		_question = new TextField();
		_question.defaultTextFormat = Registry.plainTF;
		_question.embedFonts = true;
		_question.text = 'What am I?';
		_question.width = 280;
		_question.x = 10;
		_question.y = 10;
		addChild(_question);


		_textInput = new TextField();
		_textInput.defaultTextFormat = Registry.plainTFsm;
		_textInput.defaultTextFormat.align = TextFormatAlign.LEFT;
		_textInput.embedFonts = true;
		_textInput.type = TextFieldType.INPUT;
		_textInput.width = 280;
		_textInput.border = true;
		_textInput.height = 40;
		_textInput.x = 10;
		_textInput.y = 50;
		addChild(_textInput);

	}

	public function setFocus():Void
	{
		Lib.current.stage.focus = _textInput;
	}

	public function getAnswer():String
	{
		var ans:String =  StringTools.trim(_textInput.text);
		ans = ans.toLowerCase();
		return ans;
	}

	private function resetPrompt():Void
	{
		_question.text = 'What am I?';
	}

	public function wrongResponse():Void
	{
		_textInput.text = '';

		_question.text = 'Sorry, try again';

		Actuate.timer(1).onComplete(resetPrompt);
	}
}