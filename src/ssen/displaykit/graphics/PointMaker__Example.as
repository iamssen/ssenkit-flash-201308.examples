/// example
package ssen.displaykit.graphics {
import ssen.devkit.ExampleCanvas;
import ssen.devkit.TestDataFactory;

public class PointMaker__Example extends ExampleCanvas {

	[Test]
	public function quadraticBezier():void {
		clear();

		var p1:XY=new XY(10, 200);
		var p2:XY=new XY(200, 10);
		var c:XY=new XY(10, 10);

		var f:int=-1;
		var fmax:int=20;

		var xy:XY;

		var rgb1:RGB=new RGB(0xaaaaaa);
		var rgb2:RGB=new RGB(0x000000);

		while (++f <= fmax) {
			xy=PointMaker.quadraticBezier(p1, p2, c, f, fmax);

			canvas.graphics.beginFill(Gradation.getGradationColor(rgb1, rgb2, f, fmax).toHex());
			canvas.graphics.drawCircle(xy.x, xy.y, 2);
			canvas.graphics.endFill();
		}
	}

	[Test]
	public function quadraticBeziers():void {
		clear();

		var p1:XY=new XY(10, 200);
		var p2:XY=new XY(200, 10);
		var c:XY=new XY(10, 10);

		var xys:Vector.<XY>=PointMaker.quadraticBeziers(p1, p2, c, 20, TestDataFactory.getRandomEaseFunction());
		var xy:XY;

		var rgb1:RGB=new RGB(0xaaaaaa);
		var rgb2:RGB=new RGB(0x000000);

		var f:int=-1;
		var fmax:int=xys.length;
		while (++f < fmax) {
			xy=xys[f];

			trace("PointMakerExample.quadraticBeziers()", f, xy);

			canvas.graphics.beginFill(Gradation.getGradationColor(rgb1, rgb2, f, fmax).toHex());
			canvas.graphics.drawCircle(xy.x, xy.y, 2);
			canvas.graphics.endFill();
		}
	}
}
}
