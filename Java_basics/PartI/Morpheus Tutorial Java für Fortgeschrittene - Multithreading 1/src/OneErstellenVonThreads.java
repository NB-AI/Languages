
public class OneErstellenVonThreads extends Thread{
	
	String name;
	
	Integer counter; // 2. 

	// Konstruktor:
	OneErstellenVonThreads(String s, Integer counter){this.name = s; this.counter = counter;}
	
	public void run() // Sagt, was Thread machen soll
	{
		System.out.println("Starte Thread " + name);
		
		synchronized(counter) // 2. 
		// Langsamer, aber Threads die auf selbe Variable counter zugreifen, greifen jetzt
		// nacheinander darauf zu. Wichtig, wenn der Zugriff auf Variablen was verändern kann.
		// Synchronized da, damit Thread 1 und 2 nacheinander ablaufen!
		{
			for(int i = 0; i < 5; i++)
			{
			
				try {Thread.sleep(100); System.out.println(counter++);} catch(InterruptedException e){e.printStackTrace();}
			}
			
			System.out.println("Beende Thread " + name);
		}
	}

}
