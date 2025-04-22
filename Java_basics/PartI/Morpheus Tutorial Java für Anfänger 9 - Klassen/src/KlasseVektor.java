
public class KlasseVektor {
	int x;
	int y;
	int z;
	
	public KlasseVektor add(KlasseVektor a, KlasseVektor b) // Zwei Vektoren gegeben und einzelne Elemente werden addiert:
	{
		KlasseVektor returned = new KlasseVektor();
		returned.x = a.x + b.x;
		returned.y = a.y + b.y;
		returned.z = a.z + b.z;

		return returned;
	}
	
	// static:
	public static KlasseVektor add1(KlasseVektor a, KlasseVektor b) // Zwei Vektoren gegeben und einzelne Elemente werden addiert:
	{
		KlasseVektor returned = new KlasseVektor();
		returned.x = a.x + b.x;
		returned.y = a.y + b.y;
		returned.z = a.z + b.z;
		
		return returned;
	}
	
	// this:
	public KlasseVektor add2(KlasseVektor a) // Zwei Vektoren gegeben und einzelne Elemente werden addiert:
	{
		KlasseVektor returned = new KlasseVektor();
		returned.x = a.x + this.x; // this bezieht sich auf die Komponente, über die die Methode aufgerufen wurde.
		// Hier ist es v, da v.add(v2) in main class.
		// Methode kann nicht static sein, da static keinen Bezug zu etwas hat.
		returned.y = a.y + this.y;
		returned.z = a.z + this.z;
		
		return returned;
	}
	
	
	
	
	// Java für Anfänger 10 - Konstruktoren und mehr zu Klassen:
	
	public KlasseVektor() // Wenn KlasseVektor vk = new KlasseVektor() in main function, dann wird diese Funktion
	// hier aufgerufen, wie def __init__ in python
	{
		this.x = 0;
		this.y = 0;
		this.z = 0; 
	}
	
	// Überladen Konstruktor:
	public KlasseVektor(int x) 
	{
		this.x = x;
		this.y = 0;
		this.z = 0; 
	}
	
	
	// Weiteres zu Klassen:
	public String toString() // Die vorgegeben toString Methode würde lediglich "xxx" statt "xyz" ausgeben
	{
		
		return "x = " + this.x + " and y = "+this.y + " and z = "+this.z;
	}
	
	
	// Java für Anfänger 14 - abstakte Klassen und -konventionen:
	// Ein Tier soll nicht nur irgendwas Unbekanntes sein, sondern etwas Konkretes, wie z. B. ein Hund
	
	
}
