/*
 * Objektorientiert: Jede Klasse kann eine Sache gut
 * 

 * 
 * Objekte serialisieren:
 * - Verhalten Objekte in Klasse, Zustand Objekte in Objekte --> Speichern des Zustands:
 *   a) Speichern in Textdatei/Byte-Datei
 *      Jede Instanzvariable in Datei schreiben (nicht empfohlen)
 *      Gut, wenn Nicht-Java-Programm die Datei lesen muss, e.g. Tab-Trennzeichen gut von
 *      Datenbank/Tabellenkalkulation verwendbar
 *   b) Serialisierung
 *      Objekt flachdrücken und bei Bedarf wieder aufblasen (dieses Kapitel)
 *      Empfohlen, wenn Daten nur vom erzeugenden Java-Programm verwendet
 * - e.g. Speichern von Spielfiguren/Objekten aus Fantasy-Game in eine Datei
 *   --> Bei Textdatei die Gefahr, dass in falscher Reihenfolge einglesen, e.g. Waffen und Spezies
 *       Infos vertauscht
 *   --> Serialisiert für Programm leichter einzulesen
 *       Code:
 *       
 *       try{
 *       FileOutputStream fileStream = new FileOutputStream("MeinSpiel.ser");
 *       // FileOutputStream weiß, wie man sich mit .ser-Datei verbindet,erzeugt.
 *       // Ist Anschlussstrom. Besitzt Methoden zum Byte schreiben (low-level)
 *       
 *       ObjectOutputStream os = new ObjectOutputStream(fileStream);
 *       // um Objekte mit Datei zu verbinden.
 *       // Verkettung eines Stroms mit einem anderen. Verkettungsströme (chain stream) 
 *       // stellen keine
 *       // Verbindung zu einer Quelle/Zielort (macht Anschlussstrom/connection stream) und so 
 *       // mit Anschlussstrom verkettet werden müssen.
 *       // chain stream (high-level) schreibt Objekte (hat Methoden dafür)
 *       
 *       os.writeObject(figur1);
 *       os.writeObject(figur2); // Serialisieren und reinstecken in Datei von Objekten
 *       
 *       os.close(); // Wenn der oberste Strom geschlossen, auch die unteren (FileOutputStream,
 *       			 // Datei)
 *       }catch(Exception ex){}
 * 
 * 		// 1. Object 
 * 		// 2. Verkettungstrom (flachdrücken Objekt) 
 * 		// 3. Objekt in Bytes (Anschlussstrom)
 * 		// 4. Datei/Zielort
 * 		// Code genau anders herum
 * 
 * 
 * Serialisierung erklärt:
 * - Identisches Objekt auf Heap soll durch JVM zurückgerufen werden können (an anderer Stelle!)x
 * - Speicherung von Instanzvariablen und weiteren Infos (e.g. Typ)
 * - Instanzvariablen, die Objekte enthalten: diese Objekte dann auch serialisiert. Serialiserung
 *   setzt sich fort, bis elementare Variablen serialisiert. Objekte, die zweimal vorkommen, 
 *   werden als eines gespeichert (der Fall, wenn zwei Objekte auf gleiches Objekt zeigen mit
 *   Instanzvariablen)
 *   
 * Umsetzung:
 * - !!! 
 *   import java.io.*;
 *   class SUPERKLASSE implements Serializable{} 
 *   // "Maker-""Taginterface", das keine Methoden enthält!
 *   // JVM weiß dann, dass okay, zu serializen.
 * - Unterklassen automatisch auch serializable
 * 
 * - Nicht serializable Objekte: 
 *   --> nicht mit Serializable markiert, e.g. Vermeidung Speicherung Kennwort;
 *       wenn vergessen, dann kann man einfach Unterklasse, die serializable, machen
 *   --> abhängig von laufzeitspezifischen Infos, die nicht speicherbar (e.g. Netzwerkverbindung,
 *       Thread, Dateiobjekt); in Laufzeit gesammelte Erfahrungen; abhängig von spezifischer
 *       Plattform mit spezifischer JVM --> Dinge nicht wiederbelebar, wenn Programm geschlossen
 * 
 * - Überspringen Instanzvariablen, wenn diese auf nicht serializable Objekte zeigen: !!!
 *   transient String meineInstanzvariable;
 *   --> man bekommt bei Wiederbelebung null für Objektreferenzen, default-value für 
 *       elementare Typen zurück
 *   
 *   
 *   
 * Deserialisierung/Wiederherstellung Objekts:
 * - !!!
 *   try{
 *   FileInputStream fileStream = new FileInputStream("MeinSpiel.ser");
 *   // INPUT-stream erzeugen (Verbinden mit Datei, lesen in Bytes)
 *   // file automatsich erzeugt, wenn nicht da
 *   
 *   ObjectInputStream os = new ObjectInputStream(fileStream);
 *   // INPUT-stream  zum lesen von Objekten
 *   // Klasse gefunden und geladen, Instanzvariablen wieder zugewiesen (durch gespeicherte Infos);
 *   // Exception, wenn JVM Klasse nicht finden/laden kann
 *   
 *   Object eins = os.readObject();
 *   Object zwei = os.readObject();
 *   Object drei = os.readObject();
 *   // Objekte in gleicher Reihenfolge gelesen, wie geschrieben.
 *   // Exception, wenn mehr lesen als geschriebene Objekte
 *   
 *   Spielfigur elb = (Spielfigur) eins; // originale Klasse zuweisen
 *   Spielfigur troll = (Spielfigur) zwei;
 *   Spielfigur zauberer = (Spielfigur) drei;
 *   
 *   os.close();
 *   }
 *
 * - Konstruktor nicht ausgeführt, da er sonst "new"-Zustand wiederherstellen würde
 * - Wenn weiter oben im Vererbungsbaum nicht serialisierbare Klasse, wird deren und alle 
 *   Konstruktoren der Superklassen ausgeführt, um Zustand zu reinitialisieren
 *   
 * Serialisierung:
 * - Objekte über Netzwerke verschicken, man kann die Objekte mit Url stemplen, um über 
 *   Klassenort Auskunft zu geben, e.g. bei Fernaufruf von Methoden via Java Remote Method
 *   Invocation (RMI), wobei serialisiertes Objekt als Methodenargument versendet. Wenn 
 *   empfangende JVM Klasse nicht hat, via JVM holen (Kapitel 18)
 */
public class Theorie {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
