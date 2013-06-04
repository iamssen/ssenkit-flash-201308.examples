/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.Heap;
import de.polygonal.ds.Itr;

public class Heap__Example {

	[Test]
	public function basic():void {
		/*
		 * 크기 순으로 정렬된다
		 * 가장 작은 값을 가진 노드나 가장 큰 값을 가진 노드를
		 * 빠르게 찾아내기 위한 자료구조 이다.
		 */
		var heap:Heap=new Heap(10);
		var comp:VO=new VO(30);

		heap.add(new VO(1));
		heap.add(comp);
		heap.add(new VO(40));
		heap.add(new VO(35));
		trace("===============");
		trace(heap);

		// 특정 아이템을 지운다. 왜 에러가 나는걸까?
		trace(comp);
		try {
			trace(heap.remove);
			heap.remove(comp);
		} catch (err:Error) {
			trace(err);
		}

		trace(heap);

		// 가장 상위 정렬된 녀석을 읽는다 
		trace(heap.top());

		// 가장 상위 정렬된 녀석을 내보낸다 (heap 에서 지움)
		trace(heap.pop());

		// 가장 하위 정렬된 녀석을 읽는다
		trace(heap.bottom());

		// 현재 수량, 한계 수량치
		trace(heap.size(), heap.maxSize);

		var itr:Itr=Itr(heap.iterator());
		while (itr.hasNext()) {
			trace(itr.next());
		}
	}
}
}

import de.polygonal.ds.Heapable;

import ssen.common.StringUtils;

class VO implements Heapable {
	public var value:int;
	public var position:int;

	public function VO(value:int) {
		this.value=value;
	}

	public function compare(other:Object):int {
		return value - VO(other).value;
	}

	public function toString():String {
		return StringUtils.formatToString('[VO value="{0}"]', value);
	}
}
