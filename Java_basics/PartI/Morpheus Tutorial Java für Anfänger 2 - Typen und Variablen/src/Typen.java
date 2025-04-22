public class Typen {
	
	public static void main(String[] args) {
		
		// Variable integer:
		// Eine hat nur 32 bit --> 2^32 verschiedene Zahlen darstellbar, wobei ein Bit das Vorzeichen +/- darstellt
		int zahl_;
		zahl_ = 10;
		zahl_ /= 2;
		System.out.println(zahl_);
		
		// Gleitkommazahlen:
		double zahl_2; // Nur grobe Speicherung von Zahlen, ein Bit kann dazukommen
		zahl_2 = 10.2;
		
		// Characters:
		char buchstabe;
		buchstabe = 'c'; 
		System.out.println(buchstabe + buchstabe);// Jeder Buchstabe bekommt AISC-Zahl zugewiesen, 
		// die theoretisch mit anderen Buchstaben addiert werden kann.
		// Wenn die beiden Buchstaben direkt nacheinander ausgegeben werden sollen:
		System.out.print(buchstabe);
		System.out.print(buchstabe);
		// Alternative:
		String buchstabe2;
		buchstabe2 = "c";
		System.out.println(buchstabe + buchstabe2); // char + String = String + String = Addieren von Buchstaben
		
		// bool:
		boolean bool;
		bool = true;
		
	}
}
 