/*
 * GUI - Graphical User Interfaces:
 * - JFrame: Objekt, das Fenster auf Bildschirm repräsentiert. In dieses soll die ganze GUI eingefügt werden
 * - Widget: 'kleine Geräte'
 * 			 javax.swing bietet zahlreiche: JButton, JRadioButton,JCheckBox,JLabel,JList,JScrollPane,JSlider,JTextArea,
 * 			 JTextField,JTable
 * 			 (- Look-and-feel-Klassen um zu entscheiden, wie Design und Klick-Reaktionen, e.g. 'Metal' for 
 * 			 Java-Look, 'Aqua' for Mac)
 * - GUI Code unten
 * 
 * Event-Handling:
 * - Programm soll mit User interagieren. Dabei sollte absichtliches Klicken erkannt werden, wenn der User den Button wirklich
 *   antippen möchte
 * - Nötig:
 *   1. Button mitteilen, dass seine Events wichtig? 
 *   2. Benachrichtigung, dass Button geklickt --> Listener-Interface
 * - Eventquelle: e.g. Button, Objekt, das Benutzertaten in Events (Objekt einer Event-Klasse) umwandelt
 * - Events: java.awt.event Paket enthält Event-Klassen, e.g. MouseEvent,KeyEvent,WindowEvent,ActionEvent
 * - Diese Events nun vom Eventlistener eingelesen; 
 *   Listener-Interface zu jedem Eventtyp, e.g. WindowEvent mit WindowListener.
 *   Für jedes Interface mind. eine dazugehörige Methode schreiben. Je nach Methode, haben wir unterschiedliche Events unter 
 *   einem Thema, e.g. MouseListener mit mousePressed, mouseReleased,...
 *   
 * - Kommunikation Listener und Button/Eventquelle: !!!
 *   Listener zu button: button.addActionListener(this) --> button fügt Listener in seine Liste von Listener ein. Interesse kundgetan
 *   														this als Objekt einer Klasse mit 'implements ActionListener'
 *   button zu Listener: actionPerformed(dasEvent) --> button aktiviert Methode zum Action performen von Listener auf!
 *   												   Jeder Listener betroffen
 *   --> Codebeispiel class EinfacheGui1B
 *   
 * - Listener: Interface implementieren, bei button/Eventquelle registrieren, um Events kümmern 
 * 			   Erhält das Event!
 *   Eventquelle: Registierung Listener und Events von Benutzern entgegennehmen und Aufruf Event-Handling Methode von Listener
 *                Sendet Event!
 *   Event-Objekt: Wird mitgeliefert von Eventquelle, um Listener Daten über Event weiterzugeben;
 *   			   meistens nicht gebraucht, e.g. x-y-Koordinaten des Klicks;
 *   			   e.g. nutzbar, wenn ein Listener wie Taschenrechner viele Knöpfe hat, die alle einzeln als Listener übergeben
 *   			   werden könnten, doch man möchte nur Taschenrechner-Listener übergeben, dann Info in Event, welcher Knopf 
 *    			   gedrückt wurde
 *   
 * - Wann man selbst Eventquelle ist: Wenn man Anwendung schreibt, die Aktienmarkt beobachtet und etwas Wichtiges (Event) entdeckt,
 *   davon erstellt man dann ein Event-/AktienEvent-Objekt von einer weiteren selbst geschriebenen Klasse. Dann auch noch
 *   AktienListener-Interface selber schreiben
 *                
 * - Eventquelle/Widget einfach in Java API sun documentation nachsehen, welche Event-Methoden möglich mit JWidget_name
 * 
 * 
 * Layout, Platzierung:
 * - 2d Graphik auf Widget zeichnen: !!!
 * 	 graphics.fillOval(70,70,100,100);
 * - JPEG auf Widget setzen: !!!
 * 	 graphics.drawImage(meinBild,10,10,this);
 * - Widget, auf dem gemalt und gezeichnet werden kann, selber machen:
 *   Unterklasse von JPanel (Widget) erstellen und paintComponent() überschreiben. Diese enthält Graphik-Code.
 *   Anzeigenauffrischung im Frame durch JVM bestimmt, z.b. nach Minimierung frames, beim wiederöffnen paintComponent nochmals
 *   aufrufen (man ruft sie nicht selbst auf).
 *   Code in: class MeinZeichenPanel
 * - Graphics und Graphics2d, mehr Infos in class MeinZeichenPanel!
 * 
 * Graphik zeichnen, wenn Event erhalten:
 * - 
 * 
 * Mehrere Sachen in einem Frame:
 * - 5 Bereiche eines Frames, die je ein Ding aufnehmen. Dieses Ding kann z.b. Panel sein, das 3 weitere Dinge aufnimmt.
 *   Bereiche: NORTH,EAST,SOUTH,WEST,CENTER(default wenn bei .add() keine Angabe)
 *   Code: frame.getContentPane().add(BorderLayout.CENTER, button);
 * - Herausfinden, was Event verursacht hat bei mehreren Buttons:
 *   b = new JButton(); 
 *   actionPerformed(ActionEvent event){if(event.getSource()==b).....}
 *   --> Nutzbar, wenn verschiedene Buttons verschiedene Sachen machen, aber nicht so OO!
 *       Daher noch bessere Lösung - Separate ActionListener-Klassen:
 *       
 *      statt button.addActionListener(this);  		
		das button.addActionListener(eigens_geschriebene_Listener_class);
		class eigens_geschriebene_Listener_class implements ActionListener{
			public void actionPerformed(ActionEvent event)
				{.repaint();} // Was Knopf machen soll, wenn angedrückt
		}
 * 
 * ----------------------------------------------------------------------------------
 * 
 * Innere Klassen:
 * - Code: class außen{private int x; class innen{void los(){x=3;}}}
 * - Innere Klasse kann alle (privaten) Methoden und Variablen der äußeren Klasse benutzen, als
 *   ob sie in ihr deklariert wären. Bei Variablen auch Vice versa!
 * - Wenn innere Klasse statische Methode definiert muss deren Instanz nicht an die der äußeren
 *   Klassen-Instanz gebunden sein. Ansonsten schon.
 *   --> Codedarstellung: !!!
 *       1. Instanz der äußeren Klasse
 *          außen a1 = new außen();
 *       2. Instanz der inneren Klasse beruhend auf 1. 
 *          außen.innen i1 = a1.new innen();
 *          (Verbindung zu a1 kann nie aufgelöst werden, es sei denn Garbage Collection)
 *          
 *       Alternative: Einfach in äußere Klasse Instanz von innerer erstellen:
 *       innen i1 = new innen();
 * - Nutzen in class TwoButtons
 * - Vorteile: 
 *   --> Gleiches Interface mehrmals in ein und diesselbe Klasse zu implementieren. Dadurch 
 *       unterschiedliche Implementierungen des gleichen Interfaces. Nutzbar für e.g.
 *       - Event-Handling (oben besprochen)
 *       - für zwei unterschiedliche Klassen, die verschiedene Objekte präsentieren
 *       - äußere Klasse besteht IS-A-Test nur für eine andere Klasse aber nicht Interface und
 *         zudem noch für weitere Klasse bestehen muss --> äußere Klasse immer nur um eine
 *         Klasse erweiterbar.
 *         E.g. wenn man ein Hund ist, der sich manchmal als Button an Methoden zu übergeben.
 *         Aber Hund erweitert schon Tier. Deshalb einfach innere Klasse einsetzen, die Button
 *         erweitert.
 *       - äußere und innere Klasse von verschiedenen Vererbungsbäumen nutzen
 * - Nicht wiederverwendbar 
 * - Innere Klasse als Unterklasse
 *
 * - Java Swing enthält viele Eventquellen
 * - repaint() ruft paintComponent(Graphics g) auf, die sagt, wie was gemalt werden soll
 */
import javax.swing.*;
public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// Gui erstellen:
		// 1. Fenster erstellen:
		JFrame frame = new JFrame();
		
		// 2. create widget:
		JButton button = new JButton("klick mich");
		
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // damit Programm wirklich geschlossen wird, wenn Versuch zu schließen
		// spätere Javaversion als 5.0 braucht es wohl nicht mehr
		
		// 3. Widget in Frame einfügen:
		frame.getContentPane().add(button);
		// ab Java 5.0:
		// frame.add(button);
		
		// 4. Frame anzeigen mit Größe und Sichtbarkeit:
		frame.setSize(300,300); // setSize(pixelgröße,pixelgröße)
		frame.setVisible(true);
		

	}
	
	public void ändern() {
		button.setText("ich wurde geklickt"); // button auf neuen Text stellen
	}

}
