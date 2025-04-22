
public class UebungSpielenSieJVM {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		UebungSpielenSieJVM  a = new UebungSpielenSieJVM();
		a.los();

	}
	
	void los() {
		int y=7;
		for (int x=1;x<8;x++) {
			y++;
			System.out.println(y++ + " print y Erhöhung"); // !!! Eine Variable kann auch in der Print-
			// Funtion dauerhaft erhöht werden!!!
			System.out.println(y + " tatsächliches y");
		}
	}

}
