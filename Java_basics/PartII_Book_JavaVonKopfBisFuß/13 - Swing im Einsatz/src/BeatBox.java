// BeatBox erstellen, Midi abspielen, GUI,  vgl. B.S.418:

// Audio geht nicht:
/*  Some installs of the JRE do not include the JavaSound soundbank.gm
 *  (in order to save space) so your code would not have a sound source to trigger on 
 *  those machines.

Check for the existence of the soundbank on the machines that don't work. You can also put 
the soundbank in the same directory as your .class file and it will find it.


 * 
 */

import java.awt.*;
import javax.swing.*;
import javax.sound.midi.*;
import java.util.*;
import java.awt.event.*;



public class BeatBox {
	
	JPanel hauptPanel;
	ArrayList<JCheckBox> checkboxListe; // speichern der Kontrollkästchen
	Sequencer sequencer;
	Sequence sequence;
	Track track;
	JFrame derFrame;
	
	String[] instrumentNamen= {"Bassdrum","Hi-Hat, geschlossen", "Hi-Hat, offen", "Snaredrum",
			"Crashbecken","Händeklatschen","Hohe Tom-Tom","Hohes Bongo", "Marcas","Trillerpfeife",
			"Tiefe Conga","Kuhglocke","Vibraslap","Tieferes Tom-Tom","Hohes Agogo","Hohe Conga, offen"};
			// Reihe von Instrumenten, die später zeilenweise aufgelistet
	int[] instrumente = {35,42,46,38,49,39,50,60,70,72,64,56,58,47,67,63}; // Drum-Tasten
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		new BeatBox().guiErstellen();
	}
	
	public void guiErstellen() {
		derFrame = new JFrame("Cyber-BeatBox"); // !!! Frame Titel geben
		derFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		BorderLayout layout = new BorderLayout();
		JPanel hintergrund = new JPanel(layout);
		hintergrund.setBorder(BorderFactory.createEmptyBorder(10,10,10,10)); // Layout
		// Abstand zwischen Panel- und Komponentenrändern
		
		checkboxListe = new ArrayList<JCheckBox>();
		Box buttonBox = new Box(BoxLayout.Y_AXIS);
		
		JButton start = new JButton("Starten");
		start.addActionListener(new MeinStartListener());
		buttonBox.add(start);
		
		JButton stopp = new JButton("Stoppen");
		stopp.addActionListener(new MeinStoppListener());
		buttonBox.add(stopp);
		
		JButton schneller = new JButton("Schneller");
		schneller.addActionListener(new MeinSchnellerListener());
		buttonBox.add(schneller);
		
		JButton langsamer = new JButton("Langsamer");
		langsamer.addActionListener(new MeinLangsamerListener());
		buttonBox.add(langsamer);
		
		Box namensBox = new Box(BoxLayout.Y_AXIS);
		for (int i=0;i<16;i++) {
			namensBox.add(new Label(instrumentNamen[i]));
		}
		
		hintergrund.add(BorderLayout.EAST ,buttonBox);
		hintergrund.add(BorderLayout.WEST,namensBox);
		
		derFrame.getContentPane().add(hintergrund);
		
		GridLayout raster = new GridLayout(16,16);
		raster.setVgap(1);
		raster.setHgap(2);
		hauptPanel = new JPanel(raster);
		hintergrund.add(BorderLayout.CENTER,hauptPanel);
		
		// Erzeugung Kästchen, die zu Panel und ArrayList hinzugefügt:
		for(int i=0;i<256;i++) {
			JCheckBox c = new JCheckBox();
			c.setSelected(true);
			checkboxListe.add(c);
			hauptPanel.add(c);
		}
		
		midiEinrichten();
		
		derFrame.setBounds(50,50,300,300);
		derFrame.pack();
		derFrame.setVisible(true);		
	}
	
	public void midiEinrichten(){
		try {
			sequencer = MidiSystem.getSequencer();
			sequencer.open();
			sequence = new Sequence(Sequence.PPQ,4);
			track = sequence.createTrack();
			sequencer.setTempoInBPM(120);
		}catch(Exception e) {e.printStackTrace();System.out.println("oh no");}
	}
	
	//////// Zustand Kontrollkästchen in MIDI-Events umwandeln und Track hinzufügen:
	
	public void trackErstellenUndStarten() {
		int[] trackListe=null;
		
		sequence.deleteTrack(track); // !!!
		track=sequence.createTrack();
		
		for(int i=0;i<16;i++) { // durchgehen instrumente
			trackListe = new int[16]; // 16 Schläge lang; gibt an, ob man eine Note zu
			// bestimmten Zeitupunkt spielen soll
			
			int taste = instrumente[i];  // 16 verschiedene Instrumente
			
			for (int j=0;j<16;j++) { // durchgehen Schläge
				JCheckBox jc = checkboxListe.get(j+(16*i)); // Um in langer ArrayList mit
				// shape 16x16 die richtige Box zu finden
				if (jc.isSelected()) { // falls ein Haken an der Box ist
					trackListe[j]=taste; // spiele das
				}else {trackListe[j]=0;} // spiele nichts
			}
		System.out.println("work1");
		trackErzeugen(trackListe);	
		
		}
		
		track.add(eventErzeugen(192,9,1,0,16)); // erzeugt ein event am Ende von Schlag '16'.
		// So sichergestellt, dass alle 16 Schläge durchlaufen. Ansonsten keine Bedeutung
		
		try {
			sequencer.setSequence(sequence);
			sequencer.setLoopCount(Sequencer.LOOP_CONTINUOUSLY); // Anzahl BeatBox-Schleifen-
			// Iterationen festlegen, hier kontinuierlicher Durchlauf. 
			// Hier spielt die BeatBox einfach immer weiter, ohne von allein aufzuhören
			
			sequencer.start();
			sequencer.setTempoInBPM(120);
		}catch(Exception e){e.printStackTrace();}
		System.out.println("work2");
	}

	public class MeinStartListener implements ActionListener{
		public void actionPerformed(ActionEvent a) {
			trackErstellenUndStarten();
		}
	}
	
	public class MeinStoppListener implements ActionListener{
		public void actionPerformed(ActionEvent a) {
			sequencer.stop();
		}
	}
	
	public class MeinSchnellerListener implements ActionListener{
		public void actionPerformed(ActionEvent a) {
			float tempoFactor = sequencer.getTempoFactor();
			sequencer.setTempoFactor((float)(tempoFactor*1.03)); 
			// tempoFactor passt Tempo Sequencers gemäß des angegebenen Faktors. Ausgangswert
			// 1.0
			// Hier 3 % schneller pro Userklick werden
			// !!!
			
		}
	}
	
	public class MeinLangsamerListener implements ActionListener{
		public void actionPerformed(ActionEvent a) {
			float tempoFactor = sequencer.getTempoFactor();
			sequencer.setTempoFactor((float)(tempoFactor *.97));
			
		}
	}
	
	public void trackErzeugen(int[] liste) { // pro Instrument ein Track
		for(int i=0;i<16;i++) {
			int taste = liste[i];
			System.out.println("work3-"+taste);
			if(taste!=0) {
				track.add(eventErzeugen(144,9,taste,100,i));
				track.add(eventErzeugen(128,9,taste,100,i+1));
			}
		}
	}
	
	public MidiEvent eventErzeugen(int comd, int chan, int one,int two,int tick) {
		MidiEvent event = null;
		try {
			ShortMessage a = new ShortMessage();
			a.setMessage(comd,chan,one,two);
			event=new MidiEvent(a,tick);
		}catch(Exception e) {e.printStackTrace();}
		return event;
	}
	
	
	
	
	
	
	
	
}