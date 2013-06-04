package ssen.displaykit.graphics {
import flash.display.Graphics;
import flash.display.Shape;
import flash.geom.Point;

import ssen.common.MathUtils;
import ssen.devkit.ExampleCanvas;

public class MathematicalGraphics__Example extends ExampleCanvas {
	
	[Test]
	public function testXYRotation():void {
		clear();
		
		var t1:XYRotation=new XYRotation;
		t1.x=300;
		t1.y=300;
		
		canvas.addChild(t1);
	}
	
	[Test]
	public function testSineCurveMotion():void {
		clear();
		
		var ex1:SineCurveExample=new SineCurveExample;
		ex1.radius=100;
		ex1.enabledX=true;
		ex1.enabledY=true;
		ex1.x=130;
		ex1.y=130;
		canvas.addChild(ex1);
		
		var ex2:SineCurveExample=new SineCurveExample;
		ex2.radius=100;
		ex2.enabledX=true;
		ex2.enabledY=false;
		ex2.x=260;
		ex2.y=130;
		canvas.addChild(ex2);
		
		var ex3:SineCurveExample=new SineCurveExample;
		ex3.radius=100;
		ex3.enabledX=false;
		ex3.enabledY=true;
		ex3.x=390;
		ex3.y=130;
		canvas.addChild(ex3);
	}
	
	[Test]
	public function testTrigonometry1():void {
		clear();
		
		var center:Point=new Point(500, 500);
		var a:int=130;
		var b:int=200;
		var c:int=Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
		
		// a, b 를 이용한 직각 삼각형을 그린다 
		var g:Graphics=canvas.graphics;
		g.lineStyle(2);
		g.beginFill(0xffffff, 0.3);
		g.moveTo(center.x, center.y);
		g.lineTo(center.x, center.y - b);
		g.lineTo(center.x - a, center.y);
		g.lineTo(center.x, center.y);
		g.endFill();
		
		// 직각삼각형을 증명하기 위한 c 의 길이를 가진 사각형을 만든다
		var rect:Shape=new Shape;
		g=rect.graphics;
		g.lineStyle(2);
		g.beginFill(0xffffff, 0.3);
		g.drawRect(0, 0, c, c);
		g.endFill();
		
		rect.x=center.x;
		rect.y=center.y - b;
		
		// c 의 길이를 증명해보기 위해 사각형을 c 의 기울기로 기울여본다
		rect.rotation=90 - MathUtils.rad2deg(Math.atan(b / a));
		
		canvas.addChild(rect);
	}
}
}
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

import ssen.common.MathUtils;
import ssen.devkit.TestDisplayObjectFactory;

class SineCurveExample extends Sprite {
	public var radius:int;
	public var enabledX:Boolean;
	public var enabledY:Boolean;
	
	private var earth:DisplayObject;
	private var moon:DisplayObject;
	private var degree:int;
	
	public function SineCurveExample() {
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}
	
	private function addedToStageHandler(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		
		stage.frameRate=60;
		
		earth=TestDisplayObjectFactory.getCircle(5);
		moon=TestDisplayObjectFactory.getCircle(3);
		
		addChild(earth);
		addChild(moon);
		
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
	}
	
	private function enterFrameHandler(event:Event):void {
		degree+=3;
		degree%=360;
		
		var r:Number=MathUtils.deg2rad(degree);
		var x:Number=enabledX ? radius * Math.cos(r) : 0;
		var y:Number=enabledY ? radius * Math.sin(r) : 0;
		
		moon.x=x;
		moon.y=y;
	}
	
	public function removedFromStageHandler(event:Event):void {
		removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		
		stage.frameRate=24;
	}
}

class XYRotation extends Sprite {
	public var x1:int=100;
	public var y1:int=100;
	public var deg:int;
	
	public function XYRotation() {
		
		deg=MathUtils.rand(0, 360);
		
		var radius:Number=Math.sqrt(Math.pow(x1, 2) + Math.pow(y1, 2));
		var r1:Number=Math.atan(y1 / x1);
		var r2:Number=r1 - MathUtils.deg2rad(deg);
		
		var x2:int=radius * Math.cos(r2);
		var y2:int=radius * Math.sin(r2);
		
		trace("XYRotation.XYRotation()", x1, y1, x2, y2, x2 - x2, y2 - y2);
		
		trace("XYRotation.XYRotation()", MathUtils.rad2deg(r1));
		
		graphics.beginFill(MathUtils.rand(0x000000, 0xffffff));
		graphics.drawCircle(0, 0, 3);
		graphics.endFill();
		
		graphics.beginFill(MathUtils.rand(0x000000, 0xffffff));
		graphics.drawCircle(x1, y1, 3);
		graphics.endFill();
		
		graphics.beginFill(MathUtils.rand(0x000000, 0xffffff));
		graphics.drawCircle(x2, y2, 3);
		graphics.endFill();
	}
}
