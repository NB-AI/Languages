
public class ThreeDeadlockBlubb { // Klasse, in der auf dieselbe Variable zugegriffen werden soll
	boolean flag2 = false; // Variable muss atomar sein (so klein wie möglich) oder int(?), damit das hier funktioniert
	
	// boolean flag3 = true; // Deadlock: Wenn durch zweite Variable beide Threads aufeinander warten
	
	// Folgende zwei Methoden gleichzeitig von zwei Threads abgespielt:
	
	public synchronized void firstThreadZugriff() // synchronized: Methoden können auf selbe Variablen zugreifen
	{
		if(flag2)
		{
			try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
		System.out.println("Ich bin der Erste");
		flag2 = true;
		notify(); // Aufwecken aller anderen Threads, in dem Fall den zweiten
		
	}
	
	public synchronized void secondThreadZugriff()
	{
		if(!flag2) 
		{
			try {
				wait(); // wartet bis erster Thread Variable auf true setzt
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
		System.out.println("Ich bin der Zweite");
		flag2 = false;
		notify();
		
	}
}
