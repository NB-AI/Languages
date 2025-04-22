/*
 * Polymorphie extremeeeee:
 * - Flexibilität durch Schnittstellen erreichen, die 100% abstrakte Klassen, sprich Klasse, die nicht 
 *   instanziiert werden kann
 * - Oberklasse o = new Oberklasse(); macht nicht so viel Sinn, da eigentlich unklar, wie ein 
 *   Oberklasse-Objekt auszuesehen hat, e.g. class Tier --> wie kann man sowas abbilden/darstellen? zu 
 *   ABSTRAKT
 *   --> Oberklasse o = new Oberklasse(); verhindern durch
 *   	 abstract class Oberklasse{}
 *       was noch geht: Oberklasse o = new Unterklasse(); 
 *       				und
 *       				Oberklasse[] o = new Oberklasse[5]; // Array-Erstellung, der Tiere aufnimmt
 *   --> Gegenteil abstrakt: konkrete Klasse, e.g. class Nilpferd
 *   
 * - Abstrakte Methode: Diese muss überschrieben werden;
 *   					Klasse muss auch abstrakt sein!
 *   	                public abstract void essen(int a); --> Body/Code-Inhalt fehlt!
 *   					Unterklasse muss sie implentieren, es sei denn sie ist auch eine Oberklasse/abstrakt,
 *   					dann KANN sie, wobei Name/Argumente gleich und return-Wert kompatibel.
 *   
 * - 
 *   					
 *   										
 * Super-Superklasse Object:
 * - Die absolute Oberklasse von allen Klassen. Jede Klasse, die wir erstellen
 *   ist automatisch eine Unterklasse von Object, wenn auch evtl. viele
 *   Hierarchieebenen darunter
 * - ArrayList, e.g. remove(Object o) --> Polymorphie: alles was Unterklasse
 *   von Object, was wirklich alle Klassen sind, kann hier eingefügt werden
 * - Ihre Methoden:
 *   1) objekt1.equals(objekt2); --> out: bool
 *   2) objekt.getClass(); --> out: class class_name
 *   3) objekt.hashCode(); --> out: int; mehr in Kapitel 16 zu Hash
 *   4) objekt.toString(); --> out: string: class_name@zahl_buchstaben_mix
 * - Empfehlung: equals,hashCode,toString zu überschreiben
 * - Instanzen/Objekte vom Typ Object gemacht, wenn e.g. Thread-Synochronisierung (Kapitel 15)
 * - Geht nicht: Object o = new Ferrari(); o.fahrSchnell(); --> Object hat keine Methode 
 *   fahrSchnell()
 * - ArrayList-Problem:
 *   ArrayList<Object> my_ar = new ArrayList<Object>(); // ArrayList speichert nur Objecte!
 *   Hund h = new Hund();
 *   my_ar.add(h);
 *   Hund h2 = my_ar.get(0); // my_ar.get(0) liefert und nur ein Object und keinen Hund, auch
 *   // wenn einer reingesteckt wurde. Informationsverlust! Deshalb funktioniert diese Zeile
 *   // Code nicht 
 * - Sobald man ein Hund-Objekt als ein Object über eine Methode returnt, hat man nur noch das
 *   Object und nicht mehr den Hund! Schließlich hat Objekt andere Methoden als Hund. Der
 *   Compiler weiß nicht, dass wir hier einen Hund haben, er sieht nur die Referenzen (die
 *   einen bestimmten Typ Klasse haben).
 *   Wenn Referenz-Typ gleiche Methoden wie Objekt hat, auf das gezeigt wird, dann wird zuerst
 *   die Methode von Referenz-Objekt aufgerufen und dann geschaut, ob diese im Objekt
 *   überschrieben
 * - Tier t = new Hund();   // alle überschriebenen Methoden verwendbar. Wenn Hund etwas kann,
 * 						    // was Tier nicht kann, dann funktioniert diese Methode nicht
 *   Object o = new Hund(); // nur auf die Methoden von Object zugreifbar, falls diese in Hund
 *     						// überschrieben, werden die von Hund benutzt. Wie bei
 *     						// Tier t = new Hund();
 *   Hund h = new Hund();   // alle Methoden, ob neu oder alt, von Hund normal verwendbar, 
 *   						// nur mit dieser Option
 *   
 * - Object, das in Wirklichkeit Hund, wieder in Hund umwandeln:
 *   Object o;
 *   o instanceof Hund; // !!! Überprüfen, ob o wirklich ein Hund-Objekt 
 *   Hund h = (Hund) o;
 *   --> Zwei Referenzen, o und h, die auf Objekt Hund zeigen.
 *   
 *   
 * Vertrag ändern:
 * - Hund Teile seines Vertrags: Hund, Hundeartig,Tier,Object
 * - Problem: Was wenn man Hund im Nachhinein anpassen muss, etwa um Haustierverhalten
 *   für ein Tierhandlungsprogramm hinzufügen
 *   --> Wilde Hunde; andere Spezies von Haustieren
 * - Lösungen:
 *   1) Haustiermethoden in Klasse Tier stecken:
 *      +:
 *      -: Nilpferd hat Haustierverhalten; Verhalten Hunde + Katzen unterschiedlich
 *   2) 1), aber abstrakt (Unterklassen müssen sie überschreiben):
 *      +:
 *      -: Gleiches wie 1) nur noch zeitaufwendiger
 *   3) Haustiermethoden nur in relevante Klassen stecken:
 *   	+:
 *   	-: Protokoll, das alle anderen Programmierer dann auch kennen müssen. Diese könnten
 *  	   Methoden unterschiedliche Haustiere verschiedene Namen geben.
 *  	   Keine Polymorphie mehr möglich
 *   4) Richtige Lösung: Eine zweite Superklasse an der Spitze, die sich nur auf Haustiere,
 *      wie Hunde, spezialisiert und abstrakt ist --> 
 *      
 * Mehrfachvererbung:
 * - 'The Deadly Diamond of Death': Wenn zwei Superklassen gleiche Instanzvariable/Methode,
 *   unklar, welche man verwenden soll
 *   --> Jede Klasse hat nur eine direkt übergestellte Superklasse
 * - Rettung: 
 * 
 * Interfaces:
 * - Eine Schnittstelle; ist eine abstrakte Klasse
 * - alle Methoden einer Superklasse abstrakt, diese müssen von der ersten konkreten Unterklasse
 *   implementiert werden!
 * - public interface Interface_name1 // Interface definieren
 * 			{public abstract void spielen();
 * 			 // oder, da durch 'interface' schon festgelegt:
 * 			 void spielen();} // abstrakte Methode ohne Body mit ';'
 * 	
 *   public class Unterklasse extends beliebige_Superklasse implements Interface_name1,
 *   Interface_name2, ... // Mehrere Interfaces für Unterklasse gleichzeitig nutzen
 *   		{public void spielen() {code;}} // Implementieren der abstrakten Methode
 *   
 * - +: -> Superklassen müssen nicht modifierziert werden, einfach Interface hinzufügen.
 *      -> Jetzt ist es möglich, einzelnen Unterklassen/Hunde+Katzen als Haustiere zu markieren,
 *         ohne dass andere Tierarten beeinflusst werden und so dass Hunde+Katzen genau die
 *         gleichen Haustier-Methoden benutzen
 *      -> Klassen aus unterschiedlichen Vererbungsbäumen können gleiches Interface nutzen,
 *         e.g. Robo-Hund gehört auch zu Haustier (Interface)
 *         
 * - Interface-Imports (mehr in folgenden Kapiteln): 
 *   a) Serializable: Objekt speichert seinen Zustand in Datei
 *   b) Runnable: Objekt soll Methoden in unterschiedlichen Threads ausführen
 *   
 * Tipps zur praktischen Umsetzung:
 * - Neue einfache Klasse machen, wenn sie nirgends IS-A-Test besteht
 * - Unterklasse nur erstellen, wenn spezifischere Version einer Klasse benötigt
 * 
 * Sonstiges:
 * - Von abstrakten Klassen keine Instanzen/Objekte erstellbar!
 * - Abstrakte Klasse kann (nicht-)abstrakte Methoden haben
 * - Klasse mit einer abstrakten Methode --> Abstrakte Klasse!
 * - Referenzvariable kann auch Interface als Typ haben
 * - ArrayList<Hund> möglich, obwohl ArrayList nichts über Hund weiß, weil Compiler (Hund)/
 *   Cast_hin_zu_Hund für einen ausführt
 * 					
 * 
 *      
 *      
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
