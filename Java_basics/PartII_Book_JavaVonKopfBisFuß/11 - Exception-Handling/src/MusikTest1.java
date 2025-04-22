import javax.sound.midi.*; // Import Paket javax.sound.midi

public class MusikTest1 {
	
	public void spielen() {
		
		try {
		Sequencer sequencer = MidiSystem.getSequencer(); // ruft Exception auf:
		// Schon allein aus dem Grund, dass wir kein catch-case implementiert hatten,
		// mit try-catch funktioniert es
		System.out.println("Wir haben einen Sequencer.");
		} catch (MidiUnavailableException ex) {
			System.out.println("So ein Mist");
			}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		MusikTest1 mt = new MusikTest1();
		mt.spielen();

	}

}
