package flxstep.backend;

import flixel.graphics.FlxGraphic;
import openfl.Assets;
import openfl.display.BitmapData;

class Paths
{
	public static var bitmapCache:Map<String, FlxGraphic> = new Map();

	public static inline function cacheBitmap(key:String, gpuCache:Bool = true):FlxGraphic
	{
		var path = getPath('images/$key.png');

		if (bitmapCache.exists(path))
			return bitmapCache.get(path);
		if (Assets.exists(path))
		{
			var bitmap:BitmapData = Assets.getBitmapData(path);
			if (gpuCache)
				bitmap.disposeImage();
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap);
			graphic.bitmap.disposeImage();
			graphic.persist = true;
			trace('[CACHE/BITMAP]: Succesfully loaded  bitmap "$path" into the cache.');

			bitmapCache.set(path, graphic);
			return graphic;
		}

		trace(path + " doesn't exist (NULL) NOOOOOOOOO");
		return null;
	}

	inline static public function image(key:String):FlxGraphic
	{
		var bitmap:FlxGraphic = cacheBitmap(key);

		return bitmap;
	}

	inline static public function getPath(key:String)
		return getPreloadPath(key);

	inline static public function json(key:String)
		return getPath('data/$key.json');

	inline static public function ogmo(key:String)
		return getPath('data/$key.ogmo');

	inline static public function getPreloadPath(key:String)
		return return 'assets/$key';
}
