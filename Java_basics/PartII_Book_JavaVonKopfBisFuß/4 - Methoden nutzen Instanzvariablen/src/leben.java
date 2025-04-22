
public class leben {
	// 1.
	int gibGeheimnis(int x, int y, int integer) // Methode, die int oder einen damit kompatiblen Wert zurückliefert
	{int z = x + y; return 42+z;} // Wenn Methode mehrere Werte zurückliefern soll, muss man einen Array
	// mit diesen Werten erstellen
	
	
	// 2.
	// Getter: Wert einer Instanzvariable returnen:
	private int marke; // Kapselung: Nicht jeder hat Zugriff/Einsehbarkeit auf diese Variable
	public int getMarke() // Java-Konvention
	{return marke;}
	
	
	// Setter: Instanzvariable Wert zuteilen, nimmt nur 1 Argument:
	public void setMarke(int argument) // Kapselung: setter/getter bleiben public 
	{
		if (argument > 0) // Kapselung: damit nicht jeder den Wert der Variable unsinnig ändern kann
		{marke = argument;}
	}
	// Durch Setter kann man im Laufe der Zeit Variable ändern, ohne dass der Code auf andere negative 
	// Auswirkungen hätte, indem man erst später die Setter-Methode einbauen würde, um Bedingungen, wie
	// > 0, zu erfüllen.
	
	
	// 3. Automatische Wertzuweisung:
	int dieVariable; // Java-Konvention 
	// INSTANZvariable erhält Default-value: int/char 0; float 0.0; bool false; Referenz/String null 
	public int getDieVariable() {return dieVariable;}
	
	// Was nicht geht/Muss: Initialisierung von lokaler Variable (= in Methode definierte Variable):
	public void fail() {
		int x; // LOKALE Variable enthält keinen Default-Wert!
		int z = x + 3; 
	}
}
