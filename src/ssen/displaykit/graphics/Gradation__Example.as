/// example
package ssen.displaykit.graphics {
import flash.geom.Rectangle;

import ssen.common.MathUtils;
import ssen.devkit.ExampleCanvas;
import ssen.devkit.TestDataFactory;

public class Gradation__Example extends ExampleCanvas {

	[Test]
	public function getGradationColors():void {
		clear();

		var g:Vector.<RGB>=Gradation.getGradationColors(new RGB(MathUtils.rand(0x000000, 0xffffff)),
																			   new RGB(MathUtils.rand(0x000000, 0xffffff)), 70,
																			   TestDataFactory.getRandomEaseFunction());
		var rgb:RGB;
		var r:Rectangle=new Rectangle(10, 10, 10, 100);

		var f:int=-1;
		var fmax:int=g.length;
		while (++f < fmax) {
			rgb=g[f];
			canvas.graphics.beginFill(rgb.toHex());
			canvas.graphics.drawRect(r.x, r.y, r.width, r.height);
			canvas.graphics.endFill();

			r.x+=r.width;
		}
	}

	[Test]
	public function getGradationColor():void {
		clear();

		var ease:Function=TestDataFactory.getRandomEaseFunction();

		var start:RGB=new RGB(0x000000);
		var end:RGB=new RGB(0xffffff);
		var rgb:RGB;

		var r:Rectangle=new Rectangle(10, 10, 10, 100);

		var f:int=-1;
		var fmax:int=70;
		var p:Number;

		while (++f <= fmax) {
			p=ease(f, 0, 1, fmax);
			rgb=Gradation.getGradationColor(start, end, p * fmax, fmax);

			canvas.graphics.beginFill(rgb.toHex());
			canvas.graphics.drawRect(r.x, r.y, r.width, r.height);
			canvas.graphics.endFill();

			r.x+=r.width;
		}
	}
}
}
