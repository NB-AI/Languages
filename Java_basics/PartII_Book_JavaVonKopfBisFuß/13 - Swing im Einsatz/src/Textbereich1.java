// Implementierung JTextArea, in das User Text eintippen kann und das Text aufnimmt, wenn Knopf
// von User gedrückt. Scrollbar:
// !!!

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Textbereich1 implements ActionListener {

	JTextArea text;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Textbereich1 gui = new Textbereich1();
		gui.los();
	}

	public void los() {
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = new JPanel();
		JButton button = new JButton("einfach anklicken");
		button.addActionListener(this);
		
		text = new JTextArea(10,20); // Wunschhöhe: 10 Spalten, Wunschbreite: 20 Spalten
		text.setLineWrap(true); // Einschalten Zeilenumbruch!
		
		JScrollPane scroller = new JScrollPane(text); // ScrollPane erstellen, damit scrollbares
		// Textfenster. 'text' ist das Textbereich, auf das sich die Aussage bezieht.
		scroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		// In welche Richtungen wir scrollen können sollen
		
		panel.add(scroller); // Hinzufügen der ScrollPane und nicht des Textbereichs direkt!
		
		text.setText("erster reingefügter text\n");
		text.append("eben zugefügter text\n");
		
		text.selectAll(); // Text auswählen, sodass User diesen einfach mit einer Taste entfernen
		// kann
		
		text.requestFocus(); // Cursor in Textbereich gesetzt, damit User gleich tippen kann
		
		frame.getContentPane().add(BorderLayout.CENTER,panel);
		frame.getContentPane().add(BorderLayout.SOUTH,button);
		
		frame.setSize(350,300);
		frame.setVisible(true);
	}
	
	public void actionPerformed(ActionEvent ev) {
		text.append("Button angeklickt  \n"); // Jedes mal wenn Button angeklickt, wird text
		// erweitert.
	}
}
