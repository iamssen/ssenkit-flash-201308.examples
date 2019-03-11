package ssen.drawingkit {
import flash.display.Shape;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

import spark.core.SpriteVisualElement;

import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

public class EasingBox extends SpriteVisualElement {
	private var points:Vector.<P>;
	private var ball:Shape;
	private var bf:int;
	private var line:TextLine;

	//---------------------------------------------
	// ease
	//---------------------------------------------
	private var _ease:Function;

	/** ease */
	public function get ease():Function {
		return _ease;
	}

	public function set ease(value:Function):void {
		_ease=value;

		// clear graphics
		graphics.clear();

		// draw back
		graphics.beginFill(0xcccccc);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();

		// create points
		var p:P;
		var f:int=-1;
		var fmax:int=60;

		points=new Vector.<P>(fmax, true);

		while (++f < fmax) {
			p=new P;
			p.x=(f / fmax) * width;
			p.y=_ease((f / fmax) * width, height, -height, width);
			points[f]=p;

			graphics.beginFill(0x888888);
			graphics.drawCircle(p.x, p.y, 1);
			graphics.endFill();
		}
	}

	//---------------------------------------------
	// title
	//---------------------------------------------
	private var _title:String;

	/** title */
	public function get title():String {
		return _title;
	}

	public function set title(value:String):void {
		_title=value;

		// clear text
		if (line) {
			removeChild(line);
			TextLineRecycler.addLineForReuse(line);
			line=null;
		}

		if (!value) {
			return;
		}

		// print text
		var fmt:TextLayoutFormat=new TextLayoutFormat;
		fmt.fontFamily="_sans";
		fmt.fontSize=12;
		fmt.textAlign=TextAlign.CENTER;
		fmt.verticalAlign=VerticalAlign.BOTTOM;

		var fac:StringTextLineFactory=new StringTextLineFactory;
		fac.textFlowFormat=fmt;
		fac.compositionBounds=new Rectangle(0, 0, width, height + 20);
		fac.text=title;
		fac.createTextLines(function(textLine:TextLine):void {
			line=textLine;
			line.alpha=0.4;
			addChild(line);
		});
	}

	public function EasingBox() {
		width=120;
		height=80;

		// create ball
		ball=new Shape;
		ball.graphics.beginFill(0x000000);
		ball.graphics.drawCircle(0, 0, 2);
		ball.graphics.endFill();
		addChild(ball);

		bf=-1;
	}

	public function animationNext():void {
		bf++;

		if (bf >= points.length) {
			bf=0;
		}

		var p:P=points[bf];

		ball.x=p.x;
		ball.y=p.y;
	}
}
}


class P {
	public var x:Number;
	public var y:Number;
}
