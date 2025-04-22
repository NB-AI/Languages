
public class Klassen {

	public static void main(String[] args) // static: Diese Methode ist auch in anderen Klassen aufrufbar
	{ 
		KlasseVektor v = new KlasseVektor(); // v ist eine Instanz vom Typ KlasseVektor
		KlasseVektor v2 = new KlasseVektor(); 
		v.x = 1;
		v.y = 0;
		v.z = 0;

		KlasseVektor v3 = v; // v3 hat gleichen Inhalt wie v
		KlasseVektor v4 = v.add(v, v2); // nicht v.add(), da wir wollen, dass es für alle Vektoren gilt,
		// daher KlasseVector.add(), aber nutze public static KlasseVektor add(), sodass keine Instanz von Nöten!
		// Mit v.add() braucht man Instanz!
		KlasseVektor v5 = KlasseVektor.add1(v, v2);
		
		
		// Using this operation:
		KlasseVektor v6 = v.add2(v2);
		
		// String als vorgefertigte Klasse:
		String s = new String("a"); // String ein vorgefertigter Datentyp mit Methoden (Klasse), see them with s.
		// Alternative:
		String s1 = "a";
		s.charAt(0); // slicing over string
		
		
		// Java für Anfänger 10 - Konstruktoren und mehr zu Klassen:
		// Konstruktur als Methode,
		KlasseVektor vk = new KlasseVektor();
		KlasseVektor vk1 = new KlasseVektor(12);
		
		// Nutzen der toString method:
		System.out.println(v6.toString());
		// Alternative:
		System.out.println(v6);
		
		
	}
	

}
