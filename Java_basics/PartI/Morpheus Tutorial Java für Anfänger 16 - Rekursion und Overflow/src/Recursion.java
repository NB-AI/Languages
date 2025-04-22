
public class Recursion {

	public static void main(String[] args) {
		
		System.out.println(fakult(6));
		
		int[] fibos = new int[100]; // Speichern von Fibbonaci Zahlen, um diese wiederzuverenden in for-loop, 
		// less complexity
		for(int i = 1 ; i < 100; i++) {
			
			if(fibos[i]==0) {fibos[i]=fibo(i, fibos);}
		}
		System.out.println(fibos[99]); // neg. Zahl, da int nur 32 bit hat und wir diese übersteigen --> Overflow,
		// Wenn größte 32 bit Zahl + 1, dann ist man bei kleinster bit Zahl.
		// Use long[] fibos für größere Range, reicht aber auch nicht für fibos[99]
		
	}
	
	public static int fakult(int n) { // static: damit oben aufrufbar
		
		if(n<0) {return 0;}
		if(n==0) {return 1;}
		if(n==1) {return 1;}
		else {return n * fakult(n-1);}
	}
	
	public static int fibo(int n, int[] fibos) { 
		if (n==1) {return 1;}
		if (n==0) {return 0;}
		
		if(fibos[n-1]==0) {fibos[n-1]=fibo(n-1, fibos);} // Sollte im Array immer schon berechnet sein wegen 
		// äußere for-loop
		if(fibos[n-2]==0) {fibos[n-2]=fibo(n-2, fibos);}
		return fibos[n-1] + fibos[n-2];
	}

}
