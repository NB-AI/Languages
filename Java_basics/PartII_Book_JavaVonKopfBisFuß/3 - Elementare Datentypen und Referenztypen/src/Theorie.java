/*
 * Elementare primitive Typen: einfache Bit-Muster enthalten: int,bool,float. Normale Becher als Analogie
 * zu Datentypen, die Größe des Bechers bestimmt den Bit-Umfang, e.g. von groß nach klein: long/double,
 * int/float, short/char, byte (64,32,16,8 bit). Wertebereiche B.S. 51. Egal, welche Werte benutzt werden,
 * man kann niemals von einem größeren Typ in einen kleineren wechseln.
 * Float deklarieren: float f = 23.3f;, ansonsten denkt Java, dass es eine double ist ohne 'f'.
 * Deklarieren: man kann sofort einen Wert zuweisen (int x = 5;), muss aber nicht (int x;) 
 * Klassen/Objekte/Variablen: Man soll ihnen Namen geben, die mit _ oder $ beginnen;
 * Bits repräsentieren tatsächlichen Wert der Variable!
 * 
 * Bits repräsentieren einen Weg, Objekt zu finden (Art "Zeiger", aber eher Referenz):
 * Objektreferenzen: Halten Referenzen auf Objekte; Objekt=Variable für nicht-elementare Typen; es gibt
 * keine Objektvariable, aber eine ObjektREFERENZvariable, die Bits enthält, die ein Mittel für den Zugriff
 * auf ein Objekt repräsentieren, enthalten eines Zeigers! Objekte immer im Garbage Collectible Heap 
 * gespeichert.
 * e.g. name_klasse.name_methode(); : "nimm name_klasse, um name_methode zu finden".
 * Länge der Bit-Zahl egal, wohl 64 Bit groß.
 * Der Becher wäre hier die Klasse da e.g. Hund Bello = new Hund(); mit "Hund Bello", "new Hund()" ist 
 * der Speicherort im Heap, "=" verweist auf diesen Speicherort für die Instanze. Einmal Hund immer Hund!
 * Möglich den Zeiger von einem individuellen Hund auf einen anderen zeigen zu lassen, außer wenn mit
 * 'final' markiert, dann nur dieses eine Objekt referenzierbar!
 * Keine C-Sprache-Operationen möglich!
 * Wenn Referenz/"Zeiger" nach Deklarierung auf null gesetzt wird, kann man nicht mehr auf das alte Objekt
 * zugreifen und für die Garbage Collection freigegeben.
 * Wenn Buch b = new Buch(); Buch c = new Buch();, haben wir zwei Objekte auf dem Heap gespeichert (eben
 * nicht die Klasse). 
 * Wenn Buch d = c;, dann greifen c und d auf das gleiche Objekt zu (Bit-Kopie von c auf d)! 
 * Wenn nun c=b; dann ändert sich die Referenz von c auf die von b, sodass diese auf gleiches Objekt 
 * zugreifen! Sollte auf c sein altes Objekt nichts mehr zeigen, so kommt altes, ungenutztes Objekt zu 
 * Garbage Collection (GC). 
 * Wenn c=null;, dann besteht die Referenz weiter und kann anderem Objekt zugewiesen werden.
 * Auch Arrays sind diese Art von Objekte
 */
public class Theorie {
	
	// Die Test-class kann die gleiche wie die Objekt-class sein. 
	
	// Wenn in einer Methode eine Instanzvariable kreiert, dann diese so behandelt, als wäre sie von
	// Anfang an erstellt worden!
	// void setFläche() {fläche=...;}, dann ele.setFläche(); ele.fläche;
	
	public static void main (String[] args) {
	int x = 4;
	int y = x;
	x = 44; // y wird hier nicht überschrieben! Nur alte x-Version benutzt
	System.out.print(y); // out: 4
	
	// Becher kreieren, der auf ein array-Objekt mithilfe einer Referenz zeigt, auf dem die einzelnen
	// Zahlen (auch Referenzvariable möglich) im Array-Objekt gespeichert werden:
	int[] zahlen;
	zahlen = new int[7]; // int[7]: wir erhalten array mit Länge 7, der NUR int ODER KLEINERES speichern kann
	zahlen[0] = 6;
	// Gleiches mit Referenzvariablen machen:
	// name_class[] haustiere;
	// haustiere = new name_class[length_array]; // array kann NUR name_class als Elemente aufnehmen!
	// haustiere[0] = new name_class(); // bei arrays mit Referenzobjekten muss man immer erst eine
	// Objektverbindung herstellen! (Gilt nicht für arrays mit primitiven Typen, wie int,...)
	// haustiere[0].name = "Bello"; // Instanzvariable setzen für ein array-Element
	// haustiere[0].bellen(); // Methode verwenden für ein array-Element
	
	
	}
}
