// Vorcode in Kommentaren
// Hauptcode als simpler Code
// in diesem auch Neuerungen ('!!!')
public class EinfachesDotCom {
	// int-array zum Festhalten zellorte:
	int[] zellorte;
	
	// int zum Festhalten Anzahl Treffer, setze es auf 0:
	int anzahlTreffer = 0;
	
	// Methode, die User-String-Tipp des Ortes von Dot-Com annimmt und auf Treffer/Vorbei/Versenkt überprüft:
	public String prüfDich(String tippString) 
	{
		
		// Nimm Tipp vom User und konvertiere diesen in eine int:

		// Für jedes Element in int-array zellorte vergleiche es mit dem tipp des Users.
		// Falls erfolgreich, Inkrementierung von anzahlTreffer um +1 .
		// Falls AnzahlTreffer == 3 --> Versenkt --> End game;
		// Falls AnzahlTreffer inkrementiert --> Treffer --> wiederholtes Aufrufen dieser Methode und
		// Löschen dieses zellort-Element;
		// else Vorbei
		
		int tipp = Integer.parseInt(tippString); // !!! Convert string into integer: 
		// ReturnClass.method_ReturnClass_how_to_convert(str-value);
		
		String ergebnis = "Vorbei";
		
		for (int zelle : zellorte) 
			// !!! advanced/for-each-/for-in-Schleife:
			// for (typ_variable_die_mit_array-Elementen_kompatibel
			// initialisieren_Variable_die_array-Elemente_darstellt :_als_'in' 
			// array_über_den_geloopt/Element-Collection)
			// (auch genutzt in Collections, die keine arrays Kapitel 6).
			//  for (int i=0;i<10;i++){} // for (x,y,z), z am Schleifenende Ereignis
			// while-Schleife macht Sinn, wenn man nicht weiß, wie oft die Schleife durchlaufen werden soll
		{
			if (tipp==zelle) {
				ergebnis = "Treffer";
				
				anzahlTreffer++; // !!! entspricht x = x + 1;
				// Dekrementieren: x--; für -1 möglich.
				// Unterschied int x=0;int z=++x; --> z=1, da x zuerst inkrementiert
				// int x=0;int z=x++; --> z=0, da z erst den Wert von x erhält und DANN x inkrementiert wird,
				
				
				break; // !!!
			}
		}
		
		if (anzahlTreffer == zellorte.length) {ergebnis = "Versenkt";}
		
		System.out.println(ergebnis);
		return ergebnis;
		
		
	}	
	// Setter, um zellorte zu initialisieren:
	public void setZellorte(int[] orte)
	{
		zellorte = orte;
	}
		
		
	

}
