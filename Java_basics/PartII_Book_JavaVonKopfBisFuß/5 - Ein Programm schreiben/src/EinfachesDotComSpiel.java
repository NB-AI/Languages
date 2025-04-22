

public class EinfachesDotComSpiel {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int anzahlTipps = 0;
		
		UserInput helfer = new UserInput();
		
		EinfachesDotCom dasDotCom = new EinfachesDotCom();
		
		int zufallsZahl = (int) (Math.random() * 5); // !!! (int) = cast/Typumwandlung, der Folgendes
		// zwingt, seinen Typ anzunehmen. Math.random() liefert double 0-0.99999999999999999999... .
		// Man kann hier also größere Becher in kleinere Stecken mit Datenverlust (Abschneiden Bits auf
		// linken Seite):
		// Deshalb funktioniert mit Cast nun auch: long y=34;int x=(int)y; --> x=34
		// Davor ging es nicht!
		// Wenn y außerhalb Wertebreich von x, dann erhält x ungewöhnliche Zahlen (Anhang B)
		
		int[] orte = {zufallsZahl, zufallsZahl+1, zufallsZahl+2};
		dasDotCom.setZellorte(orte);
		boolean lebt=true;
		// Schleife, die genau ein Spiel lang andauert:
		while (lebt==true){
			String tipp = helfer.getBenutzereingabe("Geben Sie eine Zahl ein");
			String ergebnis = dasDotCom.prüfDich(tipp);
			anzahlTipps++;
			if (ergebnis.equals("Versenkt")) {
				lebt=false;
				System.out.println("Sie haben " + anzahlTipps + " Versuche benötigt");
			}
		}
		
	}

}
