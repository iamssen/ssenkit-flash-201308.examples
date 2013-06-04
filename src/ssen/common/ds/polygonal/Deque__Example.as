/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.ArrayedDeque;

import flash.display.Sprite;

public class Deque__Example {

	[Test]
	public function basic():void {

		var deq:ArrayedDeque=new ArrayedDeque(4);
		
		// < 전방에 값을 쌓아준다.
		deq.pushFront(1);
		deq.pushFront(2);
		deq.pushFront(3);
		trace(deq);
		
		// < 최전방값, > 최후방값
		trace(deq.front(), deq.back());
		
		// > 후방에 값을 쌓아준다.
		deq.pushBack(9);
		trace(deq.front(), deq.back());
		
		// < 전방의 값을 삭제해준다.
		deq.popFront();
		
		// > 후방의 값을 삭제해준다.
		deq.popBack();
		
		trace("DequeExample.test()", deq.size());
		
		//		deq.size(), deq.
		//		trace(deq._size, deq._count);
		//		deq.popBack();
		//		trace(deq._size, deq._count);
		//		deq.popBack();
		//		trace(deq._size, deq._count);
		//deq.popBack();
		//		trace(deq._size, deq._count);
		//		deq.popBack();
		//		deq.popBack();
		//		deq.popBack();
		//		deq.popBack();
		//		trace(deq.front(), deq.back());
	}
}
}
