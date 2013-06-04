/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.ArrayedQueue;
import de.polygonal.ds.Itr;
import de.polygonal.ds.LinkedQueue;

import flash.display.Sprite;
import flash.utils.getTimer;

public class Queue__Example {

	/*
	 * queue 구조는 줄서기를 기준으로 알 수 있다.
	 * abcde 의 처리순서 중에서 abc 가 빠진 이후, 이후 fg 가 붙는다면
	 * defg 의 순서가 되게 된다...
	 *
	 * 선입선출
	 */
	[Test]
	public function arrayedQueue():void {
		var que:ArrayedQueue=new ArrayedQueue(4);

		// 후방에 값을 추가시켜준다.
		que.enqueue(1);
		que.enqueue(2);
		que.enqueue(3);
		que.enqueue(4);
		trace(que);

		// iterator
		var itr:Itr=Itr(que.iterator());
		while (itr.hasNext()) {
			trace("iterator", itr.next());
		}
		// 최종값에서 next 를 할 경우 다시 최전방 값이 들어오게 된다.
		trace(itr.next());


		// 전방에 값을 삭제시켜준다.
		que.dequeue();
		trace(que);

		// 전방 값을 가져온다.
		trace(que.peek());

		// 후방 값을 가져온다.
		trace(que.back());
		trace(que);
		trace(que.peek());

		// que 의 총 사이즈를 가져온다.
		trace(que.size());

		// que 의 특정 순서의 값을 변경해준다.
		que.set(2, 8);
		trace(que);

		// que 의 특정 순서와 순서의 값을 서로 교환해준다.
		que.swp(0, 2);
		trace(que);
	}

	[Test]
	public function linkedQueue():void {
		var lqe:LinkedQueue=new LinkedQueue(4);

		// 후방에 값을 추가시켜준다.
		lqe.enqueue(1);
		lqe.enqueue(2);
		lqe.enqueue(3);
		lqe.enqueue(4);
		trace(lqe);

		// iterator
		var itr2:Itr=Itr(lqe.iterator());
		while (itr2.hasNext()) {
			trace("iterator", itr2.next());
		}
		// 최종값에서 next 를 할 경우 다시 최전방 값이 들어오게 된다.
		trace(itr2.hasNext());


		// 전방에 값을 삭제시켜준다.
		lqe.dequeue();
		trace(lqe);

		// 전방 값을 가져온다.
		trace(lqe.peek());

		// 후방 값을 가져온다.
		trace(lqe.back());
		trace(lqe);
		trace(lqe.peek());

		// lqe 의 총 사이즈를 가져온다.
		trace(lqe.size());
	}

	[Test]
	public function compareArrayedAndLinked():void {
		var que:ArrayedQueue;
		var lqe:LinkedQueue;

		/* *********************************************************************
		 * linked 보다 arrayed 가 훨씬 더 빠르다...
		 ********************************************************************* */
		var max:int=1 << 12;
		trace(max);
		que=new ArrayedQueue(max);

		var t:int=getTimer();
		var f:int=-1;
		while (++f < max) {
			que.enqueue(f);
		}

		trace("arrayed queue enqueue", getTimer() - t, que.size());

		t=getTimer();
		f=-1;
		while (++f < max) {
			que.dequeue();
		}
		trace("arrayed queue dequeue", getTimer() - t, que.size());

		lqe=new LinkedQueue(max);

		t=getTimer();
		f=-1;
		while (++f < max) {
			lqe.enqueue(f);
		}

		trace("linked queue enqueue", getTimer() - t, lqe.size());

		t=getTimer();
		f=-1;
		while (++f < max) {
			lqe.dequeue();
		}
		trace("linked queue dequeue", getTimer() - t, lqe.size());
	}
}
}
