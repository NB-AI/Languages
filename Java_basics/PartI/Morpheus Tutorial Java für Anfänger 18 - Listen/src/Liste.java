// Liste von Java schon gegeben, aber wir lernen es selber
public class Liste {
	
	ListElement start;
	
	public List() // void added by Java Editor
	{
		start = new ListElement("Kopf");
			
	}
	
	public void insertLast(String s) // Etwas einfügen, das dann gespeichert
	{
		ListElement newEle = new ListElement(s);
		start.next = newEle;
		
	}
	
	public String get(int n)
	{
		if(findIndex(n)==null) {return "";}
		return findIndex(n).s; // zurückgeben n-ten string
	}
	
	public void delete(int n)
	{
		if(n<1) {return;} // Unlöschbares n, da dieses "Kopf"
		
		// find n-th element of list:
		ListElement nth = findIndex(n);
		if(nth==null) {return;}
		
		// Vorgängerelement gebraucht:
		ListElement pre = findIndex(n-1);
		pre.next = nth.next; // nth element gets deleted
		
	}

	private ListElement findIndex(int n) // Finde Elemente an gewissen Stellen
	{
		if(n<0) {return null;}
		
		ListElement iterator = start;
		for(int i=0; i<n; i++) {
			if(iterator.hasNext()){iterator = iterator.next;} 
			else{return null;} 
			}
		// if erfüllt, wenn nächstes Element, das nicht null, existiert
		
		return iterator;  // Gibt n zurück
	}
}
