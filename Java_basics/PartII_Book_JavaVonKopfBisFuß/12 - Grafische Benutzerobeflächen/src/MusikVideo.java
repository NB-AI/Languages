
// Soll mit jeder neuen Note als midi-message ein neues farbiges, anders lokalisiertes Rechteck
// erzeugen:

import javax.sound.midi.*;
import javax.swing.*;
import java.awt.*;

public class MusikVideo {
	
	static JFrame f = new JFrame("Mein erstes Musikvideo");
	// statische Variable: Wert, den alle Instanzen miteinander teilen; Variable pro Klasse statt
	// pro Instanz
	static MeinZeichenPanel ml;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		MusikVideo mv = new MusikVideo();
		mv.los();

	}
	
	public void guiErstellen() {
		ml = new MeinZeichenPanel();
		f.setContentPane(ml); // keine add methode benutzt;
							  // das Panel 'ml' wird zur contentPane gemacht, die oben als
							  // reine Java-Schicht auf Frame sitzt, der nicht nur Java ist;
							  // sondern sich mit dem Betriebssystem verbindet.
		
							  // Dieser Prozess bleibt so, auch wenn man ab Java 5.0 
							  // frame.add("ml") verwenden kann, Button immer zu ContentPane
							  // statt JFrame hinzugefügt.
		f.setBounds(30,30,300,300);
		f.setVisible(true);
		
	}
	
	public void los() {
		guiErstellen();
		
		try {
			Sequencer sequencer = MidiSystem.getSequencer();
			sequencer.open();
			sequencer.addControllerEventListener(ml,new int[] {127});
			// '127' soll das spezifische Event sein, auf das immer reagiert, indem ein
			// neues Rechteck erstellt wird. Wir werden immer ein Event '127' manuell
			// erstellen, wenn eine neue Note erstellt
			//
			// '{127}' als Liste von Events, die wir beobachtet haben wollen
			//
			// addControllerEventListener(listener,Liste_interessanter_ControllerEvents)
			
			Sequence seq = new Sequence(Sequence.PPQ, 4);
			Track track = seq.createTrack();
			
			int r=0;
			for(int i=0;i<60;i+=4) {
				r = (int) ((Math.random()*50)+1); // zufällige Noten-ID erzeugen
				track.add(eventErzeugen(144,1,r,100,i)); // note on erzeugen, da '144'
				track.add(eventErzeugen(176,1,127,0,i)); // Oben besagtes Event '127' erzeugen
				// machts nichts spezielles
				
				track.add(eventErzeugen(128,1,r,100,i+2)); // note off erzeugen, da '128'
			}
			
			sequencer.setSequence(seq);
			sequencer.start();
			Thread.sleep(5000);
			sequencer.close();
			sequencer.setTempoInBPM(120);
		}catch(Exception ex) {ex.printStackTrace();}
	}

	public MidiEvent eventErzeugen(int comd,int chan, int one, int two, int tick){
		// returnt MidiEvent
		
		MidiEvent event = null;
		
		try {
			ShortMessage a = new ShortMessage();
			a.setMessage(comd,chan,one,two);
			event = new MidiEvent(a,tick);
		}catch (Exception e) {}
		
		return event;
	}
	
	class MeinZeichenPanel extends JPanel implements ControllerEventListener{
		// ControllerEvent als MidiEvent, auf das man lauschen kann
		
		boolean msg=false;
		
		public void controlChange(ShortMessage event) { // automatisch aufgerufen, kommt von
			// ControllerEventListener-Interface.
			// Geht bei speziellen Event los.
			// ist wie Methode 'actionPerformed'!
			msg=true;
			repaint(); // dann Aufruf von 'repaint()'-Methode
			// setzt paintComponent in Gang!!!
		}
		
		public void paintComponent(Graphics g) {
			if (msg) { // weil auch andere Dinge 'repaint()'-Methode aufrufen können, haben
				// wir oben sicher gestellt, dass nur unser spezifisches Event passiert
				Graphics2D g2 = (Graphics2D) g;
				
				int r = (int) (Math.random()*250);
				int gr = (int) (Math.random()*250);
				int b = (int) (Math.random()*250);
				
				g.setColor(new Color(r,gr,b));
				
				int höhe = (int) ((Math.random()*120)+10);
				int breite = (int) ((Math.random()*120)+10);
				
				int x = (int) ((Math.random()*40)+10);
				int y = (int) ((Math.random()*40)+10);
				
				g.fillRect(x,y,höhe,breite);
				msg=false;
			}
		}
	}
}
