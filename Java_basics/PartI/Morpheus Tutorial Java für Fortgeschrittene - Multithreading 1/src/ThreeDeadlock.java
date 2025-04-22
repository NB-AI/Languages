
public class ThreeDeadlock extends Thread {
	String name;
	ThreeDeadlockBlubb blubb; // Damit wir nicht static in ThreeDeadlockBlubb nutzen müssen
	boolean flag;
	
	ThreeDeadlock(String s, ThreeDeadlockBlubb b, boolean c){this.name = s; blubb = b; flag=c;}
	
	public void run() {
		System.out.println("Starte Thread " + name);
		for(int i=0; i<5; i++) // Damit beide Threads nicht unendlich lange laufen
		{
			if(flag) {blubb.firstThreadZugriff();}
			else {blubb.secondThreadZugriff();}
				
		}
		System.out.println("Beende Thread " + name);
	}
	
}
