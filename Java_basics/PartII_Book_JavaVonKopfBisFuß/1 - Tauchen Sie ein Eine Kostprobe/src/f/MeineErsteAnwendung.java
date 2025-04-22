
// Man kann viele Klassen nutzen, wovon nur eine eine main-Methode hat, von der aus das Programm gestartet wird.

// Jini-Surrogatarchitektur: Geräte mit implementierten Java so programmieren, sodass sie miteinander
// kommunizieren. Geräte ohne Java dafür über Java-Geräte steuern. 

package f;

public class MeineErsteAnwendung {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Ich herrsche!");
		System.out.println("über die Welt");
		
		int x = 3;
		x = x * 17;
		System.out.print("x ist " + x);
		
		double d = Math.random();
		
		String name = "Dirk";
		
		while (x>12) {x = x - 1;}
		for (int x2 = 0; x2 < 10; x2 = x2 + 1) 
			{System.out.print("\nx2 ist jetzt " + x2); 
			// Das gleiche wie System.out.println("x2 ist jetzt " + x2);
			}
		
		if (x == 10) {System.out.print("\nx ist 10 ");}
		else {System.out.print("\nx ist nicht 10 ");}
		
		if ((x < 3) & (name.equals("Dirk"))) {System.out.println("\nVorsicht");}
		
		System.out.print("\nDiese Zeile wird auf alle Fälle ausgeführt");
		
		
	}

}
