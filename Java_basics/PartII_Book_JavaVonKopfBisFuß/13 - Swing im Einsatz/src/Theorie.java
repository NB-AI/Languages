/*
 * Swing lokal gezielt einsetzen:
 * - Layoutmanager hilft der leichten GUI-Erstellung, doch die Proportionen der einzelnen Widget/
 *   ... nicht so, wie man sie haben wollte. Dies kann man aber ändern
 * 
 * Komponente:
 * - = das, was User sieht und mit ihm interagiert, e.g. Buttons
 * - = Unterklassen von javax.swing.JComponent
 * - Komponente(JButton,JCheckBox,JTextField...)/Hintergrundkomponente
 *   (JFrame,JPanel(Malunterlage)) in Komponente möglich
 *   Code: my_panel.add(button);
 * 
 * Layoutmanager:
 * - zumeist mit Hintergrundkomponente verknüpft, ansonsten mit Komponente. Dieser kontrolliert
 *   Komponenten innerhalb verknüpfter Komponente, e.g. Buttongröße/-lokalisierung im Panel
 * - Unterschiedliche Layoutmanager, unterschiedliche Richtlinien zur Komponentenanordnung
 * - entscheidet anhand Wünsche (ganz/teils/gar nicht; e.g. Wunschgröße Button richtet sich nach 
 *   seiner Anzahl der Wörter) der einzelnen Komponente, wie Anordnung
 * - Typen:
 *   1) BorderLayout - Standard für Frames
 *      Teilung in 5 Bereiche (east,west,north,south,center), wovon in jedem Bereich nur eine 
 *      Komponente zulässig (wie in Kapitel 12)
 *      --> !!!
 *          import java.awt.*;
 *          ...
 *          frame.getContentPane().add(BorderLayout.EAST, button/Komponente);
 *          
 *     Wunsch nach Breite von Komponente erfüllt in: east,west (so groß wie frame, wenn nichts
 *													 in north,south)      
 *                 Höhe                            : north,south
 *     Reste für center ODER Programmierer verwendet 'pack()': Aufbauen der Bereiche ausgerichtet
 *     nach den Wünschen der Komponente im center
 *          
 *   2) FlowLayout - Standard für Panels
 *      Jede Komponente erhält ihre gewünschten Maße. Komponenten von links nach rechts in
 *      Reihenfolge der Zufügung/add(). 
 *       
 *   3) BoxLayout
 *      Jede Komponente erhält ihre gewünschten Maße. Komponenten von oben nach unten in
 *      Reihenfolge der Zufügung/add(). (Auch horizontale Stapelung möglich.)
 *      Kein automatisches Switchen zur nächsten Spalte, sondern man kann mit Taste neue Spalte
 *      für eine Komponente erzwingen.
 *      Erzwingt Zeilenumbruch, selbst wenn noch Platz.
 *      
 *   4) Manuell
 *   	Programmierer kann alles selber machen ohne Projektmanager.
 *      panel/... .setLayout(null)
 *      
 *      Nachteil: Nur auf eigener JVM klappt es mit der Platzierung, wie Progammierer sie 
 *      haben wollte, da je nach Plattform unterscheiden sich Komponenten und Look-and-Feel.
 *      Projektmanager übernimmt auch Komponentengrößenanpassung, wenn Fensergröße von User
 *      verändert.
 * 
 * Komponentengrößenwünsche vorgeben:
 * - Schriftgröße ändern/dadurch Button höher:
 *   JButton button = new JButton("text");
 *   Font bigFont = new Font("serif", Font.BOLD,28); // Dicke,große Schrift Formatierung...
 *   // ...in button einsetzen:
 *   button.setFont(bigFont);
 *   
 * Facts:
 * - awt als Vorfahre von Swing
 * 
 * 
 * -----------------------------------------------
 * 
 * Verschiedene Komponenten:
 * 1) JTextField
 *    JTextField field = new JTextField(20); // soll 20 Spalten breit werden
 *    									"Ihr Name"); // Text soll im default-Textfeld stehen
 *    
 *    System.out.println(field.getText()); 
 *    
 *    field.setText("text einfügen");
 *    				""); // Text löschen
 *    
 *    field.addActionListener(meinActionListener); // User drückt auf Enter/return, sodass
 *    											   // Aktion ausgelöst
 *    
 *    field.selectAll(); //Text auswählen
 *    
 *    field.requestFocus(); // Cursor passt sich dem Feld stetig an
 *    
 * 2) JTextArea
 *    kann mehrere Zeilen Text enthalten, Programmierer fügt Scrollbalken,Zeilenumbruch hinzu
 *    (ScrollPane setzen)
 *    
 *    Beispiel class Textbereich1
 *    
 * 3) JCheckBox
 *    Einzelne Punkte erstellen, die abgehakt werden. 
 *    
 *    JCheckBox check = new JCheckBox("erstes item");
 *    
 *    check.addItemListener(this); // Listen, ob ein Item an-/abgehakt wird
 *    
 *    public void itemStateChanged(TiemEvent ev){
 *    	String jaOderNein = "nein";
 *    	if(check.isSelected()) // prüfen, ob wirklich die CheckBox ausgewählt
 *    		{jaOderNein = "ja";}
 *    	System.out.println("Häckchen sgesetzt: " + jaOderNein);
 *    }
 *    
 *    // Haken von Anfang an (nicht) setzen:
 *    check.setSelected(true);
 *    
 * 4) JList
 *    
 *    String [] listEntries = {"alpha","beta"}; // müssen keine Strings sein
 *    JList list = new JList(listEntries); // repräsentiert Liste als Strings
 *    
 *    // JScrollPane wie in Textbereich1 hinzufügen
 *    
 *    list.setVisibleRowCount(4); // Vor scrollen 4 Zeilen sichtbar
 *    
 *    // User kann nur einen Eintrag auf einmal auswählen:
 *    list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION); 
 *    
 *    list.addListSelectionListener(this);
 *    
 *    // Heausfinden, welcher Listeneintrag gewählt:
 *    public void valueChanged(ListSelectionEvent lse){
 *    	if(!lse.getValueIsAdjusting()){ // muss sein, ansonsten Event 2x bekommen
 *    		String selection = (String) list.getSelectedValue();
 *    		System.out.println(selection);
 *    }}
 *    
 *    
 */

import javax.swing.*;
import java.awt.*;

public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Theorie gui = new Theorie();
		gui.los();
	}
	
	public void los() {
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = new JPanel();
		panel.setBackground(Color.darkGray); // Hintergrundfarbe von Zeichenfläche panel setzen
											 // !!!
		
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS)); // !!!
		// Layoutformat für panel ändern.
		// 'BoxLayout.Y_AXIS': wir wollen vertikale Stapelung
		
		JButton button = new JButton("hau drauf");
		JButton button2 = new JButton("Lukas");
		JButton button3 = new JButton("wie jetzt?");
		
		panel.add(button); // !!! etwas in Komponente einfügen
		panel.add(button2);
		panel.add(button3);
		
		frame.getContentPane().add(BorderLayout.EAST,panel);
		frame.setSize(250,200);
		frame.setVisible(true);
		
	}

}
