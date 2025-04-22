package f;

//Wörter zufällig aus Mengen auswählen:
public class PhrasOMat {

	public static void main(String[] args) {

		// String-Arrays definieren:
		String[] wortListeEins = {"verlässliche","erfolgsorientierte","webbasierte"};
		String[] wortListeZwei = {"gepowerte","haftende","Mehrwert-"};
		String[] wortListeDrei = {"Schicht","Endstufe","Lösung"};
		
		// Längen der Listen:
		int einsLänge = wortListeEins.length;
		int zweiLänge = wortListeZwei.length;
		int dreiLänge = wortListeDrei.length;
		
		// Zufallszahlen generieren, um Wörter aus Liste zu ziehen:
		int rand1 = (int) (Math.random() * einsLänge); // random() -> 0-1
		int rand2 = (int) (Math.random() * zweiLänge);
		int rand3 = (int) (Math.random() * dreiLänge);
		
		int x = (int) 24.9; // mit (int) wandeln wir eine Zahl in int um durch Abrunden
		System.out.println(x);
		
		// Indexierte Strings zusammensetzen:
		String phrase = wortListeEins[rand1] + " " + wortListeZwei[rand2] + " " + wortListeDrei[rand3];
		// Java Index startet bei 0
		
		// Eine Phrase ausgeben:
		System.out.println("Was wir brauchen, ist eine " + phrase);
		
		// Ein String funktioniert nur, wenn man nicht ENTER drückt, während man ihn schreibt,
		// Zeilenumbruch nicht erlaubt
		
		
	}

}
