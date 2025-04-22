// Animierter Kreis soll sich von oben nach unten bewegen:

import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
import java.lang.Thread;

public class BewegenderKreis {

	int x = 0;
	int y = 0;
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		BewegenderKreis my_circle = new BewegenderKreis();
		my_circle.los();
		// In main wird gerne erst eigene Klasse initialisiert und dann die Methode 'los()'
		// aufgerufen, in der sich alles abspielt!
	}

	////
	class MeinZeichenPanel extends JPanel{
		public void paintComponent(Graphics g) {
			// Komplettes Panel/frame:
			//g.setColor(Color.white); // bb
			//g.fillRect(0,0,this.getWidth(),this.getHeight()); // bb
			
			// Kreis:
			g.setColor(Color.orange);
			g.fillOval(x,y,100,100);
		}
	}
	////
	
	//public void actionPerformed (ActionEvent event) {frame.repaint();}
	// Kein eventListener gebraucht, da die Animation automatisch ablaufen soll
	
	public void los() {
		JFrame frame = new JFrame();
		frame.setSize(300,300);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		MeinZeichenPanel my_panel = new MeinZeichenPanel();
		frame.getContentPane().add(my_panel);

		for (int l=0;l<frame.getWidth();l++) {
			
			try{Thread.sleep(50);}catch(Exception e) {}
			// sleep function nur mit try und Thread nutzbar, mehr in Kapitel 15
			
			x=l;y=l;
			
			frame.repaint(); // frame repainten damit alter Kreis gelöscht,
			// Buch schlägt vor (vgl. bb)
			my_panel.repaint(); // neuen Kreis mit neuer Position generieren
			
		}
	}
	
}
