
public class Vererbung {

	public static void main(String[] args) {
		
		// Abstrakte Klasse 'Tier'
		// Wir wollen nicht Tier t = new Tier(); , in dem Tier eine unbekannte Instanze ist, wir wollen, dass es sich
		// auf etwas Konkretes, e. g. Hund, bezieht.
		// Bei abstrakte Klasse, dieser Code der Instanzierung nicht mehr möglich, auch nich bei Interfaces!
		// Vorteil: die Klassen müssen nicht mehr die Methoden des Interface haben. Z. B. muss der Hund nicht mehr
		// atmen können.
		// Du kannst nur von einer Abstrakten Klasse erben, aber von mehreren Interfaces.
		
		
		Tier t = new Hund(); 
		t.setBeine(4);
		t.getBeine();
		t.atme();

		
		// Alternative:
		Hund h = new Hund();
		
		System.out.println(h.macheDichBermerkbar() + h.return_rasse());

		// 15 - Modifikatoren:
		Tier.getPlanet();
		
	}

}
