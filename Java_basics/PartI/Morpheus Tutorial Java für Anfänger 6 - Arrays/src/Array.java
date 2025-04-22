
public class Array {

	public static void main(String[] args) {
		
		int[] asdf = new int[10]; // Index starts with 0! // zero-array created 
		asdf[0] = 0; // Wert zuweisen
		int[] smaller_array = new int[5];
		
		for(int index=0; index <10; index++) // muss < 10 sein, da array nur bis Index 9 geht
			{
				asdf[index] = index + 5;
				smaller_array[index] = asdf[index] * 12;
				System.out.println(asdf[index]);
				
			}
		
		for(int i=0; i<10; i++) {
			
			System.out.println(asdf[i]*smaller_array[i%5]); // i%5: Only get the values smaller 5, 5%5=0, 6%5=1
		}
		
		
		

	}

}
