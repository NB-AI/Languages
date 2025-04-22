
// Zur Testlaufzeit hochgehen des Codes -> Exception raisen
// Vorteil Objektorientierung: Man kann auf andere, nicht von uns implementierte Objekte zugreifen, die 
// unseren Job erledigen, ohne dass wir genau wissen, wie sie es machen. e.g. Nutzerinput holen


public class EinfachesDotComTestlauf {

	public static void main(String[] args) {
		
		// Testcode, der geschrieben, bevor er überhaupt ausgeführt werden kann, da Hauptcode fehlt:
		EinfachesDotCom dotCom = new EinfachesDotCom();
		int[] orte = {2,3,4};
		dotCom.setZellorte(orte);
		String tipp = "2";
		String ergebnis = dotCom.prüfDich(tipp);
		String testErgebnis = "Fehlgeschlagen";
		if (ergebnis.equals("Treffer")) {testErgebnis="Bestanden";}
		System.out.println(testErgebnis);
	}

}
