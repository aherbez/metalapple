#if nme

import Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		#if !fdb
		haxe.Log.trace = flashTrace;
		#end
		
		if (call_real)
			begin ();
	}

	#if !fdb
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;
		
        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	#end
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
		}
		else
		{
			var instance = Type.createInstance(Main, []);
			if (Std.is (instance, nme.display.DisplayObject)) {
				nme.Lib.current.addChild(cast instance);
			}	
		}
		
	}

	static function onEnter (_) {
		
		var loaded = nme.Lib.current.loaderInfo.bytesLoaded;
		var total = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="assets/background.jpg")
			 
            return Assets.getBitmapData ("assets/background.jpg");
         
		
		if (inName=="assets/Dethek_Stone.ttf")
			 
			 return Assets.getFont ("assets/Dethek_Stone.ttf");
		 
		
		if (inName=="assets/envelop.png")
			 
            return Assets.getBitmapData ("assets/envelop.png");
         
		
		if (inName=="assets/glass.png")
			 
            return Assets.getBitmapData ("assets/glass.png");
         
		
		if (inName=="assets/glass2.png")
			 
            return Assets.getBitmapData ("assets/glass2.png");
         
		
		if (inName=="assets/letterpage.png")
			 
            return Assets.getBitmapData ("assets/letterpage.png");
         
		
		if (inName=="assets/magglass.png")
			 
            return Assets.getBitmapData ("assets/magglass.png");
         
		
		if (inName=="assets/news.ttf")
			 
			 return Assets.getFont ("assets/news.ttf");
		 
		
		if (inName=="assets/Windlass.ttf")
			 
			 return Assets.getFont ("assets/Windlass.ttf");
		 
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}

class NME_assets_background_jpg extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_dethek_stone_ttf extends nme.text.Font { }
class NME_assets_envelop_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_glass_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_glass2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_letterpage_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_magglass_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_news_ttf extends nme.text.Font { }
class NME_assets_windlass_ttf extends nme.text.Font { }


#else

import Main;

class ApplicationMain {
	
	public static function main () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
		}
		else
		{
			var instance = Type.createInstance(Main, []);
			if (Std.is (instance, flash.display.DisplayObject)) {
				flash.Lib.current.addChild(cast instance);
			}
		}
		
	}

}

#end
