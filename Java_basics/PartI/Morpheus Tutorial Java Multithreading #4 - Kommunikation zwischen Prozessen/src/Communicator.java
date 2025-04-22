
public class Communicator {
	
	volatile boolean flag2 = false; // volatile: Diese Variable kann von einem Thread geändert werden, sodass sie 
	// erneut gecheckt werden muss; Threads teilen sich kleinen Speicher flag --> Kann von beiden Threads gleichzeitig
	// angesprochen werden (shared memory)
	// Threads können dadurch parallel laufen!
	
	int a = 0;
	volatile String s = ""; // volatile nicht nötig hier
		
	public void q(String msg)
	
	{
		//synchronized (msg) {} // gleiche Argumente wie bei der Methode notwendig // synchronized Block:
		// nur ein Thread darf zeitgleich in diesem individuellen Block tätig sein!
		
		while(flag2){} // Wenn wir anfangen zu lesen, soll selbes drin stehen, wie wenn wir das Lesen beenden
		flag2 = true;
		a = 1;
		s = "Thread 1";
		//notify(); // notify() geht nur, wenn Methode synchronized ist! Selbes gilt für wait().
		// Weckt thread auf, der in dieser Class schlafen gelegt wait() wurde; 
		// notifyall() würde alle Threads aufwecken!
		
	}
	
	public void a(String msg)
	{
		while(!flag2) 
		{}
		
		System.out.println(msg);
		flag2 = false;
		
		if(a==1) {System.out.println("a ist 1"); }
		a=2;
		System.out.println("Letzte Veränderung in " + s);
		s = "";
		// notify();
	
		
	}
	
	
	public static void main(String[] args) {
		
		Communicator c = new Communicator();
		
		new Thread(new Thread2(c)).start();
		new Thread(new Thread1(c)).start();
	}
}

