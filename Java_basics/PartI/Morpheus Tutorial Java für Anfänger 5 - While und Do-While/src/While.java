
public class While {
	public static void main(String[] args) {
		
		// while-loop:
		int condition = 0;
		while(condition<10) {
			condition++;			
		}
		// Variable von loop existiert auch außerhalb
		
		// do-while-Schleife:
		int condition2 = 0;
		do {
			System.out.println(condition2);
			condition2++;
		}while(condition2<10); // do-Schleife wird zuerst ausgeführt und dann überprüft!
		// stops when condition reaches 10
		// Variable von loop existiert auch außerhalb
		
		// for-loop:
		int i = 1;
		for(int zaehler=0; zaehler + i <5; zaehler++) // int oder double; Bedingung; was mit zaehler am Schleifenende gemacht wird
		// Variable zaehler existiert nur innerhalb der for-loop!
		{
			System.out.println(zaehler);
		}
		
		
		
		
	}
}
