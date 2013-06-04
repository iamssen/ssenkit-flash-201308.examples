/// example
package ssen.displaykit.graphics {
import flash.events.Event;

import gs.easing.*;

import ssen.devkit.ExampleCanvas;

public class Easing__Example extends ExampleCanvas {
	private var boxes:Vector.<EasingBox>;

	[Test]
	public function printEasingSamples():void {
		var box:EasingBox;
		var eases:Vector.<Function>=new <Function>[Back.easeIn, Back.easeInOut, Back.easeOut, Bounce.easeIn, Bounce.easeInOut,
												   Bounce.easeOut, Circ.easeIn, Circ.easeInOut, Circ.easeOut, Cubic.easeIn, Cubic.easeInOut,
												   Cubic.easeOut, Elastic.easeIn, Elastic.easeInOut, Elastic.easeOut, Expo.easeIn,
												   Expo.easeInOut, Expo.easeOut, Quad.easeIn, Quad.easeInOut, Quad.easeOut, Quart.easeIn,
												   Quart.easeInOut, Quart.easeOut, Quint.easeIn, Quint.easeInOut, Quint.easeOut,
												   Sine.easeIn, Sine.easeInOut, Sine.easeOut, Linear.easeNone];

		var names:Vector.<String>=new <String>["Back.easeIn", "Back.easeInOut", "Back.easeOut", "Bounce.easeIn", "Bounce.easeInOut",
											   "Bounce.easeOut", "Circ.easeIn", "Circ.easeInOut", "Circ.easeOut", "Cubic.easeIn",
											   "Cubic.easeInOut", "Cubic.easeOut", "Elastic.easeIn", "Elastic.easeInOut", "Elastic.easeOut",
											   "Expo.easeIn", "Expo.easeInOut", "Expo.easeOut", "Quad.easeIn", "Quad.easeInOut",
											   "Quad.easeOut", "Quart.easeIn", "Quart.easeInOut", "Quart.easeOut", "Quint.easeIn",
											   "Quint.easeInOut", "Quint.easeOut", "Sine.easeIn", "Sine.easeInOut", "Sine.easeOut",
											   "Linear.easeNone"];

		var f:int=-1;
		var fmax:int=eases.length;

		var h:int=0;
		var v:int=0;
		var width:int=140;
		var height:int=140;

		boxes=new Vector.<EasingBox>(eases.length, true);

		while (++f < fmax) {
			box=new EasingBox;
			box.x=(h * (width + 10)) + 30;
			box.y=(v * (height + 70)) + 30;
			box.begin(canvas, names[f], eases[f], width, height);
			boxes[f]=box;

			h++;

			if (h > 8) {
				h=0;
				v++;
			}
		}

		stage.frameRate=60;
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
	}

	private function removeFromStageHandler(event:Event):void {
		clear();
	}

	override protected function clear():void {
		if (boxes !== null) {
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);

			var f:int=boxes.length;
			while (--f >= 0) {
				canvas.removeChild(boxes[f]);
				boxes[f].dispose();
			}

			boxes=null;
			
			stage.frameRate=24;
		}

		super.clear();
	}



	private function enterFrameHandler(event:Event):void {
		var f:int=boxes.length;
		while (--f >= 0) {
			boxes[f].animationNext();
		}
	}
}
}
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;

import gs.easing.Quad;


class EasingBox extends Sprite {
	private var title:String;
	private var ease:Function;
	private var w:int;
	private var h:int;
	private var points:Vector.<P>;

	private var ball:Shape;
	private var container:DisplayObjectContainer;
	private var bf:int;
	private var line:TextLine;

	public function begin(container:DisplayObjectContainer, title:String, ease:Function, w:int, h:int):void {
		this.container=container;
		this.title=title;
		this.ease=ease;
		this.w=w;
		this.h=h;

		// draw back
		graphics.beginFill(0xcccccc);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();

		// create points
		var p:P;
		points=new Vector.<P>(w, true);

		var f:int=-1;
		var fmax:int=w;

		while (++f < fmax) {
			p=new P;
			p.x=f;
			p.y=ease(f, h, -h, fmax);
			points[f]=p;

			graphics.beginFill(0x999999);
			graphics.drawCircle(p.x, p.y, 1);
			graphics.endFill();
		}

		// create ball
		ball=new Shape;
		ball.graphics.beginFill(0x000000);
		ball.graphics.drawCircle(0, 0, 2);
		ball.graphics.endFill();
		addChild(ball);

		// print text
		var fmt:TextLayoutFormat=new TextLayoutFormat;
		fmt.fontFamily="_sans";
		fmt.textAlign=TextAlign.CENTER;

		var fac:StringTextLineFactory=new StringTextLineFactory;
		fac.textFlowFormat=fmt;
		fac.compositionBounds=new Rectangle(0, h + 5, w, 100);
		fac.text=title;
		fac.createTextLines(function(textLine:TextLine):void {
			line=textLine;
			addChild(line);
		});

		// added
		container.addChild(this);

		// start anmation

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

	public function dispose():void {
		TextLineRecycler.addLineForReuse(line);
		removeChild(line);
		line=null;
		ease=null;
		points=null;
	}
}

class P {
	public var x:Number;
	public var y:Number;
}
