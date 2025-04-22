/*
 * - Handeln von Code, bei dem wir nicht garantieren können, dass er zur Laufzeit funktioniert,
 *   e.g. Server funktioniert nicht, Thread wird wach, Datei im falschem Verzeichnis
 * - Ziel kommender drei Kapitel: MIDI-Musikplayer programmieren --> JavaSound-API riskant
 * 
 * MIDI:
 * - Anweisungen, nach denen ein MIDI-lesendes Instrument (= MIDI-Gerät,
 *   Midi-Datei lesend + abspielen) wiedergeben kann
 * - JavaSound: MIDI und Sampled beinhaltet
 * - MIDI: Gibt Notenanweisungen, doch weiß nicht, wie diese Noten klingen. Das erledigt 
 *   wiederum MIDI-Gerät, das Instrument ansteuert. Das kann mit Hardware sein, 
 *   e.g. Keyboard-Synthesizer, oder auch voll Software, Synthesizer/Software-Synth
 * - Sequencer-Objekt: Nimmt alle Midi-Daten entgegen und sendet sie an richtige Instrumente.
 *   Hier als Wiedergabegerät. Midi-Infos zu einem Musikstück sequenziert
 *   Paket: javax.sound.midi
 *   hier class MusikTest1
 * - 1) Sequencer: CD-Player, der Sequenz spielt.
 *   2) Sequenz: Musikstück, CD, enthält/hat einen Track.
 *   3) Track: Enthält Daten über Song.
 *   4) Daten: Nachrichten/Midi-Events, die Sequencer versteht, e.g. 'Spiele zu time t Note n  
 *             mit einer Dauer d.','Wechsle Instrument jetzt zu Querflöte.'
 *             Angabe, was (message) wann (in Schlag-Angabe) zu tun (MidiEvent).
 *   --> class MiniMiniMusikProg enthält deren Markierungen
 *   
 * --------------------------------------------------------------------------------------------
 * 
 * Exceptions:
 * - e.g. wenn man fremde, riskante Klassen benutzt. Herausfinden, dass riskant, durch 
 *   Deklaration der fremden Klasse auf java.sum.com (API-Dokumentation). 
 *   Dort 'Throws' in Klassenbeschreibung, die beschreibt, warum Exception geworfen.
 *   Methoden verpflichtet, ihr Risiko mitzuteilen (throws exception):
 *   
 *   public void risky_method() throws SchlimmeException{
		if (alleHoffunungVerloren) {
			throw new SchlimmeException();}
		code_der_ignoriert_wenn_exception_gethrowt
	 }
	 
	 
	
	 Code, der risky Code aufruft (abfangen Exception):
	 try{
	 	einObjekt.risky_method();
	 	übersprungener_code_falls_risky_method_exception_auslöst_und_direkt_zu_catch_springt
	 	}catch(SchlimmeException ex){
	 	ex.printStackTrace();} // Auflistung aufgerufener Methoden, sodass Fehler zurückverfolgbar
	 	finally{was_immer_passiert_(selbst wenn 'return' in try/catch!)}
 *   
 * - Compiler muss wissen, dass wir wissen, dass riskante Methode aufgerufen!
 *   Ansonsten auf jeden Fall Exception geschmissen, sodass wir potenzielle Problematik immer 
 *   mitbekommen
 * - Code in class MusikTest1
 * - Exception Objekt vom Typ Exception,
 *   sie ist Unterklasse von Throwable und Oberklasse von IOException, InterruptedException,
 *   RuntimeException (parent von ClassCastException, NullPointerException; werden nicht
 *   geprüft, da diese meist auf vermeidbare Fehler im eigenem Code basieren, die behandelbar).
 *   IOException, InterruptedException werden vom Compiler geprüft auf
 *   Werfen/Abfangen/Deklarieren der Exception (checked Exceptions).
 * - catch(Exception_als_Objekt Referenzvariable_name)
 * - Riskante Methode wirft Exception zurück
 * 
 * - Mehrere Exceptions:
 * 
 *   Methode, die exception wirft:
 *   public void risky_method throws aException, bException{...}
 *   
 *   Riskante Methode nutzen:
 *   class_name c = new class_name();
 *   try{
 *   	c.risky_method();
 *   } catch(aException aex){
 *   } catch(bException bex){}
 *   
 *   -- Oder beides nochmal nur mit einer Oberklasse aus egal welcher Hierarchieebene,
 *   die aException, bException enthält:
 *   Grund: Exceptions sind Objekte; Objekte sind polymorph.
 *   
 *   
 *   Methode, die exception wirft:
 *   public void risky_method throws SuperException{...} 
 *   
 *   Riskante Methode nutzen:
 *   class_name c = new class_name();
  *   try{
 *   	c.risky_method();
 *   } catch(bException bex){ bException bekommt eine extra-Behandlung
 *   } catch(SuperException superex){alle anderen Exceptions Unterklasse von SuperException
 *   kommen hier rein}     
 *   // Reihenfolge catches nach Hierarchie im Vererbungsbaum ordnen, von Unter nach Super.
 *   // Exception-Objekte zusammen müssen immer groß genug sein, um jede erwartete Exception
 *   // abzufangen
 * 
 *   -- Alle Exceptions haben 'Exception' als Superklasse!
 *   
 *   Riskante Methode nutzen:
 *   class_name c = new class_name();
  *   try{
 *   	c.risky_method();
 *   } catch(Exception ex){}
 *   
 *   --> Nachteil: Man erfährt nicht, was schiefgelaufen
 * 
 * 
 * Exceptions ausweichen:
 * - Deklarieren, dass man Exception auslöst (auch wenn das nicht so ist)
 * - Sobald risky_method exception auslöst, fällt risky_method vom Stack herunter +
 *   Exception an Methode, die oben auf Stack weitergegeben; diese weicht aber auch aus,
 *   sodass sie vom stack fällt usw.
 * - Die Methode, die selber risky_method aufruft, erklärt sich selber zu einer riskanten 
 *   Methode allein, um der exception von risky_method auszuweichen: !!!
 *   
 *   public void foo() throws SchlimmeException{c.risky_method();}
 *   
 *   --> Wenn auch main-Method der exception ausweicht, schaltet sich JVM ab. 
 *       Spätestens sie sollte sich mit exception befassen.
 * 
 * - Möglich: try-finally ohne catch, aber Methode muss um 'throws Exception' erweitert werden
 * 
 * - Eigene Exceptions müssen selber geschrieben werden:
 * 
 * 	class bException extends Exception{}
 * 
 * 
 * -------------------------------------------------------------------------
 *
 * JavaSound:
 * - 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */
public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
