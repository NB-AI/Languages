
public class Vererbung {

	public static void main(String[] args) {
		
		Tier t = new Tier();
		System.out.println(t.macheDichBermerkbar());
		Hund h = new Hund();
		
		System.out.println(h.macheDichBermerkbar() + h.return_rasse());

		Tier th = new Hund(); 
		System.out.println(th.macheDichBermerkbar());
		// Man hat alle Methoden + Variablen NUR von Tier, von Hund aber die überschriebenen Methoden! Deshalb:
		// th.return_rasse() nicht möglich! 
		// Nur durch:
		Hund th2 = (Hund)th; // "Das Tier th ist ein Hund" // ABER: Wenn Tier Spinne ist und man sagt (Hund)th, 
		// dann Fehler und Programmabsturz
		System.out.println(th2.macheDichBermerkbar() + th2.return_rasse());
		
		// Neues Video: 13 - Interfaces:
		// Interfaces: Klassen, die keine richtigen Klassen sind
		th.atme();
		
		
		// Lebewesen l = new Lebewesen(); // Instanzieren von Interfaces nicht möglich, da zwar Methoden, aber keinerlei
		// Informationen darin! 
		Lebewesen f = new Fisch();
		f.atme();
		
		Lebewesen[] ls = new Lebewesen[10]; // Einen Array aus Lebewesen erstellen
		for(int i = 0 ; i < 10; i++)
		{	
			ls[i] = new Fisch(); // Erstelle Fisch in Lebewesen-Array
		}
		
		ls[5] = new Hund();
		ls[4] = new Tier();
		for(int i = 0 ; i < 10; i++)
		{	
			ls[i].atme();
		}
	}

}
