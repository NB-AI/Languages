package f;
// leider falsch, da Fehler in der Angabe B.S. 24; Lösung B.S. 26
public class PoolPuzzleEins {
	public static void main(String [] args) {
		int x = 0;
		while (x<4) {
			x=x-2;
			if(x<1) {System.out.print("da ");}
			x=x+1;
			if(x>1) {System.out.print("das"); System.out.print(" Kind ");}
			if (x==1) {System.out.print("dasitzend");}
			if (x<1) {System.out.print("sagt");}
			System.out.println("");
			x=x+2;
		}
	}
}
