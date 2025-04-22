
public class Main {

	public static void main(String[] args) {
		
		
		// 2. Synchronisieren Threads, sodass sie auf selbe Variable zugreifen nacheinander nicht gleichzeitig:
		Integer counter = 0; // Integer als Klasse, bei der man auch Long/... bekommen kann
		
		

		// 1. Erstellen von Threads:
		
		OneErstellenVonThreads t1 = new OneErstellenVonThreads("Erster Thread", counter );
		OneErstellenVonThreads t2 = new OneErstellenVonThreads("Zweiter Thread", counter);
		
		t1.start();
		t2.start();
		// Zweiter Thread kann auch schneller sein als erster und deshalb vor erstem starten.
		

		// 2. Warten bis einzelne Threads beendet sind:
		// Main ist auch ein Thread, der die anderen beiden Threads erstellt.
		try {
			t1.join(); // Warten bis t1 beendet/run-Methode returnt 
			// Sehr praktisch, wenn unser Main-Thread auf Thread t1 warten möchte, wenn t1 etwas erstellt, was weiter
			// unten im Code von Main-Thread nochmal gebraucht wird! Ansonsten würde Main-Thread schneller fertig werden
			// als t1.
			// Join dafür da, dass Main-Thread wartet!
			t2.join();
		} catch (InterruptedException e) {e.printStackTrace();}
		
		System.out.println("Ende des Programms 1");
		
		
		// 3. Deadlocks: Zugriff auf dieselbe Variable, die wir verändern duch verschiedene Threads, evtl. doppelt
		// so schnell Variablen verändern
		ThreeDeadlockBlubb b = new ThreeDeadlockBlubb();
		ThreeDeadlock t1d = new ThreeDeadlock("Erster Thread", b, true);
		ThreeDeadlock t2d = new ThreeDeadlock("Zweiter Thread", b, false);
		
		t1d.start();
		t2d.start();
		
		try {
			t1d.join();  
			t2d.join();
		} catch (InterruptedException e) {e.printStackTrace();}
		
		System.out.println("Ende des Programms 2");
		

	}

}
