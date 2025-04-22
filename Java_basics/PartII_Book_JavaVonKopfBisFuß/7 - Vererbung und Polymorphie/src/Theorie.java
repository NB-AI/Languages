/*
 * Vererbung:
 * - Super-/Oberklasse, die abstrakt ist
 * - Unterklasse erweitert Oberklasse (erbt von ihr); Unterklasse erbt automatisch alle Instanzvariablen + Methoden von
 *   Oberklasse und kann diese überschreiben durch simple Neudefinition oder erweitern durch 
 *   public void methode(){
 *   	super.methode(); // Aufruf der Methode der Oberklasse
 *   	code...; // Code, den die Unterklasse hinten anfügt}
 *   .
 *   Auch Hinzufügen beliebig neuer Instanzvariablen + Methoden ist möglich!
 *   Achtung: Wenn Methode überschrieben, muss sie genau die gleichen Argumenttypen nehmen und 
 *   kompatible Return-Werte zurückliefern!
 *   
 * - Unterklasse kann alles tun, was sämtliche seiner Oberklassen tun können
 * - Instanzvariablen nicht überschreibbar, aber neu definierbar
 * - Damit Code-Kopien vermieden
 * 
*  
*  Zugriffsebenen: 
*  private,default,protected,public (Kapitel 17, Anhang B)
*  Steuern, wer  was sieht
*  public --> Vererbung
*  private --> Keine Vererbung der Methoden/Variablen!
*  
 *
 * Vererbung entwerfen:
 * 1. Nach Objekten suchen, die Attribute/features/Variablen und Verhalten gemeinsam haben
 * 2. Was haben alle (Typen) gemeinsam?
 * 3. + 4. Beziehungen im Vererbungsbaum finden
 * 
 * 2. Eine Klasse erstellen, die alle gemeinsam haben.
 *    e.g. class Tier, Instanzvariable=nahrung, Methode=schlafen()
 * 3. Welche Methoden sollten von einzelnen Unterklassen wie überschrieben werden?
 * 4. Nach Klassen suchen, die besondere Ähnlichkeiten mit individuellen anderen Klassen haben, um 
 * 	  damit eine Oberklasse auf der zweiten Hierarchieebene zu bauen,
 * 	  e.g. Hund, Wolf -> Hundeartige_Spezies -> Tier
 * 
 *  Ist-Ein-Test/IS-A-Test:
 *  - Herausfinden, ob eine Unterklasse eine Oberklasse erweitern soll mit:
 *    'Katze Ist-ein katzenartiges Tier' --> funktioniert
 *    'Badewanne Ist-Ein Badezimmer' --> funktioniert nicht! --> HAS-A-Beziehung: 'Badezimmer HAS-A Badewanne' 
 *    --> funktioniert --> Badezimmer hat Instanzvariable Badewanne vom Typ Badewanne (Objekt einer Klasse)! Keine Vererbung.
 *  - IS-A-Test geht nur in eine Richtung, e.g. funktioniert nicht: 'Figur IS-A ALWAYS Dreieck'
 *  - Der IS-A-Test trifft auf alle Unterklassen mit beliebigen Oberklassen vershciedener Hierarchieschichten
 *    eines Vererbungsbaums zu
 *   
 * Supertyp - Definieren von Protokoll für eine Gruppe von Klassen durch Vererbung:
 * Durch die vererbaren Methoden entsteht eine Garantie, dass alle Unterklassen diese ausführen können
 * -->
 * Polymorphie:
 * Code so schreiben, dass er für die Zukunft leicht erweiterbar und anpassbar;
 * bisher: Hund h = new Hund();
 * jetzt: Tier h = new Hund(); // Referenzvariable Tier (Oberklasse), erstelltes Objekt Hund (Unterklasse)
 * Erklärung Polymorphie: Compiler checkt, ob die aufgerufene Methode (hier noch nicht passiert) auf class
 * Referenz Tier enthalten ist. JVM ruft dann das referenzierte Objekt im Heap auf, das die gleiche Methode
 * hat.
 * --> Achtung: Wenn Methode überschrieben, muss sie genau die gleichen Argumenttypen nehmen und 
 *     kompatible Return-Werte zurückliefern! 
 *     Nur mit public überschreiben.
 * --> Wenn Unterklasse Methode überschreibt, aber ein zusätzliches Argument hinzufügt oder das
 * 	   Argument einen anderen Datentyp hat, ist diese
 *     Methode eine NEUE Methode und überschreibt NICHT. Überladung!
 * das ermöglicht Polymorphe Arrays:
 * Tiere[] t = new Tier[2]; 
 * t[0] = new Hund();
 * t[1] = new Katze();
 * for (int i=0;i<t.length;i++)
 * 		{t[i].essen(); // man erhält die Methode essen aus den Unterklassen Hund, Katze!}
 * .
 * Auch benutzbar für Argumente:
 * public void methode_unabhängiger_class(Tier a){...}
 * ...
 * Nilpferd n = new Nilpferd();
 * ?.methode_unabhängiger_class(n);
 * .
 * --> methode_unabhängiger_class(Tier a) muss nicht mal geändert werden, wenn neue Untergruppen hinzugefügt,
 * e.g. class Kaninchen
 * 
 * 
 * Sonstiges - Hindernisse der Unterklassenbildung:
 * - Klassen, die nicht mit public markiert, nicht-öffentlich. Von dieser nur innerhalb des Packages gleiche
 *   Unterklassen ableitbar
 * - Klassen, die mit final markiert, bedeuten, dass sie Ende einer Vererbungsreihe.
 *   Macht Sinn, wenn Methoden niemals überschrieben werden sollen --> final class für ganze Klasse;
 *   final methode(){} für nur einzelne Methode geschützt werden soll
 * - Klasse hat nur private Konstruktoren (Kapitel 9)
 * 
 * 
 * 
 * 
 * 
 */
public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
