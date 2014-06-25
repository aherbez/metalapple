package;

import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.geom.Point;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;

/**
 * ...
 * @author Adrian Herbez
 *
 * simple class that loads an image into a sprite w/out much fuss
 */
 
class ImgSprite extends Sprite
{
	private var _bm:Bitmap;
	
	public function new(path:String, ?defaultPath:String = null, ?cache:Bool = true) 
	{
		super();	
		var bmd:BitmapData = Assets.getBitmapData(path, cache);
		// trace('ASSETS: ');
		
		var count:Int = 0;
		/*
		for (i in Assets.cachedBitmapData.keys())
		{
			// var bd:BitmapData = cast(Assets.cachedBitmapData.get(i), BitmapData);
			
			// trace(cast(Assets.cachedBitmapData.get(i), BitmapData));
			count++;
		}
		*/
		// trace('ASSETS: ' + count + ' (loaded: ' + path + ')');

		if (bmd != null)
		{
			_bm = new Bitmap(bmd);
			// trace(_bm);
		}
		else
		{
			// trace("No bitmap data for " + path);
			_bm = new Bitmap();

			if (defaultPath != null)
			{
				trace("Opening default:" + defaultPath);
				bmd = Assets.getBitmapData(defaultPath, true);
				if (bmd != null)
				{
					_bm = new Bitmap(bmd);
				}
				else
				{
					trace("No bitmap data for default" + defaultPath);
				}
			}
		}

		addChild(_bm);
	}	
	
	public function setSize(nw:Int, nh:Int):Void
	{	
		var ratioW:Float = (nw / _bm.width);
		var ratioH:Float = (nh / _bm.height);
		
		var ratio:Float = Math.max(ratioW, ratioH);
		
		_bm.width = _bm.width * ratio;
		_bm.height = _bm.height * ratio;
	}

}
