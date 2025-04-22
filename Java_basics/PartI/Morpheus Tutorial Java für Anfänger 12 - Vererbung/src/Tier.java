
public class Tier implements Lebewesen{ // Tier muss jede Methode haben, die interface Lebewesen auch hat
	// und diese mit Inhalten füllen!
	int beine;
	String name;
	int augen;
	
	public String macheDichBermerkbar() {return "hey";}
	
	@Override
	public void atme(){System.out.println("schnauf");}
	
}
