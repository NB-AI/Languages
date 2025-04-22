
public abstract class Tier implements Lebewesen{ 
	
	final double pi = 3.14; // final: Variable ist unveränderbar fix (Konstante)
	
	private int beine; // public/gar nichts: man kann von überall auf Variable zugreifen; private: nur in dieser Klasse
	// protected: Sichtbarkeit/Nutzbarkeit der Variable NUR innerhalb eines Pakets (folder src default package)
	
	
	// Konvention zur Klassenerstellung:
	public void setBeine(int beine) { // setter
		
		if(beine<0) {// Setzen dieser condition to make logic
			this.beine = 0; // this greift auf Variable Beine definiert in dieser Klasse zu!
			return; } // return springt aus Methode raus
		
		this.beine = beine;
	}
	
	public int getBeine() { // getter
		return beine;
	}
	

	public String macheDichBermerkbar() {return "hey";}
	
	// Abstrakte Methode:
	public abstract void laufe();

	
	
	// Methode, die nicht abhängig von dem einzelnen Tier ist:
	public static String getPlanet() // static: Für diese Methode brauchen wir außerhalb dieser Klasse keine 
	// Instanziierung mehr! Unabhängig von der Tierart für alle Tiere das Selbe angegeben!
	{
		return "Erde";
	}
	
	
}
