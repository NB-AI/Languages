import java.awt.*;
import javax.swing.*;

public class MeinZeichenPanel extends JPanel {
	
	public void paintComponent(Graphics g) // Objekt, das eine leere Leinwand ist, die sich mit Hilfe von Befehlen bemalen kann.
										   // g ein Unterklassen-Objekt von Graphics, nämlich von Graphics2D. Dieses Objekt auch direkt seine
										   // eigentliche Klasse durch cast zuweisen:
										   // Graphics2D g2d = (Graphics2D) g;
										   // Grapics Methoden: drawImage/drawLine/drawPolygon/drawRect/drawOval/fillRect/fillRoundRect/setColor/...()
										   // Graphics2D Methoden: fill3DRect/draw3DRect/rotate/scale/shear/transform/setRenderingHints/...()
	{
		// Rechteck malen:
		/*
		g.setColor(Color.orange);
		g.fillRect(20,50,100,100);
		*/
		
		// Bild in Frame einfügen:
		/* funktioniert irgendwie nicht
		Image image = new ImageIcon("fatCat.jpg").getImage();
		g.drawImage(image,10,1,this); // x-y-Koordinaten in Pixel : x Pixel vom linken Rand und y Pixel vom oberen Rand
		
		*/  
		
		// Kreis in Zufallsfarben auf schwarzen/farbigen Hintergrund:
		/*
		g.setColor(Color.orange); // Hintergrund komplett orange vom Panel, automatisch schwarz, wenn diese Zeile ausgelassen
		g.fillRect(0,0,this.getWidth(),this.getHeight()); // Gesamtes Panel betreffend: this.getWidth(), this.getHeight() !!!
														  // 0-0/x-y als Start-Pixel
														  // automatische Farbe: schwarz, muss nicht gesetzt werden
		
		int rot = (int) (Math.random()*255);
		int grün = (int) (Math.random()*255);
		int blau = (int) (Math.random()*255);
		
		Color randomColor = new Color(rot,grün,blau); // Farbe generieren
		g.setColor(randomColor); // Pinsel wird mit Farbe geladen
		g.fillOval(70,70,100,100); // Pinsel malt
		*/
		
		// Kreis mit Farbverlauf, Nutzen von Graphics2D:
		/*
		Graphics2D g2d = (Graphics2D) g;
		GradientPaint gradient = new GradientPaint(70,70,Color.blue,150,150,Color.orange); //(start-x,start-y,farbe1,end-x,end-y,farbe2)
		g2d.setPaint(gradient); // setPaint instead of setColor for Farbverlauf
		g2d.fillOval(70,70,100,100);
		*/
		
		// Kreis mit Farbverlauf, Nutzen von Graphics2D UND Zufallsfarben:
		// Für EinfacheGui1B2:
		Graphics2D g2d = (Graphics2D) g;
		
		int rot = (int) (Math.random()*255);
		int grün = (int) (Math.random()*255);
		int blau = (int) (Math.random()*255);
		Color c1 = new Color(rot,grün,blau);
		
		int rot2 = (int) (Math.random()*255);
		int grün2 = (int) (Math.random()*255);
		int blau2 = (int) (Math.random()*255);
		Color c2 = new Color(rot2,grün2,blau);
		
		GradientPaint gradient = new GradientPaint(70,70,c1,150,150,c2); //(start-x,start-y,farbe1,end-x,end-y,farbe2)
		g2d.setPaint(gradient); // setPaint instead of setColor for Farbverlauf
		g2d.fillOval(70,70,100,100);
		
		
	}

}

