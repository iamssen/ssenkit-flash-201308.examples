/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.Itr;
import de.polygonal.ds.pooling.ObjectPool;

import flash.display.Sprite;
import flash.utils.getTimer;

public class ObjectPool__Example {

	[Test]
	public function compareWithNewAndObjectPool():void {
		var f:int;
		var max:int=50000;
		var t:int;
		var o:Obj;

		// 순수한 new 를 통한 생성과 null 처리 
		t=getTimer();
		f=-1;
		while (++f < max) {
			o=new Obj();
			o=null;
		}
		trace("new", getTimer() - t);

		// object pool 을 사용한 생성과 반환 처리 
		t=getTimer();
		f=-1;
		while (++f < max) {
			o=getObject();
			putObject(o);
		}
		trace("pool", getTimer() - t);
	}

	[Test]
	public function allocateWithFactory():void {
		var pool:ObjectPool=new ObjectPool(8);

		// by new Class();
		// pool.allocate(Dummy);

		// by factory method
		// pool.allocate(null, factoryMethod);

		// by Factory class instance
		pool.allocate(true, null, null, new DummyFactory);
	}

	private function factoryMethod():Obj {
		var dummy:Obj=new Obj;
		dummy.a=10;
		dummy.b=10;
		dummy.c="created from Factory method";
		return dummy;
	}

	//----------------------------------------------------------------
	// pooling
	//----------------------------------------------------------------
	private var _pool:ObjectPool;

	public function getObject():Obj {
		if (!_pool) {
			_pool=new ObjectPool(10);
			_pool.allocate(true, Obj);
		}

		try {
			var pid:int=_pool.next();
			var obj:Obj=Obj(_pool.get(pid));
			obj.pid=pid;
			return obj;
		} catch (error:Error) {
			return null;
		}
		return null;
	}

	public function putObject(obj:Obj):void {
		_pool.put(obj.pid);
	}

	public function freePool():void {
		var itr:Itr=Itr(_pool.iterator());
		var obj:Obj;

		while (itr.hasNext()) {
			// dispose obj
			obj=Obj(itr.next());
		}

		_pool.free();
		_pool=null;
	}
}
}

import de.polygonal.ds.Factory;

import flash.geom.Point;

import ssen.common.StringUtils;

class Obj extends Point {
	public var pid:int;
	public var a:int;
	public var b:int;
	public var c:String;

	override public function toString():String {
		return StringUtils.formatToString('[Dummy id="{0}" a="{1}" b="{2}" c="{3}"]', pid, a, b, c);
	}
}

//----------------------------------------------------------------
// factory class
//----------------------------------------------------------------
class DummyFactory implements Factory {
	public function create():Object {
		var dummy:Obj=new Obj;
		dummy.a=10;
		dummy.b=10;
		dummy.c="created from Factory";
		return dummy;
	}
}
