class ApplicationMain
{

	#if waxe
	static public var frame : wx.Frame;
	static public var autoShowFrame : Bool = true;
	#if nme
	static public var nmeStage : wx.NMEStage;
	#end
	#end
	
	public static function main()
	{
		#if nme
		nme.Lib.setPackage("Company Name", "Tablet", "com.example.tablet", "1.0.0");
		
		#end
		
		#if waxe
		wx.App.boot(function()
		{
			
			frame = wx.Frame.create(null, null, "Tablet", null, { width: 600, height: 800 });
			
			#if nme
			var stage = wx.NMEStage.create(frame, null, null, { width: 600, height: 800 });
			#end
			
			Main.main();
			
			if (autoShowFrame)
			{
				wx.App.setTopWindow(frame);
				frame.shown = true;
			}
		});
		#else
		
		nme.Lib.create(function()
			{ 
				//if ((600 == 0 && 800 == 0) || false)
				//{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				//}
				
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
					#if nme
					if (Std.is (instance, nme.display.DisplayObject)) {
						nme.Lib.current.addChild(cast instance);
					}
					#end
				}
			},
			600, 800, 
			30, 
			16777215,
			(true ? nme.Lib.HARDWARE : 0) |
			(false ? nme.Lib.ALLOW_SHADERS : 0) |
			(false ? nme.Lib.REQUIRE_SHADERS : 0) |
			(false ? nme.Lib.DEPTH_BUFFER : 0) |
			(false ? nme.Lib.STENCIL_BUFFER : 0) |
			(false ? nme.Lib.RESIZABLE : 0) |
			(false ? nme.Lib.BORDERLESS : 0) |
			(false ? nme.Lib.VSYNC : 0) |
			(false ? nme.Lib.FULLSCREEN : 0) |
			(0 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(0 == 2 ? nme.Lib.HW_AA : 0),
			"Tablet"
			
		);
		#end
		
	}
	
	
	#if neko
	public static function __init__ () {
		
		untyped $loader.path = $array ("@executable_path/", $loader.path);
		
	}
	#end
	
	
	public static function getAsset(inName:String):Dynamic
	{
		#if nme
		
		if (inName == "assets/background.jpg")
		{
			
			return nme.Assets.getBitmapData ("assets/background.jpg");
			
		}
		
		if (inName == "assets/Dethek_Stone.ttf")
		{
			
			return nme.Assets.getFont ("assets/Dethek_Stone.ttf");
			
		}
		
		if (inName == "assets/glass.png")
		{
			
			return nme.Assets.getBitmapData ("assets/glass.png");
			
		}
		
		if (inName == "assets/glass2.png")
		{
			
			return nme.Assets.getBitmapData ("assets/glass2.png");
			
		}
		
		if (inName == "assets/magglass.png")
		{
			
			return nme.Assets.getBitmapData ("assets/magglass.png");
			
		}
		
		if (inName == "assets/news.ttf")
		{
			
			return nme.Assets.getFont ("assets/news.ttf");
			
		}
		
		if (inName == "assets/Windlass.ttf")
		{
			
			return nme.Assets.getFont ("assets/Windlass.ttf");
			
		}
		
		#end
		return null;
	}
	
	
}
