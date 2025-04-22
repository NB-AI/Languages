// Mit Vorcode
// !!! für Neues zum Lernen

// Ziele der Klasse: Spiel einrichten/spielen/beenden

import java.util.*;

public class DotComSpiel {

	public static void main(String[] args) {
		DotComSpiel spiel = new DotComSpiel();
		spiel.spielEinrichten();
		spiel.beginneSpiel();
	}
		
	// Benötigte Variablen:
	// Spielhelfer
	private SpielHelfer helfer = new SpielHelfer();
	// dot ComListe ArrayListe, in der alle DotComs gespeichert
	private ArrayList<DotCom> dotComListe = new ArrayList<DotCom>();
	// Anzahl Rateversuche
	private int anzahlVersuche=0;
		

		
	// Methodendeklaration:
	// spielEinrichten(): Lokalisierte, benamte DotCom-Objekte erzeugen; Spieleanleitung anzeigen
	// beginneSpiel(): Aufforderung zum Raten des Users; Rateversuch auswerten durch Aufruf prüfeRateversuch()
	// prüfeRateversuch()
	// beendeSpiel(): Bewertung Nutzer anzeigen

	// Methode void spielEinrichten(): 
	// dotCom-Objekte erzeugen
	// diesen Namen geben
	// der ComListe hinzufügen
	// for element in ComListe: Aufruf platziereDotCom(); nutze Ergebnis, um Ort festzusetzen
	void spielEinrichten() {
		DotCom eins = new DotCom();
		eins.setName("Haustiere.com");
		
		DotCom zwei = new DotCom();
		zwei.setName("BioWare.com");
		
		DotCom drei = new DotCom();
		drei.setName("FragMich.com");
		
		dotComListe.add(eins);
		dotComListe.add(zwei);
		dotComListe.add(drei);
		
		
		System.out.println("Ihre Aufgabe ist es, drei DotComs zu versenken.");
		System.out.println("Haustiere.com, BioWare.com, FragMich.com");
		System.out.println("Versuchen Sie, diese mit so wenig Versuchen wie möglich zu erledigen.");
		
		
		for (DotCom aktuellesDotCom:dotComListe) {
			ArrayList<String> neuerOrt = helfer.platziereDotCom(3);
			aktuellesDotCom.setZellorte(neuerOrt);
		}
	}
	
	// Methode void beginneSpiel():
	// while DotComs existent: holeBenutzereingabe(); prüfeRateversuch()
	void beginneSpiel() {
		
		while (!dotComListe.isEmpty() ) // !!! '!' als Negation, = x.isEmpty()==false
		{
			String rateversuch = helfer.getBenutzereingabe("Geben Sie einen Rateversuch ein");
			prüfeRateversuch(rateversuch);
		}
		beendeSpiel();
	}
	
	// Methode void prüfeRateversuch(String rateversuch) - Treffer/Versenkt/Vorbei?: 
	// Variable anzahlRateversuche
	// String ergebnis = Vorbei;
	// for ele in comListe: prüfDich(); Treffer/Versenkt?; wenn versenkt, entferne DtoCom aus ComListe
	// Anzeigen ergebnis
	void prüfeRateversuch(String rateversuch) {
		
		anzahlVersuche++;
		String ergebnis="Vorbei";
		
		for (DotCom ele : dotComListe) {
			ergebnis = ele.prüfDich(rateversuch);
			if (ergebnis.equals("Treffer")) {break;}
			if (ergebnis.equals("Versenkt")) {dotComListe.remove(ele);break;}
		}
		System.out.println(ergebnis);
	}
	
	// Methode void beendeSpiel():
	// "Game over"
	// if-clause mit Beglückwunschung/Verachtung zu anzahlRateversuche
	void beendeSpiel() {
		
		System.out.println("Game over");
		if (anzahlVersuche<18) {System.out.println("Good job!");}
		else {System.out.println("Loooooooooooooooooooser");}
		
	}
	
	
	
	

}
