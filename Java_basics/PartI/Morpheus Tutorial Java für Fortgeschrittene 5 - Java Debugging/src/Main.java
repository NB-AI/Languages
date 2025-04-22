
public class Main {
	// https://www.youtube.com/watch?v=mqO1x0papKk&list=PLNmsVeXQZj7oirQMpjPjrmNx4vcVIGIGY&index=5

	public static void main(String[] args) {
		
		int i = 0;
		int[] array = {0,1,2,3,4,5};
		Test t = null;
		
		for(int j = 0; j<array.length; j++)
		{
			System.out.println(array[j]);
			array[j] = 7;
			t = new Test();
		}
		

	}

}
