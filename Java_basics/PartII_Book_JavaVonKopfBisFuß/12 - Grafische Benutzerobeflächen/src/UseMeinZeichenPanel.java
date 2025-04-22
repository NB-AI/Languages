import javax.swing.*;
import java.awt.event.*; // Actionevent und -listener Teil davon!

public class UseMeinZeichenPanel implements ActionListener {
	
	//JButton button;
	MeinZeichenPanel zeichen_panel; // simply replace JButton
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		UseMeinZeichenPanel gui = new UseMeinZeichenPanel();
		gui.los();
		
		
		
	}
	
	public void los() {
		JFrame frame = new JFrame();
		zeichen_panel = new MeinZeichenPanel();
		
		//button.addActionListener(this); // MeinZeichenPanel müsste eine Methode addActionListener haben
		
		frame.getContentPane().add(zeichen_panel);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(300,300);
		frame.setVisible(true);
		
	}
	
	public void actionPerformed(ActionEvent event) // Methode von ActionListener interface
		{
		
		}

}