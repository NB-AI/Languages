
public class Hund extends Tier // Hund hat Zugriff auf alle Variablen und Methoden von Klasse Tier
{
	String rasse = "dackel";
	
	public String return_rasse() {return rasse;}
	
	public String macheDichBermerkbar() {return "wuff";} // Überschreiben Methode von Tier
	
	public void atme() {System.out.println("hechel");}
}
