/// Example
package ssen.common.ds {

public class DataConverter__Example {
	
	[Test]
	public function multipleKeyDatasToTree():void {
		var l2t:MultipleKeyDatasToTreeExample=new MultipleKeyDatasToTreeExample;
		l2t.execute();
	}
}
}
import de.polygonal.ds.Itr;
import de.polygonal.ds.TreeNode;

import ssen.common.StringUtils;
import ssen.common.ds.DataConverter;

class MultipleKeyDatasToTreeExample {
	
	// 테스트를 위한 배열 데이터
	private function getTestList():Array {
		var list:Array=[];
		list.push(new VO("A1", "B11", "C111", "aaa1", 10, 25));
		list.push(new VO("A1", "B11", "C112", "aaa2", 35, 34));
		list.push(new VO("A1", "B11", "C111", "aaa3", 23, 34));
		list.push(new VO("A1", "B11", "C111", "aaa4", 35, 66));
		list.push(new VO("A2", "B21", "C211", "aaa5", 22, 81));
		list.push(new VO("A2", "B22", "C221", "aaa6", 35, 48));
		list.push(new VO("A2", "B22", "C222", "aaa7", 123, 2));
		list.push(new VO("A3", "B31", "C311", "aaa8", 36, 36));
		list.push(new VO("A3", "B32", "C321", "aaa9", 86, 12));
		list.push(new VO("A3", "B32", "C322", "aaa0", 36, 46));
		return list;
	}
	
	// 실행
	public function execute():void {
		
		// tree 구조의 key 를 만들어둔다
		var categoryKeys:Vector.<String>=new <String>["cate1", "cate2", "cate3"];
		
		// 데이터를 iterator 로 만들어둔다 
		// 데이터를 iterator 로 선택한 것은 기본적으로 Vector 데이터는 
		// 하위로 타입캐스팅 할 수 있는 여지가 없기 때문이다.
		// 번거롭더라도 개개별적 Iterator 도구를 만들어쓰도록 한다
		var itr:Itr=new ArrayedItr(getTestList());
		
		// convert
		var tree:TreeNode=DataConverter.multipleKeyDatasToTree(itr, categoryKeys);
		
		// 검증
		tree.preorder(loopTree);
	}
	
	// preorder (tree 의 상위에서 부터 하위로 이어지는 loop) callback
	private function loopTree(node:TreeNode, preflight:Boolean, userData:Dynamic):Boolean {
		if (!node.isRoot()) {
			if (node.isLeaf() && node.val is VO) {
				printLeaf(node);
			} else {
				printSumChildren(node);
			}
		}
		return true;
	}
	
	//----------------------------------------------------------------
	// 출력
	//----------------------------------------------------------------
	// 하위 leaf 들을 합산한 complex node 항목 출력
	private function printSumChildren(node:TreeNode):void {
		var itr:Itr=node.iterator();
		var val:Object;
		var pvo:VO;
		
		var value2sum:int=0;
		var value3sum:int=0;
		
		while (itr.hasNext()) {
			val=itr.next();
			
			if (val is VO) {
				pvo=val as VO;
				value2sum+=pvo.value2;
				value3sum+=pvo.value3;
			}
		}
		
		trace("PropertiesToTree.printSumChildren()", node.depth(), node.size(), node.val, value2sum, value3sum);
	}
	
	// 하위가 없는 leaf 항목 출력
	private function printLeaf(node:TreeNode):void {
		trace("PropertiesToTree.printLeaf()", node.depth(), node.val);
	}
}

// VO
class VO {
	public var cate1:String;
	public var cate2:String;
	public var cate3:String;
	public var value1:String;
	public var value2:int;
	public var value3:int;
	
	public function VO(c1:String, c2:String, c3:String, v1:String, v2:int, v3:int) {
		cate1=c1;
		cate2=c2;
		cate3=c3;
		value1=v1;
		value2=v2;
		value3=v3;
	}
	
	public function toString():String {
		return StringUtils.formatToString('[PVO cate1="{0}" cate2="{1}" cate3="{2}" value1="{3}" value2="{4}" value3="{5}"]', cate1, cate2,
										  cate3, value1, value2, value3);
	}
}

// Utils
class ArrayedItr implements Itr {
	private var _arr:Array;
	private var _f:int=-1;
	
	public function ArrayedItr(arr:Array) {
		this._arr=arr;
		_f=-1;
	}
	
	public function hasNext():Boolean {
		return _f + 1 < _arr.length;
	}
	
	public function next():Object {
		_f++;
		return _arr[_f];
	}
	
	public function remove():void {
		_arr[_f]=null;
	}
	
	public function reset():Itr {
		return new ArrayedItr(_arr);
	}
}
