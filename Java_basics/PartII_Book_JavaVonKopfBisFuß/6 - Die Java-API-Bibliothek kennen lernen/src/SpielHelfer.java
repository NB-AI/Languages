

// Platziere DotComs auf Raster; Werte Nutzereingaben aus

import java.io.*;
import java.util.*;

public class SpielHelfer {
	
	private static final String alphabet = "abcdefg";
	private int rasterLänge =7;
	private int rasterGröße=49;
	private int[] raster = new int[rasterGröße];
	private int dotComAnzahl=0;
	
	public String getBenutzereingabe(String prompt) {
		String eingabeZeile=null;
		System.out.print(prompt+ " ");
		try {
			BufferedReader is = new BufferedReader(new InputStreamReader(System.in));
			eingabeZeile=is.readLine();
			if (eingabeZeile.length()==0) return null; // !!! ??? Bei if kann man einfach Klammern weglassen
		} catch (IOException e) {System.out.println("IOException: "+e);}
		return eingabeZeile.toLowerCase(); // !!! like .lower() from python!
	}
	
	public ArrayList<String> platziereDotCom(int dotComGröße){
		
		ArrayList<String> alphaZellen = new ArrayList<String>();
		String temp = null;
		int[] koordinaten = new int[dotComGröße];
		int versuche=0;
		boolean erfolg=false;
		int ort=0;
		
		dotComAnzahl++;
		int inkrement=1;
		if((dotComAnzahl%2)==1) {inkrement=rasterLänge;} // ungerades dotcom, dann vertikal setzen
		
		while (!erfolg & versuche++ < 200) {
			ort = (int) (Math.random()*rasterGröße); // zufälligen Ort erstellen
			System.out.print(" Versuche "+ort);
			int x=0;
			erfolg=true;
			while (erfolg && x<dotComGröße) { // nach angrenzenden freien Orten suchen
				if (raster[ort]==0) { // wenn unbenutzt
					koordinaten[x++]=ort;
					ort += inkrement;
					if(ort>=rasterGröße) {erfolg=false;} // Außerhalb Endgrenze
					if(x>0&(ort%rasterLänge==0)) {erfolg=false;} // außerhalb rechter Grenzen
					
				}
				else {
					System.out.print(" verwendet "+ort);
					erfolg=false;
				}
			}
		}
		
		
	
	
		// Ort in alphabetische Koordinaten umwandeln:
		int x =0;
		int zeile=0;
		int spalte=0;
		System.out.println("\n");
		while(x<dotComGröße) {
			raster[koordinaten[x]] = 1; // !!! wie in python (mask): überall, wo im array ein bestimmter
			// Wert, diesen ersetzen
			
			zeile = (int) (koordinaten[x]/rasterLänge);
			spalte = koordinaten[x]%rasterLänge;
			
			temp = String.valueOf(alphabet.charAt(spalte)); // !!! in alphabetisches Zeichen umwandeln
			
			alphaZellen.add(temp.concat(Integer.toString(zeile)));
			x++;
			System.out.print(" Koordinaten " + x+ " = "+alphaZellen.get(x-1));
		}
		System.out.println("\n");
		return alphaZellen;
	}
}
