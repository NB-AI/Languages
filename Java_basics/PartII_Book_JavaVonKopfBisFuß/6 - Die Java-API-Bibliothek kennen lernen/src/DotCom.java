
import java.util.ArrayList;

public class DotCom {

	private ArrayList<String> zellorte;
	private String namef;
	
	public String prüfDich(String tippString) 
	{

		
		
		String ergebnis = "Vorbei";
		
		int found_place = zellorte.indexOf(tippString);
		if (found_place>=0) {
			zellorte.remove(found_place);
			if (zellorte.isEmpty()) {ergebnis="Versenkt!";}
			else {ergebnis="Treffer";}
		}
		
		
		System.out.println(ergebnis);
		return ergebnis;
		
		
	}	
	
	public void setZellorte(ArrayList<String> orte)
	{
		zellorte = orte;
	}
		
	public void setName(String n) {namef=n;}
		
	

}
