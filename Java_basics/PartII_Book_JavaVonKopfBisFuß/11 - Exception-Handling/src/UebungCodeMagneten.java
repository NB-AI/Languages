

public class UebungCodeMagneten {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String test = args[0];
		System.out.print("au");
		
		try {tuRiskantes(test);System.out.print("nn");}
		catch(MeineEx e) {System.out.print("loes");}
		finally {System.out.print("e");System.out.println("n");}
	}
	
	static void tuRiskantes(String t) throws MeineEx{
		System.out.print("s");
		if ("ja".equals(t)) {throw new MeineEx();}
		System.out.print("spa");
	}

}
class MeineEx extends Exception{}
