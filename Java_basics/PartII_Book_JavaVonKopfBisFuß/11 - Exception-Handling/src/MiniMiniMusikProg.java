// Spiele einen Ton vorgegeben im Code:

import javax.sound.midi.*;

public class MiniMiniMusikProg {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		MiniMiniMusikProg mini = new MiniMiniMusikProg();
		mini.spielen();
	}
	
	public void spielen() {
		try {
			// 1):
			Sequencer player = MidiSystem.getSequencer();
			player.open();
			
			// 2):
			Sequence seq = new Sequence(Sequence.PPQ,4);
			
			// 3):
			Track track = seq.createTrack();
			
			// 4)
			ShortMessage a = new ShortMessage();
			// a.setMessage(Instrumentwechselanweisung, channel, gewolltes Instrument 0-127,
			// 0); // Instrument wechseln
			a.setMessage(144,1,44,100); 
			// setMessage(Message-Typ,channel,Ton_Nr,Anschlagstärke)
			// Message-Typ: noteON=144, noteOff=128
			// Ton_Nr: 0-127
			MidiEvent noteOn = new MidiEvent(a,1); // MidiEvent(Message, Schlagangabe/wann)
			track.add(noteOn);
			
			ShortMessage b = new ShortMessage();
			b.setMessage(128,1,44,100); 
			MidiEvent noteOff = new MidiEvent(b,16);
			track.add(noteOff);
			
			// Übergeben Sequenz an Sequencer, einlegen CD in CD-Players:
			player.setSequence(seq);
			
			player.start();
			Thread.sleep(5000);
			player.close();
			
		}catch (Exception ex) {ex.printStackTrace();}
	}

}
