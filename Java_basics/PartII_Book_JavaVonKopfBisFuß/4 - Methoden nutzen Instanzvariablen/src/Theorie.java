/*
 * - Methoden nutzen Werte von Instanzvariablen.
 * - Klasse als Anleitung, wie die JVM ein Objekt machen soll
 * - Methode nutzt Parameter, Aufrufer übergibt Argumente (können auch Referenzen sein). 
 * 	 Pass-By-Value: Argument-Kopie wird zu Parameter, der eine lokale Variable ist und keine Auswirkungen 
 *   auf Argument-Original hat
 *   Argument: was User eintippt, wenn er die Methode aufruft,
 *   Parameter: mit welchem Input die Methode geschrieben wurde
 * 
 * 
 * 
 */
public class Theorie {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// 1. Return Methoden mit Argumenten:
		leben dasGeheimnis = new leben();
		int integer = 3;
		long bigger = 45; // auch wenn dieser long-Wert nicht größer als ein int-Wert, so funktioniert 
		// es trotzdem nicht, den an sich großen long-Becher in den kleineren int-Becher der Funktion
		// zu stecken:
		int a = dasGeheimnis.gibGeheimnis(3,integer, bigger); 
		System.out.println(a);
		
		// 2. Arbeit mit Setter/Getter:
		dasGeheimnis.setMarke(44);
		// System.out.println(dasGeheimnis.marke); // Variable 'marke' nicht direkt abrufbar, da private
		System.out.println(dasGeheimnis.getMarke()); // nutze public Methode 'getMarke', um Variable 
		// 'marke' abzurufen
		
		int neueVariable = dasGeheimnis.getMarke() + 22;
		
		// 3. Automatische Wertzuweisung:
		System.out.println(dasGeheimnis.getDieVariable());
		
		// Was nicht funktioniert:
		dasGeheimnis.fail();
		
		// 4. Vergleiche:
		// - ==: Bit-Vergleich, egal, was diese Bits bedeuten, Vergleich elementarer Werte. Linke Nullen
		//   werden automatisch ergänzt, wenn ein Typ kleiner als der andere, e.g. byte vs. int.
		//   Prüfung, ob Referenzen auf gleiches Heap-Objekt zeigen
		// - .equals(): Egal, ob Objekte an gleichem Heap-Ort gespeichert. 
	}


}
