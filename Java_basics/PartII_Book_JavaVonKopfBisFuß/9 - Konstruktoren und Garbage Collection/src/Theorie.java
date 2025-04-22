/*
 * Kapitel über Speicherorte, Entstehung, Löschung eines Objekts
 * 
 * Allgemein:
 * - Wenn Objekte vom Coder aufgegeben, holt der Garbage Collector (GC) sich die Objekte (löscht sie), sodass neuer RAM frei wird
 * 
 * PART 1 - Entstehung eines Objekts:
 * 
 * Stack und Heap: wo das Leben spielt:
 * - JVM bekommt 2 Speicherbereiche zugewiesen, um die Java-Programme auszuführen: 
 *   Garbage Collectable Heap: hier leben Objekte, die Instanzvariablen enthalten
 *   Stack: hier leben Methodenaufrufe und lokale Variablen/Stackvariablen (werden in einer Methode deklariert; auch Methodenparameter/Argumente;
 *          leben nur so lange, wie Methode auf dem Stack, d.h. solange die Methode noch nicht ans Ende '}' gekommen ist; u.a. Referenzvariablen)
 * - Methodenaufruf --> Kommt oben auf Aufruf-Stack in Form eines Stack-Frames, der Status Methode enthält (welche Zeile gerade ausgeführt; Werte 
 *   lokaler Variablen). Sie ist die gerade ablaufende Methode (die einzige, sollte es nur einen Stack geben) bis '}' erreicht
 * - Wenn Methode B in Mitte der Methode A aufgerufen, dann oben im Stack erst A, dann B, dann B weggeschoben, sodass wieder A (fortgesetzt wird)
 * 
 * Konstuktur:
 * - Objekterzeugung --> 
 *   Ente meineEnte = new Ente();
 *   --> Nur so Aufruf von Entekonstruktor (außerhalb eines anderen Konstruktors). Sobald 'new' wird Code ausgeführt, den er enthält. 
 *       JVM sucht Klasse und ruft Konstruktor in Klasse auf
 * - Seine Power: Wird ausgeführt, bevor Objekt Referenz zugewiesen. So kann man Objekt für Gebrauch vorbereiten
 * - Möglichkeiten:
 * 	 1) Compiler schreibt default Konstruktor: 
 *      public Ente(){} // Name muss dem der Klasse entsprechen! (für Methoden möglich)
 *                      // kein Return-Wert
 *   2) Wir können schreiben:
 *      public class Ente{
 *      	public Ente(){System.out.println("Quak");}
 *      }
 * - Nützen wenn:
 *   a) Zählen, wie oft diese Klasse schon instanziiert
 *   b) Laufzeitspezifische Daten zuweisen (=Daten, was jetzt passiert)
 *   c) Instanzvariablen Werte zueweisen --> häufig genutzt
 *   d) Referenz auf Objekt, das neues Objekt erzeugt, abrufen und speichern. Z.B. Wenn in Enteobjekt ein Kückenobjekt erzeugt, hier
 *      Referenzvariable von Ente speichern (?)
 *   e) Objekt einer ArrayList zufügen
 *   f) HAS-A-Objekte erzeugen, diese wären normalerweise Instanzvariablen
 *   g) ...
 *   
 *   c) Wenn z.B. Größe Ente nicht initialisiiert, dann default value, das sollte man vermeiden, anderer Programmierer müsste erst einmal darauf 
 *      kommen, dass man auch die setGröße()-Methode direkt nach der Konstruktion anwenden sollte. 
 *      --> Ansonsten würde etwas BMIEnte() keinen Sinn machen, wenn default value von Größe = 0. 
 *      --> Code:
 *          main Method:
 *          Ente e = new Ente(42);
 *          
 *          public class Ente{
 *          	int größe;
 *          	public Ente(int entenGröße){größe = entenGröße;}
 *          
 *          	public Ente(){größe=23;} // einen Default-value setzen, damit anderer Programmierer nicht gezwungen, irgendein ihm in seiner
 *                                       // Bedeutung fremdes Argument zu liefern.
 *                                       // Argumentloser Konstruktor sollte man immer wenn möglich miterstellen, damit fremde Programmierer 
 *                                       // leicht ein Objekt erstellen können
 *          }
 *          --> Damit Programmierer Größe angeben kann, muss er nicht mehr setGröße verwenden :)
 *          --> Klassen mit mehreren Konsturktoren: überladene Konstruktoren (wie bei Methoden, wenn sie sich hinsichtlich Argumente unterscheiden -
 *              Typ und/oder Anzahl, auch hinsichtlich Reihenfolge unabhängig von Argumentnamen)
 *   
 * - Werden nicht vererbt
 * - Zugriff: public, private (niemand kann von außerhalb der Klasse darauf zugreifen; nächstes Kapitel), default (ohne Zugriffsmodifizierer; Anhang B)
 *   
 * Konstruktoren und Superklassen:
 * - Wenn Objekt erstellt, erhält dieses Platz für alle Instanzvariablen aus dem gesamten Vererbungsbaum, da diese natürlich auch geerbt
 *   (private Variablen nicht vererbt)
 * - Alle Konstruktoren im Vererbungsbaum (Superklassen (?)) eines Objekts werden ausgeführt, wenn neues Objekt erzeugt, da dieses die Super-
 *   Instanzvariablen erbt, die in Konstruktoren teilweise initialisiert
 * - Unterklasse von von ihm nicht genutzten Instanzvariablen abhängig, da sie evtl. abhängig von Methoden der Superklasse, die diese Instanzvariablen
 *   nutzt
 * - Auch abstrakte Klassen haben Konstruktoren, auch wenn von ihnen kein Objekt erstellbar
 * - Zuerst Superklasse über Unterklasse aufgerufen, so geht es weiter bis Konstruktor Object aufgerufen (Konstruktorverkettung). Der Inhalt vom
 *   Unterklasse-Konstruktor wird zuerst gestartet, doch vollständig ausgeführt wird zuerst der Superklassenkonstruktor
 *   --> Funktionert mit Stack - Aufrufe Konstruktoren:
 *       1. Unterklasse()
 *       2. Unterklasse(), Oberklasse() (oben hier)
 *       3. Unterklasse(), Oberklasse(), Object()
 *       4. Unterklasse(), Oberklasse()
 *       5. Unterklasse()
 *       6. empty stack
 *       
 *       --> Code Umsetzung:
 *           public my_Konstruktor(int neueGröße){
 *           	super(); // - Ruft Konstruktor von dirketer Superklasse auf!
 *           			 // - Das fügt auch der Compiler so für einen ein, allerdings nur 'super();', sodass nur argumentationsloser Konstruktor 
 *              		 //   von Superklasse aufgerufen und die restlichen ignoriert.
 *               		 //   Compiler wirkt auch nur ein, wenn Konstruktor keinen anderen überladenen Konstruktor aufruft.
 *               		 // - Muss immer erste Zeile im Konstruktor sein, damit Stack-Konzept funktioniert, da Instanzvariable der Unterklasse
 *               		 //   von einer Instanzvariable der Oberklasse abhängen könnte, sollte zuerst immer Konstruktor Oberklasse aufgerufen werden
 *               		 //   --> Beispiel: Nilpferd erbt Methode getName(), doch die Variable name der Superklasse Tier ist noch gar nicht 
 *               		 //       initialisiert. Nilpferd braucht einen Namen, deshalb:
 *               				  public class Nilpferd extends Tier{
 *               						public Nilpferd(String name){
 *               							super(name);
 *               						}
 *               				  		...}
 *               				
 *               				  public abstract class Tier{
 *               						private String name; // wird so nicht vererbt; nicht initialisiert
 *               						public Tier(String derName){name=derName;}
 *               				 		...} 
 *               				  --> der Tier-Anteil im Objekt weiß dann den Namen, sodass die Tier-Methode getName() verwendbar
 *           	größe = neueGröße;
 *           }
  *     
 * Konstruktoren - doppelten Code vermeiden:
 *  - Ein Konstruktor soll den grundlegenden Code haben, den die anderen Konstruktoren auch brauchen und aufrufen wollen.
 *  - this(argument) --> Referenz auf das eigene Objekt!
 *                   --> Nutzen in anderen Konstuktoren, um einen speziellen Konstruktor mit dieser Argumentstruktur aufzurufen
 *                   --> Muss erste Zeile im Konstruktor sein und 'super()' kann dann nicht mehr in diesem verwendet werden!
 * 
 * PART 2 - Wie lange lebt ein Objekt?:
 * 
 * - Das Objekt lebt und stirbt mit der Referenz. Keine Referenz, kein Leben.
 *   --> Wie lange lebt Variable? 
 *       Lokale Variable: gespeichert im Stack Frame (Methode) im Stack. Sobald dieser Stack Frame abgebaut, stirbt mit ihm die
 *       				  Variable, die ja im Stack gespeichert. Oberster Stack Frame seine Variablen haben immer Geltung und 
 *                        leben noch.
 *                 		  Synonyme: Stack-Variable, automatische/geltungseingeschränkte/temporäre Variable
 *                        Referenzvariable: Wenn keine mehr auf Objekt zeigt, ist diese tot. Möglichkeiten:
 *                        					1) Referenzvariable stirbt mit Ende einer Methode/ist lokal
 *                        					   e.g. void go(){Leben l = new Leben();}
 *                        					2) Referenzvariable wird anderem/neuem Objekt zugewiesen
 *                        					   e.g. Leben l = new Leben(); l = new Leben();
 *                        					3) Referenzvariable auf null gesetzt
 *                        					   e.g. Leben l = new Leben(); l = null;
 *                        					   Anmerkung: Wenn man Point-Operator nutzt erhält man zur Laufzeit (durch JVM)
 *                        								  NullPointerException
 *     	 Instanzvariable: IM Objekt A auf Heap gespeichert, bezieht sich auf Objekt B --> lebt so lange wie das Objekt A
 *     
 *      
 *      
 * Objekt erzeugen:
 * a) new ...
 * b) Deserialisierung (kommende Kapitel)
 * c) Java Reflection API (nicht besprochen)
 */

public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// out of topic - basics:

		int mein_aufruf = aufruf(); // wir benötigen kein 'this()' oder 'new Theorie()', um direkt in der Klasse eine Methode
		// über eine andere Methode aufzurufen
		System.out.println("Aufruf erfolgreich");
	}	
	public static int aufruf(){
		return 2;
	}

}
