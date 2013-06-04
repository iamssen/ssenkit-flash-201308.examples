/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.HashMap;
import de.polygonal.ds.Itr;

import flash.display.Sprite;
import flash.utils.Dictionary;
import flash.utils.getTimer;

public class Map__Example {

	[Test]
	public function basic():void {
		var hash:HashMap=new HashMap();

		// hashmap 의 데이터를 쓴다
		hash.set("key1", 153);

		// hashmap 의 데이터를 읽어온다
		trace(hash.get("key1"));

		// 이미 set 되어 있는 key 에 다시 set 을 하면 에러가 난다
		// 그러므로 has 를 통해서 확인을 한 뒤에 덮어쓰기의 경우 remap 을 사용
		if (hash.has("key1")) {
			hash.remap("key1", new Sprite);
		} else {
			hash.set("key1", new Sprite);
		}

		trace(hash);

		// hashmap 의 데이터를 삭제
		hash.remove("key1");

		trace(hash);
	}

	[Test]
	private function compareDictionaryAndHashMap():void {
		var hash:HashMap=new HashMap();
		var dic:Dictionary=new Dictionary();
		var f:int;
		var max:int=50000;
		var t:int;

		f=-1;
		t=getTimer();
		while (++f < max) {
			hash.set("key" + f, "foo");
		}
		trace("hashmap set", getTimer() - t);

		f=-1;
		t=getTimer();
		while (++f < max) {
			dic["key" + f]="foo";
		}
		trace("dictionary set", getTimer() - t);

		f=-1;
		t=getTimer();
		while (++f < max) {
			hash.get("key" + f);
		}
		trace("hashmap get", getTimer() - t);

		f=-1;
		t=getTimer();
		while (++f < max) {
			dic["key" + f];
		}
		trace("dictionary get", getTimer() - t);

		t=getTimer();
		var itr:Itr=Itr(hash.iterator());
		while (itr.hasNext()) {
			hash.get(itr.next());
		}
		trace("hash loop", getTimer() - t);

		t=getTimer();
		for (var key:String in dic) {
			dic[key];
		}
		trace("dictionary loop", getTimer() - t);

		f=-1;
		t=getTimer();
		while (++f < max) {
			hash.remove("key" + f);
		}
		trace("hashmap remove", getTimer() - t);

		f=-1;
		t=getTimer();
		while (++f < max) {
			delete dic["key" + f];
		}
		trace("dictionary delete", getTimer() - t);
	}


}
}
