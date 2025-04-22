
public class Strings {

	public static void main(String[] args) {
		
		String s = "               A    s   d f               "; 
		// Alternative:
		String w = new String("w");
		
		if(s.equals(w)) {} // s==w only works for new java version
		
		for(int i=0; i < s.length(); i++) {}
		
		// Leerzeichen am Anfang und Ende entfernen:
		String s_ohne = s.trim(); // Funktion wirkt nur, wenn man String rebenennt!
		s.trim(); // Keine Wirkung!
		System.out.println(s_ohne); // funktioniert nicht!
		
		// Searching:
		String text = "Die ist ein Text mit Suchwort.";
		String search = "Suchwort";
		int position = text.indexOf(search);
		System.out.println(text.contains(search));
		
		// Kleinbuchstaben konverten:
		s = s.toLowerCase();
		
		// Slicing:
		text.substring(1); // Alles ab index 1 enthalten
		System.out.println(text.substring(1));
		text.substring(0,5); // Alles im Index-Intervall von 0-4 ist enthalten
		System.out.println(text.substring(0,5));
		
		// Adden:
		System.out.println(s+w);
		System.out.println(s.concat(w));
		
		// Weitere Methoden:
		//s. // Strg + Leerzeichen, für Methodenvorschläge
	}

}
