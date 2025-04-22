
public class ListElement {

	String s;
	ListElement next; // Nächstes List Element/Variable
	
	public ListElement(String s)
	{
		this.s = s;
		next = null;
	}
	
	public boolean hasNext()
	{
		if(this.next==null) {return false;}
		else {return true;}
			
	}
	
}

//Ele -> Ele -> Ele -> null