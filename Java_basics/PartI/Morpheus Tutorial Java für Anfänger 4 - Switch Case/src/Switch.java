
public class Switch {

	public static void main(String[] args) {
		int monat = 0; // char or String
		switch(monat) { // loop ähnlich zu if-else
		case 1: System.out.println("Januar"); // case, dass Monat 1 ist/mit 1 beginnt
		break; // Ohne dieses wird die folgende Bedingung darunter nicht mehr überprüft und ausgeführt!
		// break bricht schleife ab
		case 2: System.out.println("Feb");
		break;
		default: System.out.println("Anderer Monat"); // das tritt immer ein, wenn andere nicht passieren
		break;
		}
	}

}
