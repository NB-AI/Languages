import javax.swing.*;
import java.awt.event.*; // Actionevent und -listener Teil davon!
import java.awt.*; // Für Implentierung des Kreises mit Farbverlauf

// Implementieren zwei bedienbarer Knöpfe
// Problem: Kreis repainted von button1, auch wenn nur button2 gedrückt wurde. Problemlösung
// in letzten Zeilen nochmal erklärt

public class TwoButtons{ // 'implements ActionListener' fällt weg
	
	JFrame frame ;
	JLabel label;
	JButton colorButton;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		TwoButtons gui = new TwoButtons();
		gui.los();
		
		
		
	}
	
	public void los() {
		frame = new JFrame(); 
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JButton labelButton = new JButton("Label ändern");
		labelButton.addActionListener(new LabelListener());
		// statt: button.addActionListener(this);
		// LabelListener als innere Klasse für die Interfacenutzung von 'ActionListener'
		
		colorButton = new JButton("Kreis ändern");
		colorButton.addActionListener(new ColorListener());
		
		label = new JLabel("Ich bin ein Label");
		MeinZeichenPanel kreis = new MeinZeichenPanel();
		
		// Put elements into frame:
		frame.getContentPane().add(BorderLayout.SOUTH, colorButton);
		frame.getContentPane().add(BorderLayout.CENTER, kreis);
		frame.getContentPane().add(BorderLayout.EAST, labelButton);
		frame.getContentPane().add(BorderLayout.WEST, label);
				
		frame.setSize(620,300);
		frame.setVisible(true);
		
	}
	
	
	class ColorListener implements ActionListener{ // Nutzen eines ActionListeners für nur
		// ein frame-Objekt/Inhalt, da diese Klasse sich eben nur auf eines bezieht!
		// Damit ist nun klar, dass dieser ActionListener nur für diesen einen Frame-Inhalt
		// (der bunte zentrale Kreis) genutzt wird!
		
		public void actionPerformed(ActionEvent event) 
			{colorButton.setText("benutzt"+Math.random());
			 frame.repaint();
			}
	}
	
	class LabelListener implements ActionListener{
		
		public void actionPerformed(ActionEvent event) // Methode von ActionListener interface
			{
			label.setText("Autsch"+ Math.random()); // durch Zahl hinten wird Kreis räumlich 
			// verschoben und ändert so seine Gradientenposition und somit seine Zufallsfarben.
			}
	}


}
