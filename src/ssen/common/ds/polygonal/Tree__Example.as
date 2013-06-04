/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.Itr;
import de.polygonal.ds.TreeBuilder;
import de.polygonal.ds.TreeNode;

import ssen.common.MathUtils;

public class Tree__Example {
	private var tree:TreeBuilder;
	private var r:TreeNode;

	public function basic():void {
		r=new TreeNode("tree root");

		tree=new TreeBuilder(r);

		/* *********************************************************************
		 * child 추가 / 삭제
		 ********************************************************************* */
		// v child 의 맨 마지막에 node 를 추가 (절대적으로 마지막에 추가)
		tree.appendChild("next node");

		// h child 의 다음에 node 를 추가 (상대적으로 다음에 추가) 
		tree.insertAfterChild("insert after node");

		// h child 의 이전에 node 를 추가 (상대적으로 이전에 추가)
		tree.insertBeforeChild("insert before node");

		// v child 의 맨 처음에 node 를 추가 (절대적으로 맨 앞에 추가)
		tree.prependChild("prev node1");

		tree.appendChild("next node2");
		trace(tree.childValid());

		// 현재 pointer 가 위치한 child 를 삭제시킴
		tree.removeChild();
		trace(tree.childValid());

		// remove child 를 시키면 h 포인터가 null 이 되어 버린다.
		// 그러므로 nextChild 나 prevChild 에서 에러가 나고, childStart 나 childEnd 로 처리하는게 좋다.
		trace(tree.getChildNode());
		tree.appendChild("next node3");

		/* *********************************************************************
		 * 인증
		 ********************************************************************* */
		// 현재 node 가 멀쩡한지 확인
		trace(tree.valid());

		// 현재 child node 가 멀쩡한지 확인
		trace(tree.childValid());

		/* *********************************************************************
		 * 읽기
		 ********************************************************************* */
		// vertical node를 가져온다.
		trace(tree.getNode());

		// vertical node value 를 가져온다.
		trace(tree.getVal());

		// h child node 를 가져온다.
		trace(tree.getChildNode());

		// h child node value 를 가져온다.
		trace(tree.getChildVal());

		/* *********************************************************************
		 * v pointer 이동
		 ********************************************************************* */
		// child 로 내려간다
		tree.down();
		tree.appendChild("child node");

		// parent 로 올라간다
		tree.up();

		// 최상위 root 로 올라간다
		// tree.root()
		tree.appendChild("next node4");
		tree.prependChild("prev node2");

		/* *********************************************************************
		 * h pointer 이동
		 ********************************************************************* */
		// child 의 최초 시작점으로 h 포인터를 이동시킴 (절대)
		tree.childStart();

		// child 의 마지막으로 h 포인터를 이동시킴 (절대)
		tree.childEnd();

		// 다음 child 를 선택 (상대)
		tree.nextChild();

		// 이전 child 를 선택 (상대)
		tree.prevChild();
		treestr(r);


		trace("===================================");

		tree.root();
		tree.childStart();

		var node:TreeNode=tree.getNode();
		/* *********************************************************************
		 * node 관련 작업
		 ********************************************************************* */
		// node 의 value 를 읽는다
		trace(node.val);

		// node 의 depth 를 읽는다
		trace(node.depth());

		// tree builder 를 가져온다
		trace(node.getBuilder());

		/* *********************************************************************
		 * parent / children 관련 작업
		 ********************************************************************* */
		// children 의 첫번째 노드를 읽는다
		trace(node.children.val);

		// children 의 마지막 노드를 읽는다
		trace(node.getLastChild().val);

		// children 의 value 를 검색해서 node 를 가져온다
		trace(node.find("prev node1").val);

		// 최상위 root parent 를 가져온다
		trace(node.getRoot().val);

		// children 의 갯수를 읽는다
		trace(node.getChildIndex());

		// children 이 있는지 확인
		trace(node.hasChildren());

		// parent 가 있는지 확인
		trace(node.hasParent());

		/* *********************************************************************
		 * 형제 node 관련 작업
		 ********************************************************************* */
		node=node.children.next.next;
		trace("???", node.val);

		// 형제 노드들 중 첫번째 노드를 읽는다 (절대)
		trace(node.getFirstSibling().val);

		// 형제 노드들 중 마지막 노드를 읽는다 (절대)
		trace(node.getLastSibling().val);

		// 이전 노드를 읽는다
		trace(node.prev.val);

		// 다음 노드를 읽는다
		trace(node.next.val);

		// 이전 노드가 있는지 확인
		trace(node.hasPrevSibling());

		// 다음 노드가 있는지 확인
		trace(node.hasNextSibling());

		// 형제 노드들이 있는지 확인
		trace(node.hasSiblings());

		// 형제 노드들의 숫자를 확인
		trace(node.numSiblings());

		node=node.getRoot();
		var itr:Itr=Itr(node.iterator());
		while (itr.hasNext()) {
			trace(itr.next());
		}
	}

	[Test]
	public function preorder():void {
		var root:TreeNode=new TreeNode;
		var node:TreeNode;

		var f:int=-1;
		var fmax:int=MathUtils.rand(10, 30);
		var s:int;
		var smax:int;

		while (++f < fmax) {
			node=new TreeNode("x" + f);
			root.appendNode(node);

			s=-1;
			smax=MathUtils.rand(0, 10);
			while (++s < smax) {
				node.appendNode(new TreeNode("y" + s));
			}
		}

		trace("TreeExample.preorder()", root);

		root.preorder(preorderCallback);
	}

	private function preorderCallback(node:TreeNode, preflight:Boolean, userData:Dynamic):Boolean {
		if (!node.isRoot()) {
			if (node.isLeaf()) {
				trace("leaf :", node.depth(), node.val);
			} else {
				trace("branch :", node.depth(), node.val);
			}
		}
		return true;
	}

	private function treestr(node:TreeNode):void {
		while (true) {
			trace(getTab(node.depth()) + node.val);
			if (node.hasChildren())
				treestr(node.children);
			if (node.hasNextSibling()) {
				node=node.next;
			} else {
				break;
			}
		}
	}

	private function getTab(depth:int):String {
		var tab:String="";
		while (depth-- > 0) {
			tab+="--- ";
		}
		return tab;
	}
}
}
