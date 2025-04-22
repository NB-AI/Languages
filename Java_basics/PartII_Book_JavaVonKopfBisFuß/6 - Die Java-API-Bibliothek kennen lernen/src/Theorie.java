/*
 * 
 * Array-List:
 * Aus API kann man diese nutzen als ein Array, den man schrumpfen kann; wo man nicht alles durchsuchen
 * muss, um zu sagen ob etwas enthalten; man Dinge rausholen kann, ohne Wissen, an welchem Platz es steckt.
 * Klassen bereits kompiliert! 
 * add/remove/contains/indexOf(Object elem) - indexOf: wenn kein Index gefunden, dann -1 returnt!
 * remove/get(int index)
 * isEmpty/size()
 * add(int index, Object o): sagen, wo das neue Objekt eingefügt werden soll
 * ...
 * Arbeit mit ihr vgl class Theorie unten
 * 
 * Nachteile:
 * - Ticken langsamer als Array
 * - Um elementare Typen zu speichern, muss man diese zuerst in eine Wrapper-Klasse stecken (Kapitel 10)
 *   --> Seit Java 5.0 geschieht das automatisch
 * 
 * Normale Arrays besitzen eine einzige Instanzvariable length und keinerlei Methoden. Sie haben eine
 * Java-untypische Syntax
 * 
 * 
 * 
 * Packages:
 * javax: Standarderweiterungen: offizielle Erweiterungen, die noch nicht weit genug für eine offizielle
 * Eingliederung sind. Mittlerweile aber offiziell anerkannt. Nicht-Standarderweiterungen auch möglich.
 * 
 * API:
 * 1. Welche Klassen in der Bibliothek?
 * Referenzbuch, e.g. auf B.S. 158,
 * java.sun.com/j2se/1.5.0/docs/api/index.html
 * 2. Was kann eine gefundene Klasse?
 * HTML-API-Dokumentation, Java 5 Standard Edition Documentation, (Java 3 Standard Edition 5.0),
 * java.sun.com/j2se/1.5.0/docs/api/index.html
 */
import java.util.ArrayList; // package: java.util; class: ArrayList
// Alternativ kann man überall im Code Namen hinschreiben, e.g.
// java.util.ArrayList<Hund> h = new java.util.ArrayList<Hund>();

// Packages der java.lang wie System.out.println, math.random() können ohne weiteres genutzt werden

public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// 1. ArrayList
		ArrayList<Ei> meineListe = new ArrayList<Ei>(); // <Ei>: Mach die Liste zu einer Liste mit Ei-Objekten,
		// Typparameter, seit Java 5.0. Hier müsste Ei eine spezielle Klasse sein, damit Code funktioniert.
		// Leere ArrayList auf Heap angelegt, kann im Speicher wachsen und so später mehr verbrauchen durch
		// Aufnahme von Objekten/Instanzen:
		Ei s = new Ei();
		meineListe.add(s);
		
		Ei b = new Ei();
		meineListe.add(b);
		
		int dieGröße = meineListe.size();
		boolean istDarin = meineListe.contains(s);
		int gefundenerIndex = meineListe.indexOf(b);
		boolean leer = meineListe.isEmpty();
		meineListe.remove(s);
		
		// B.S. 134 (Lösung B.S. 136) Convert ArrayList into normal Array:
		String[] meineListe2 = new String[2];
		String a = new String("huhu");
		meineListe2[0] = a;
				
		String b2 = new String("Frosch");
		meineListe2[1] = b2;
		
		System.out.println(meineListe2.length);
		
		System.out.println(meineListe2[1]);
		
		// Löschen von Element 0. Setze es einfach auf 0
		String[] meineListe1 = new String[1];
		meineListe1[0] = b2;
		
		boolean returner = false;
		for(String ele : meineListe) {
			
			if(ele.equals(b)) {returner= true;break;}
		System.out.println(returner);
		}
		
		

	}

}
