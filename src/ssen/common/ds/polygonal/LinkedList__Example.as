/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.DLL;
import de.polygonal.ds.DLLNode;
import de.polygonal.ds.SLL;
import de.polygonal.ds.SLLNode;

import flash.display.Sprite;
import flash.utils.getTimer;

public class LinkedList__Example {

	[Test]
	public function loopingAndParentList():void {
		var sll:SLL=new SLL();
		sll.append("node1");
		sll.append("node2");
		sll.append("node3");
		sll.append("node4");
		sll.append("node5");

		var node:SLLNode=sll.head;

		while (node != null) {
			// val 은 node 에 저장된 값이고,
			// hsaNext 는 다음 node 가 있는지 여부
			// nextVal 은 다음 node 의 값이 됩니다
			trace(node, node.val, node.hasNext(), !node.hasNext() || node.nextVal());
			node=node.next;
		}

		node=sll.getNodeAt(2);

		// node 가 속해있는 linked list 를 가져옵니다
		trace(node, node.getList());

		// node 를 linked list 상에서 삭제합니다
		node.unlink();
		trace(node.getList());

		trace(sll);
	}

	[Test]
	public function nodeControl():void {
		var sll:SLL=new SLL();
		sll.append("node1");
		sll.append("node2");
		sll.append("node3");

		var sll2:SLL=new SLL();
		sll2.append("node4");
		sll2.append("node5");

		// linked list 의 후방에 새로운 linked list 의 node 들을 덧붙임
		// Array.concat 과 유사
		trace(sll.concat(sll2));

		// linked list 상에 해당 값의 node 가 있는지를 확인
		trace(sll.contains("node2"), sll.contains("node4"));

		// linked list 의 node 갯수와 제한된 maxSize 를 확인 
		trace(sll.size(), sll.maxSize);

		// linked list 의 구성물들을 문자열로 합침
		trace(sll.join("|||"));

		trace(sll);

		// 최전방의 노드를 최후방으로 이동
		sll.shiftUp();
		trace(sll);

		// 최후방의 노드를 최전방으로 이동
		sll.popDown();
		trace(sll);

		// linked list 의 순서를 뒤집기
		sll.reverse();
		trace(sll);

		// linked list 의 순서를 무작위로 변환
		sll.shuffle();
		trace(sll);
		sll.shuffle();
		trace(sll);
	}

	[Test]
	public function find():void {
		var sll:SLL=new SLL();
		sll.append("node1");
		sll.append("node2");
		sll.append("node3");
		sll.append("node4");
		sll.append("node5");

		// 최전방 node
		trace(sll.head);

		// 최후방 node
		trace(sll.tail);

		// 0 을 기준으로 한 3번째 node
		trace(sll.getNodeAt(2));

		// node 의 값을 기준으로 검색
		trace(sll.nodeOf("node3", sll.head));
	}

	[Test]
	public function appendAndRemove():void {
		// new SLL(maxSize) maxSize 를 넣게 되면,
		// 그 이상의 입력이 들어올 경우 에러를 내뱉음
		var sll:SLL=new SLL(10);

		// 후방에 새로운 값을 추가해서 node 를 만든다
		// append():SLLNode 를 리턴
		trace(sll.append(1));
		trace(sll.append(2));
		trace(sll.append(3));

		// 전방에 새로운 값을 추가해서 node 를 만든다
		trace(sll.prepend("a"));
		trace(sll.prepend("b"));
		trace(sll.prepend("c"));

		trace(sll);

		// 최전방에 있는 node 를 지워주고, 값을 반환
		trace(sll.removeHead());

		// 최후방에 있는 node 를 지워주고, 값을 반환
		trace(sll.removeTail());

		trace(sll);
	}

	[Test]
	public function insertBeforeAndAfter():void {
		var sll:SLL=new SLL(10);
		sll.append(1);

		var node:SLLNode=sll.append(2);
		sll.append(3);

		trace(sll);

		// node 의 뒷쪽에 값을 추가
		sll.insertAfter(node, new SLLNode("after"));

		// node 의 앞쪽에 값을 추가
		sll.insertBefore(node, new SLLNode("before"));

		trace(sll);

		// node 를 linked list 에서 삭제
		sll.remove(node);

		trace(sll);
	}

	[Test]
	public function basic():void {
		var max:int=1 << 10;

		// node.prev 가 지원되는 양방향형 linked list
		var dll:DLL=new DLL(max);

		// node.prev 가 지원되지 않는 단방향형 linked list
		var sll:SLL=new SLL(max);

		var f:int=-1;
		while (++f < max) {
			dll.append(f);
			sll.append(f);
		}
		
		trace(dll);
		trace(sll);
		
		var dn:DLLNode=dll.getNodeAt(0);
		var sn:SLLNode=sll.getNodeAt(0);

		// 특정 노드 뒤에 새로운 값을 추가한다.
		dll.insertAfter(dn, 5);

		// 특정 노드 앞에 새로운 값을 추가한다.
		dll.insertBefore(dn, 6);

		// 특정 순서의 노드를 가져온다.
		trace(dll.getNodeAt(10));

		// 맨 앞의 노드를 가져온다.
		trace(dll.head);

		// 맨 뒤의 노드를 가져온다.
		trace(dll.tail);
		
		var t:int;

		t=getTimer();
		while (dn.hasNext()) {
			dn=dn.next;
		}
		trace(getTimer() - t);

		t=getTimer();
		while (sn.hasNext()) {
			sn=sn.next;
		}
		trace(getTimer() - t);
	}
}
}
