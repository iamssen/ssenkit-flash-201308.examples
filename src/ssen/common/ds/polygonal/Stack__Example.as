/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.Itr;
import de.polygonal.ds.ArrayedStack;

import flash.display.Sprite;

public class Stack__Example {

	[Test]
	public function basic():void {
		var stk:ArrayedStack=new ArrayedStack();

		// top 에 값을 추가해준다.
		stk.push(1);
		stk.push(2);
		stk.push(3);
		stk.push(4);

		trace(stk);

		var itr:Itr=Itr(stk.iterator());
		while (itr.hasNext()) {
			trace(itr.next());
		}

		trace(stk);

		// top 에 존재하는 값을 읽는다. (단순 읽기)
		trace(stk.top());

		// stack 자체에는 변화가 없다
		trace(stk);

		// top 의 위치에 있는 값을 가져온다. (빼면서 읽기)
		trace(stk.pop());

		// 최상단의 값이 제거된 것을 확인
		trace(stk);

		// 특정 id 와 id 의 값을 교체해준다
		stk.swp(0, 1);
		trace(stk);

		// 특정 아이디의 값을 교체한다
		stk.set(0, 1000);

		// 특정 아이디의 값을 읽는다
		trace(stk.get(0));

		// 역시 stack 에는 변화가 없다
		trace(stk);
		
	}
}
}
