/// Example
package ssen.common.ds.polygonal {
import de.polygonal.ds.Array2;
import de.polygonal.ds.Itr;

public class Array2__Example {

	[Test]
	public function basic():void {
		// 최소 size 는 2x2 
		var ar2:Array2=new Array2(5, 5);

		//----------------------------------------------------------------
		// get and set
		//----------------------------------------------------------------
		// 갯수 알아내기 getW(), getH()

		// 쓰기 set(x, y, value)
		var f:int=0;

		var x:int=-1;
		var y:int=-1;
		while (++x < ar2.getW()) {
			y=-1;
			while (++y < ar2.getH()) {
				ar2.set(x, y, f);
				f++;
			}
		}

		// 읽기 get(x, y)
		x=-1;
		y=-1;
		while (++x < ar2.getW()) {
			y=-1;
			while (++y < ar2.getH()) {
				trace(ar2.get(x, y));
			}
		}

		//----------------------------------------------------------------
		// 
		//----------------------------------------------------------------
		// 확장. 더 많은 수가 들어가는 것은 잘라내고 알아서 쓰지만, 
		// 더 적은 수가 들어가면 에러가 발생한다.
		// 가로로 확장시킨다. 동쪽 방향으로 붙음
		ar2.appendCol(["a", "b", "c", "d", "e"]);

		// 세로로 확장시킨다. 남쪽 방향으로 붙음
		ar2.appendRow(["z", "x", "c", "b", "s", "q"]);

		// 가로로 확장시킨다. 서쪽 방향으로 붙음
		ar2.prependCol(["가", "나", "다", "라", "마", "바"]);

		// 세로로 확장시킨다. 북쪽 방향으로 붙음
		ar2.prependRow(["z", "z", "z", "z", "z", "z", "z"]);

		trace(ar2);
		trace(ar2.size());

		// 리사이즈. 가로, 세로 열 크기에 맞춰서 없애준다.
		ar2.resize(5, 5);
		trace(ar2);

		// 북쪽 방향으로 한줄 밀어준다. 밀린 라인은 다시 아랫쪽에 붙게 된다.
		// shiftN, shiftE...
		ar2.shiftN();
		trace(ar2);

		// 데이터의 교환, xy1 과 xy2 의 값을 서로 바꿔준다.
		ar2.swap(1, 1, 3, 3);
		trace(ar2);

		// iterator : x1y1...x9y1...x1y2...x9y2...x9y9
		// x 를 우선으로 가고, 끝점에서 y 로 내려온다
		var ar2i:Itr=Itr(ar2.iterator());
		while (ar2i.hasNext()) {
			trace(ar2i.next());
		}

		ar2.clear();
		trace(ar2);
	}
}
}
