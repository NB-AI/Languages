import javax.swing.*;
import java.awt.event.*; // Actionevent und -listener Teil davon!
import java.awt.*; // Für Implentierung des Kreises mit Farbverlauf

// Implentieren eines Knopfes, der mit Anklicken die Farbe des Widgets (einen Kreis von MeinZeichenPanel ändert) und
// seinen Text

public class EinfacheGui1B implements ActionListener { // ActionListener genutzt bei User-Aktivität
	
	JButton button; 
	JFrame frame ;
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EinfacheGui1B gui = new EinfacheGui1B();
		gui.los();
		
		
		
	}
	
	public void los() {
		frame = new JFrame(); 
		button = new JButton("Farbe wechseln");
		// JButton button = new JButton("Klick mich"); // wäre fatal, da bereits oben bei Instanzvariablen button als Objekt
		// JButton festgelegt
		
		
		
		
		button.addActionListener(this); // Listener zu Eventquelle/button: 'nimm mich in Listener-Liste auf!'
		// this als Objekt einer Klasse mit 'implements ActionListener'
		// addActionListener gilt als 1 Listener, egal wie oft dieser benutzt wird
		
		
		
		frame.getContentPane().add(BorderLayout.SOUTH, button);
		
		MeinZeichenPanel zeichenPanel = new MeinZeichenPanel();
		frame.getContentPane().add(BorderLayout.CENTER, zeichenPanel);
		
		
		frame.setSize(300,300);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	public void actionPerformed(ActionEvent event) // Methode von ActionListener interface
		{button.setText("Ich wurde geklickt"); 
		 frame.repaint(); // paintComponent auf jedem Widget im Frame aufgerufen!
		 
		
		}

}
