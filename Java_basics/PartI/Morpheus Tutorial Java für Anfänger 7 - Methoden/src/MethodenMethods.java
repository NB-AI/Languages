
public class MethodenMethods {
	// Methode als Funktion in Klasse 

	public static void main(String[] args) { // void ist ein Typ mit keinem return-value
		
		int returned_value = plus(5, 8); // int, wenn Method int returnt
		System.out.println(returned_value);
		String i = blubb2();
		
		for(int ii=0; ii<10; ii++) 
		{
			for(int j=0; j<20; j++) 
			{
				System.out.println(plus(ii,j));
			}
		} // insgesamt 20 Durchgänge
		
		System.out.println(plus(1,2,3));
		
		System.out.println(plus(1,2)); // int-Zahlen in Klammern: Call int Method
		System.out.println(plus(1.1,2.2)); // double-Zahlen in Klammern: Call double Method
	}
	
	private static int plus(int a, int b) {return a + b;} // private: Man kann auf die Methode nur innerhalb der
	// bezogenen Klasse benutzen; Es gibt auch protected
	
	public static String blubb2() {return "hello";} 
	
	// Überladen von Methoden (etwas Gutes):
	// Man kann gleiche Methode nochmal nehmen und ein Argument adden, sodass man sich bei Aufrufen der duplicated 
	// Methode entscheiden kann, welche mit wie vielen Argumenten gewählt werden sollte:
	// Nach hinten überladen:
	private static int plus(int a, int b, int c) 
	{
		System.out.println("Die duplicated Methode, die auch neuen Inhalt haben kann");
		return a + b + c;
		} 
	
	// Nach vorne überladen:
	private static double plus(double a, double b) 
	{
		System.out.println("Die duplicated Methode, die auch neuen Inhalt haben kann");
		return a + b;
		} 
	
	
	

}
