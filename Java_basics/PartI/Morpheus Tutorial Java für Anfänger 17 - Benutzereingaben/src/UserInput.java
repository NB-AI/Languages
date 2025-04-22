import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
// import java.awt.*; // Nicht gebraucht hier. Eigene Packages importieren

public class UserInput {

	public static void main(String[] args) {
		BufferedReader blubb = new BufferedReader(new InputStreamReader(System.in)); // System.in: hier input stream
		
		String input = "";
		
		input = null; // Variable hat keinen Inhalt; null-pointer, wenn man darauf zugreift
				
		// Zugriff auf buffered reader:
		try {
			input = blubb.readLine(); // Lese immer nur eine Zeile
		}catch(IOException e) {e.printStackTrace();} // IO: Input-Output
		finally {System.out.println("Finally printet immer");}
		
		System.out.println("Eingegeben wurde: " + input);
		
		/* 
		 * Mehrzeiliger Kommentar 
		 * */
		
	}

}
