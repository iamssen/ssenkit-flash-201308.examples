/// example
package ssen.displaykit.graphics {
import flash.display.Bitmap;
import flash.filters.ColorMatrixFilter;
import flash.geom.Rectangle;

import ssen.devkit.ExampleCanvas;

public class ColorMatrixFilter__Example extends ExampleCanvas {

	[Embed(source="assets/photo1.jpg")]
	public static var Image1:Class;

	[Embed(source="assets/photo2.jpg")]
	public static var Image2:Class;

	[Embed(source="assets/photo3.jpg")]
	public static var Image3:Class;

	[Embed(source="assets/photo4.jpg")]
	public static var Image4:Class;

	public static const GRAY:Array=[0.364148, 0.7190920000000002, 0.09676000000000001, 0, -1.4300000000000068, 0.364148, 0.7190920000000002,
									0.09676000000000001, 0, -1.4300000000000068, 0.364148, 0.7190920000000002, 0.09676000000000001, 0,
									-1.4300000000000068, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
	public static const DISABLE:Array=[0.1701368, 0.572128, 0.0577352, 0, 102.1, 0.1701368, 0.572128, 0.0577352, 0, 102.1, 0.1701368,
									   0.572128, 0.0577352, 0, 102.1, 0, 0, 0, 1, 0];
	public static const DARK_LOW:Array=[0.8425342, 0.143032, 0.0144338, 0, -38.25, 0.0425342, 0.943032, 0.0144338, 0, -38.25, 0.0425342,
										0.143032, 0.8144338, 0, -38.25, 0, 0, 0, 1, 0];
	public static const DARK:Array=[0.6063355, 0.35758, 0.0360845, 0, -102, 0.1063355, 0.85758, 0.0360845, 0, -102, 0.1063355, 0.35758,
									0.5360845, 0, -102, 0, 0, 0, 1, 0];

	[Test]
	public function favorites():void {
		var colormats:Vector.<Array>=new <Array>[GRAY, DISABLE, DARK_LOW, DARK];
		var bitmaps:Vector.<Class>=new <Class>[Image1, Image2, Image3, Image4];
		var bitmap:Bitmap;
		var cls:Class;
		var container:FilterSprite;

		var max:Rectangle=new Rectangle(0, 0, 1000, 200);
		var ratio:Number;

		var nx:int=0;
		var ny:int=0;

		var f:int=-1;
		var fmax:int=colormats.length;
		var s:int;
		var smax:int;

		while (++f < fmax) {

			s=-1;
			smax=bitmaps.length;

			container=new FilterSprite;

			while (++s < smax) {
				cls=bitmaps[s];
				bitmap=new cls();

				ratio=GeomUtils.getResizeRatio(bitmap.getRect(this), max);
				if (ratio !== 1) {
					bitmap.scaleX=bitmap.scaleY=ratio;
				}
				bitmap.x=nx;
				container.addChild(bitmap);

				nx+=bitmap.width;
			}

			container.setColorMatrixFilter(colormats[f]);
			container.x=10;
			container.y=ny;
			canvas.addChild(container);

			nx=0;
			ny+=bitmap.height;
		}
	}
}
}
import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;

class FilterSprite extends Sprite {
	private var _arr:Array;

	public function setColorMatrixFilter(arr:Array):void {
		_arr=arr;
		filters=[new ColorMatrixFilter(arr)];
		addEventListener(MouseEvent.CLICK, clickHandler);
	}

	private function clickHandler(event:MouseEvent):void {
		Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, "new ColorMatrixFilter([" + _arr.toString() + "])");
	}
}
