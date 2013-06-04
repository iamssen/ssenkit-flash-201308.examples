/// Example
package ssen.common.ds.polygonal {

public class LinkedObjectPool__Example {

	[Test]
	public function basic():void {
		var f:int=-1;
		var max:int=100;
		while (++f < max) {
			VO.get();
		}
	}
}
}

import de.polygonal.ds.pooling.LinkedObjectPool;

class VO {
	/* *********************************************************************
	 * pooling
	 ********************************************************************* */
	private static var _pool:LinkedObjectPool;

	public static function get():VO {
		if (!_pool) {
			_pool=new LinkedObjectPool(5, true);
			_pool.allocate(VO);
		}
		var obj:VO=VO(_pool.get());
		trace(_pool.getUsageCount(), _pool.getWasteCount(), _pool.getSize());
		return obj;
	}

	public static function put(obj:VO):void {
		_pool.put(obj);
	}

	public static function free():void {
		_pool.free();
		_pool=null;
	}
}
