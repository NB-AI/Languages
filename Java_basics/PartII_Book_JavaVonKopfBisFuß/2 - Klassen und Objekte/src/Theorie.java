/*
 * Alles in die main-Methode zu stecken, ist nicht sehr objektorientiert.

Gegenteil von Objektorientierung: Prozeduren. e.g. Schreiben Programm mit soundAbspielen(figur_nr)
{// figur_nr verwenden, um entsprechende Sound-Datei zu finden} -> wenn eine neue Figur (Dreieck,...) 
mit Sonderbedingungen hinzukommt, muss alter Code z.B. mit if geändert werden
vs.
Objektorientiert: e.g. Schreiben Programm mit class figur1{soundAbspielen}, class figur2{soundAbspielen}, ... 
-> wenn eine neue Figur (Dreieck,...) mit Sonderbedingungen hinzukommt, so kann alter Code belassen werden und neue Klasse 
wird hinzugefügt. Prinzip der Vererbung funktioniert. Klasse wird verwendet, um Objekt zu kreeieren, und ist selber keines: 
erklärt, wie ein Objket bestimmten Typs gemacht werden soll. Die erstellte Instanz/Beispiel-Individuum aus der Klasse ist 
ein Objekt
- Instanzvariablen: Variablen, e.g. Farbe, die Objekt über sich selber weiß (Zustand); Methoden können diese 
abrufen/verändern
- Um mit Objekt zu arbeiten, braucht es eine Objektklasse und noch eine Klasse, e.g. "class ...Testlauf", die eine 
Instanz der Objektklasse erstellt 
- Instanz/Objekt/Keks, Klasse/Rezept
- Klassen/Objekte haben Verhalten

Garbage Collection Heap: Jedes erzeugte Objekt wird in einem Heap gespeichert; Java gibt durch Anzahl Instanzvariablen auf 
Heap so viel Speicherplatz frei, wie vom Objekt benötigt. Wenn JVM erkennt, dass Objekt nie wieder verwendet, wird es zur 
Garbage Collection freigegeben. Dieser ausgeführt, wenn Speichermangel, dadurch unnötige Objekte rausgeschmissen. Später mehr.

Public static Methode verhält sich wie globale Methode. public/static/final -> Globale Konstante

Java-Programm = Mind. eine Klasse mit einer main-Methode. Die verschiedenen Klassen/Dateien in ein Java-Archiv (.jar; pkzip) 
steckbar, die unter anderem eine Textdatei/Mainifest enthält, die klarstellt, in welcher Klasse die main-Methode; = Objekte, 
die mit anderen Objekten kommunizieren
 * 
 * 
 * 
 * 
 */
public class Theorie {

}
