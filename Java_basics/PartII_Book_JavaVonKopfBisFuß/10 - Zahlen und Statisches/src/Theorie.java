import java.util.Date;
import java.util.Calendar;

/*
 * 
 * Math class vom long package:
 * - hat keine Instanzvariablen --> Durch Instanziierung der Klasse nichts gewonnen! 
 *   --> Konstruktor private, sodass kein Math-Objekt erzeugbar!
 * - Wenn Klasse nur statische Methoden hat, sie benutzen keine Instanzvariablen (!), dann braucht man in der Regel keine
 *   Instanz zur Nutzung der Klasse erstellen
 *   -->
 * Methodenformen:
 * - Statische Methoden: Schlagwort static (!!!), dadurch ohne Objekterstellung einer Klasse nutzbar, da unabhängig von 
 *                       Instanzvariablen (+ kein Wissen über erstellte Instanzen und nicht-statischen Methoden, da diese
 *                       natürlich evtl. abhängig von Instanzvariablen),
 *                       e.g. public static int methode(){...}
 *                       Aufruf: class_name.method_name(argument); 
 *                       		 oder (aber weniger gut):
 *                               class_name c = new class_name(); c.method_name(argument);
 *                               
 *                       
 * - Reguläre/nicht-statische Methode: Instanzvariablen beeinflussen Methodenverhalten
 * 
 * - Klassen mit statischen Methoden sollen evtl. nicht instanziiert werden. Um dies sicher zu verhindern, kann man sie auf
 *   abstract setzen oder Konstruktor auf private.
 *   Allerdings muss man Instannz einer Klasse irgendwie erzeugen können, wenn mind. 1 reguläre Methode da
 * 
 * 
 * Statische Variablen:
 * - = Wert, den alle Instanzen einer Klasse miteinander teilen; Wert pro Klasse, statt Wert pro Instanz
 * - Zählen, wie oft eine Klasse instanziiert:
 * 	 public class Ente {
 * 	 
 *   private static int entenAnzahl = 0; // - nur bei Laden der Klasse initialisiert, nicht bei Instanzerstellung;
 *   									 //   Klassen geladen meist bei erstmaliger Objekterstellung durch JVM
 *   									 //   (bevor Objekt-Erzeugungsanweisung), theoretisch kann man JVM auch dazu anweisen;
 *   									 // - lebt in Klasse statt Objekt
 *   									 // - alle erstellten Objekte teilen sich diese Exemplar-Variable in aktualisierter Form!
 *   oder
 *   private static int entenAnzahl; // da default-value = 0 /0.0/false/null
 *   public Ente(){entenAnzahl++;} // Erhöhen der entenAnzahl
 *   }
 * - Zugriff: class_name.static_variable_name
 * 
 * - als unabänderbar/konstant festlegen: final!!!
 *   public static final double PI = 3.14;
 *   --> man sollte diese Variablen GROß schreiben
 *   --> Statischer Initalisierer: 
 *       class class_name{
 *       	final static int X_1;
 *       	static{X_1=42;} // Wird beim Laden der Klasse ausgeführt, als allerster Codeteil
 *       }
 *   --> Muss immer initialisiert werden!
 *   
 * - Bibliotheken/Klassen mit Konstanten/statischen Variablen: Swing, Color (Farben vordefiniert) --> GUI, System.out
 *   
 * 
 * final für nicht-statische Variablen modfizieren: 
 * - für Methodenparameter/lokale Variablen/Instanzvariablen(Initialisierung in Konstruktor oder in Deklaration) 
 *   --> nicht mehr änderbar
 * - Verhinderung der Methodenüberschreibung, Unterklassenbildung:
 *   final void method_name(){}; final class class_name{}
 * 
 * Statische Methode kann auf statische Variablen zugreifen!
 * 
 * ------------------------------------------------------------------------------------------------------------------
 * 
 * Elementare Werte als Objekte verpacken (wichtig für Java < 5.0):
 * - Ab Java 5.0 geht das hier:
 *   int x = 32; ArrayList list = new ArrayList(); list.add(x); 
 *   --> Elementares x in ArrayList mit ArrayList-Objekten reinstecken (bereits besprochen)
 *       ArrayList eine Collection
 * - Wrapper-Klassen für jeden elementaren Typ in java.lang
 *   Diese Klassen heißen: Boolean,Character,Byte,Short,Integer,Long,Float,Double --> Objekt!
 * - !!! Vor Java 5.0:
 *   Einpacken: int i = 8; Integer ii = new Integer(i); // i wird als Instanzvariable gespeichert
 *   Aufruf in ArrayList: Integer eins = (Integer) list.get(0);
 *   Auspacken: int aus = ii.intValue(); // booleanValue/charValue/...
 *   
 *   --> Ab Java 5.0 AutoBoxing: Automatisches Verpacken und Auspacken. Das einzige zu beachten:
 *       ArrayList<Integer> l = new ArrayList<Integer>(); // Einfach Klasse von int/elementaren Typen in <> angeben
 *       ... // hier kann immer int/elementarer Typ verwendet werden
 *       
 *       Immer wenn irgendwo primitiver Typ oder Wrapper-Klasse, kann man diese als primitiv/Wrapper behandeln.
 
 * 
 * ------------------------------------------------------------------------------------------------------------------
 *  
 *  Formatierung von Zahlen:
 *  - E/A = Eingabe/Ausgabe, I/O= Input/Output
 *  - String s = String.format("%, d", 100000) erklärt: Unten im Code
 *  
 *  Datumsangaben:Unten im Code
 *  
 * ------------------------------------------------------------------------------------------------------------------
 * 
 * Statische Importe:
 * - Importieren statischer Klasse/Variable/Enumeration zum Ersparen von Tipparbeit
 * - Nachteile: eigener Code schwerer lesbar; Auftreten gleicher Methoden aus verschiedener Klassen --> Welche nehmen?
 * - e.g.
 *   import static java.lang.System.out; // Extra-Wort 'static'
 *   import static java.lang.Math.*;
 *   
 *   out.println(sqrt(2)); // letzter Teil vom Importierten in Code nochmal wiederholt, hier 'out'
 * 
 *    
 */

public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		System.out.println(Math.round(42.4f)); // 'f', damit man float und nicht double nimmt
		System.out.println(Math.round(42.5)); // rundet auf ab .5
		System.out.println(Math.max(42,4));
		System.out.println(Math.min(42,4));
		System.out.println(Math.abs(-42.4)); // type argument: int/double/...
		System.out.println(Math.PI); // getting pi 3.14...
		System.out.println(Math.ceil(42.4)); // rundet auf, int.0
		// sqrt/tan/floor/asin()
		// Rest auf:
		// https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Math.html
		
		//////////////////////////////////////////////////////////////////////////////////////////////
		System.out.println(Integer.parseInt("42")); // convert string into int
		System.out.println(Double.parseDouble("42.3")); 
		// Java 5.0: System.out.println(new Boolean("true").booleanValue()); 
		System.out.println(Boolean.parseBoolean("true")); 
		
		// Convert int/elementaren Typ into string:
		System.out.println("" + 34.2); 
		System.out.println(Double.toString(42.3)); 
		
		//////////////////////////////////////////////////////////////////////////////////////////////
		String s = String.format("Any world %, d any worlD", 100000); 
												  // "%, d": d as 'transfer to decimal', Argument muss int-kompatibel sein!
												  // ' ' as 'let one space free in output',
												  // ',' for 'set commas in high valued numbers, but with local computer
												  // language it can be transfered into '.' in out
												  
												  // format(a,b) where a Formatieriungsanweisung, die immer auch Hinweis, 
												  //welcher Argumenten-Dateityp nutbar; b mind. ein Argument
		
												  // '%' as variable representation of variable b oder 'Hier Argument einfügen'
		System.out.println(s);
		
		String s2 = String.format(" %.2f", 1000.005); // round up by 2 values after comma; 'f' into floating number
													  // bei b muss ein Trenn-'.' stehen, ansonsten Fehler zur Laufzeit
		System.out.println(s2);
		
		String s3 = String.format(" %,.2f", 1000.005); // round up by 2 values after comma AND separate 0-s in high numbers!
													   // Befehle kombiniert!
		System.out.println(s3);
		
		/*
		 * Formatierung a:
		 * - Nach % endet Formatierungsanweisung mit Datentyp-Anzeiger (f/d/...) 
		 * - Nur % und Datentyp Pflicht
		 * - % [1 Argumentnummer][2 Schalter/Flags][3 Breite][4 .Genauigkeit] Typ
		 *   1: Welches Argument aus mehreren gemeint
		 *   2: Formatierungsoptionen, e.g. Markieren Tausenderstellen, Klammern negativer Zahlen, linksbündige Ausrichtung
		 *   3: Wie viele Stellen eine Zahl/... mind. haben soll (Leerzeilen+eigentliche Zahl, die dadurch nach links verschoben)
		 *   4: Anzahl Nachkommastellen
		 */
		System.out.println(String.format("%,6.1f",42.000)); // Zahl hat nur eine Nachkommastelle und soll 6 Symbole lang sein
															// --> Leerzeilen vor Zahl stellen
		
		// Weitere Typen neben d,f:
		System.out.println(String.format("%x",42)); // Hexadezimalzahl erhalten, b=byte/short/int/long/BigInteger
		System.out.println(String.format("%c",42)); // b repräsentiert das Zeichen von out, b=byte/short/int/char
		
		
		// b - Mehrere Argumente:
		System.out.println(String.format("%x %c",42,45));
		
		/////
		/*
		 * Datumsangaben:
		 * - Datentyp von a: beginnt mit 't' mit darauf folgenden Typ
		 * 
		 * 
		 * 
		 * 
		 */
		System.out.println(String.format("%tc",new Date() )); // nötig: import java.util.Date;
															  // Date() - out: Wochentag Monat Tag Uhrzeit Zeitzone Jahr
															  // 'c' für complete time
		System.out.println(String.format("%tr",new Date() )); // 'r' für Uhrzeit
		
		Date d = new Date();
		System.out.println(String.format("%tA %td %tB",d,d,d )); // 'A' Wochentag, 'd' for day, 'B' for month
		// Alternative:
		System.out.println(String.format("%tA %<td %<tB",d )); // '<' Schalter, der 'nimm letztes Argument nochmal'
		
		
		// Rechenoperationen mit Daten:
		/*
		 * - Use java.util.Calendar
		 * - Calendar abstakt --> nicht instanziierbar, daher mit Unterklasse arbeiten
		 * - Kalendar, den man erhält, passt zu eigenen lokalen Einstellungen
		 * - Man kann mit Imports entscheiden, welchen Kalender man möchte, e.g. buddhistisch, 
		 *   christlich (java.util.GregorianCalendar as default in most parts of world)
		 * 
		 * - Konzept Calendar-Objekte:
		 *   1) Felder halten Zustand (Datum-Zeit-Infos) fest, e.g. Setter/Getter für Erfahren von Jahr
		 *   2) Datum-/Zeitwerte inkrementieren, e.g. +/- 1 Monat/Jahr
		 *   3) Datumswerte in Millisekundenpräsentation darstellbar: # Millisekunden, die seit 1.1.1970 vergangen
		 *      --> Einfaches Raufaddieren von Zeiteinheiten auf gegebene Zeit; Berechnen zeitlicher Differenz
		 *      
		 */
		
		// Instanzgenerierung aus abstrakter Klasse:
		Calendar cal = Calendar.getInstance(); // statische Methode, da unabhängig von Instanzvariablen/Objekt
											   // returnt Instanz Unterklasse GregorianCalendar
											   // Polymorphie Oberklasse o = Unterklassen-Instanz;
		cal.set(2004,0,7,15,40); // set(Jahr, Monat (0=januar), tag, stunde, minute) in int
		
		long in_milli = cal.getTimeInMillis(); // getting milliseconds since 1.1.1970 in long
		
		in_milli += 1000 * 60*60; // += kilo_against_milli * seconds * minutes --> += 1 hour
		cal.setTimeInMillis(in_milli); // long inpunt
									   // set a new time 
		System.out.println(cal.get(cal.HOUR_OF_DAY)); // HOUR_OF_DAY: europäisch; HOUR: kein 16 Uhr, nur 4 Uhr
		
		cal.add(cal.DATE, 35); // 35 Tage zum Datum addieren
							   // DATE/DAY_OF_MONTH als Feld Tag
							   // add(int field, int amount)
		
		cal.roll(cal.DATE,35); // 35 Tage vorgedreht, aber gleichbleibender Monat!
							   // add/substact value with unchanging bigger fields
		System.out.println(cal.getTime());
		
		cal.set(cal.DATE,1); // Tag im Monat auf 1 setzen
							 // set(int field, int value)
		
		// Weitere Felder: MILLISECOND, MINUTE, MONTH, YEAR, ZONE_OFFSET (keine Sommerzeitberücksichtigung in Zeitabfrage/
		// -setzen in milliseconds),...
	}

}
