/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.ArrayedDeque;
import de.polygonal.ds.ArrayedQueue;
import de.polygonal.ds.ArrayedStack;
import de.polygonal.ds.DLL;

import flash.display.Sprite;
import flash.utils.getTimer;

public class CompareStructures__Example {

	[Test]
	public function compareSpeed():void {

		var t:int;
		var f:int;
		var max:int=Math.pow(2, 15);
		trace("max=" + max);

		var que:ArrayedQueue=new ArrayedQueue(max << 1);
		var stk:ArrayedStack=new ArrayedStack(max << 1);
		var deq:ArrayedDeque=new ArrayedDeque(max << 1);
		var arr:Array=new Array;
		var dll:DLL=new DLL;

		//----------------------------------------------------------------
		// push
		//----------------------------------------------------------------
		t=getTimer();
		f=-1;
		while (++f < max) {
			que.enqueue(f);
		}
		trace("queue enqueue", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			stk.push(f);
		}
		trace("stack push", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			deq.pushBack(f);
		}
		trace("deque pushBack", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			deq.pushFront(f);
		}
		trace("deque pushFront", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			arr.push(f);
		}
		trace("array push", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			arr.unshift(f);
		}
		trace("array unshift", getTimer() - t);
		
		t=getTimer();
		f=-1;
		while (++f < max) {
			dll.append(f);
		}
		trace("dll append", getTimer() - t);
		
		t=getTimer();
		f=-1;
		while (++f < max) {
			dll.prepend(f);
		}
		trace("dll prepend", getTimer() - t);

		//----------------------------------------------------------------
		// out
		//----------------------------------------------------------------
		t=getTimer();
		f=-1;
		while (++f < max) {
			que.dequeue();
		}
		trace("queue dequeue", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			stk.pop();
		}
		trace("stack pop", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			deq.popBack();
		}
		trace("deque popBack", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			deq.popFront();
		}
		trace("deque popFront", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			arr.pop();
		}
		trace("array pop", getTimer() - t);

		t=getTimer();
		f=-1;
		while (++f < max) {
			arr.shift();
		}
		trace("array shift", getTimer() - t);
		
		t=getTimer();
		f=-1;
		while (++f < max) {
			dll.removeTail();
		}
		trace("dll removeTail", getTimer() - t);
		
		t=getTimer();
		f=-1;
		while (++f < max) {
			dll.removeHead();
		}
		trace("dll removeHead", getTimer() - t);
	}
}
}
