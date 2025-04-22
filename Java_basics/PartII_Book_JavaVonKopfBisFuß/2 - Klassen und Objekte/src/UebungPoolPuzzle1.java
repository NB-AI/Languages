
public class UebungPoolPuzzle1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UebungPoolPuzzle2 e1 = new UebungPoolPuzzle2();
		//UebungPoolPuzzle2 e2 = e1; // möglich, aber komplett anderes Verhalten als einfach neues Instanz zu erstellen.
		// e2 ist dann IMMER direkte Kopie von e1, Alles was mit e1 geschieht, passiert auch mit e2
		UebungPoolPuzzle2 e2 = new UebungPoolPuzzle2();
		int x = 0;
		
		while(x<4) {
			e1.hallo();
			e1.zähler = e1.zähler + 1;
			if (x==3) {e2.zähler = e2.zähler+1;}
			if (x>0) {e2.zähler = e2.zähler + e1.zähler;} //+4
			x = x +1 ;
			
			
		}
		System.out.println(""); // Leere Zeile printen
		System.out.println(e2.zähler);
	}

}
