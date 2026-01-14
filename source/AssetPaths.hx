import flixel.graphics.frames.FlxAtlasFrames;

class AssetPaths
{
	public static inline function png(file:String):String
		return 'assets/images/$file.png';

	public static inline function xml(file:String):String
		return 'assets/$file.xml';

	public static inline function sparrow(file:String):FlxAtlasFrames
		return FlxAtlasFrames.fromSparrow(file.png(), 'images/$file'.xml());
}
