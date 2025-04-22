# include <stdio.h>

float add(float* a, float* b) // pointer auf integer (64 Bit) statt Variablen --> Sparen von Speicherplatz durch pointer-Nutzung (64 Bit)
{return *a + *b;} // Inhalte der Zeiger addieren


float loop_through_array(float* zeig, int size_array)
{
int i = 0;
float ret = 0;
for(int i = 0; i < size_array+5; i++) // +5: Man kann theoretisch auf Speicherinhalt außerhalb Arrays über Array Zugriff nehmen, PROBLEMATISCH!
{
ret += a[i]

}

}



int main()
{
int *zeiger = &result ;// Im Speicher liegende RAM-Adresse erhalten; zeiger zeigt auf Speicheradresse/result
printf("Hello World, %p\n", zeiger); // Ausgabe als Hexadezimal: an dieser Stelle liegt result in Speicher drin. pointer dynamisch: Hexadezimal-Speicherstelle ändert sich mit jedem
                                     // Ausführen des Codes.
                                     // zeiger ist Speicheradresse: Wo genau liegt das Ganze.
                                     // %p für pointer
                                     // "Wo?"


printf("Hello World, %d\n", *zeiger); // Wert anzeigen, Inhalt des Speichers (was steht drin)
                                      // %d, %c, ... möglich --> Als was dieses Ergebnis hier interpretiert.
                                      // "Was?"


// Arrays:
float myArray[10]; // Arrays haben statisches, feste Größe und können daher im Nachhinein nicht manipuliert werden.
                   // Im Speicher liegt erstes Element hinter zweitem usw.
                   // Standardmäßig bei allen Inhalte bei Initialisierung nichts gemacht --> Werte vom alten Speicherplatz genutzt, wenn "float *zeiger = myArray + 3" genutzt!
                   // Deshalb:
int i = 0 // oder: int i
for(i=0; i<10; i++)
{myArray[i] = 0;}



myArray[0] = 1337.0;
myArray[3] = 42.0; // statt 42 42.0 benutzen, da mit float gearbeitet im Array.
float *zeiger = myArray; // Zeiger direkt auf erstes Element von myArray (myArray[0])
print("Hello Pointer. %f\n", *zeiger) // gibt Element von myArray[0] wider
                   // Im Speicher liegt erstes Element hinter zweitem usw.

float *zeiger = myArray + 3; // BEDEUTUNG: Zeiger auf myArray[0+3]
                             // VORSICHT: kein int hier vor *zeiger nutzen, sondern float, weil array-Elemente == float

printf("Length array in bytes. %lu\n", sizeof(myArray)); // %lu as long unsigned
                                                // sizeof(...) --> byte-Größe von ...
printf("Length float. %lu\n", sizeof(float)); // 1 float 4 bytes groß
printf("Length array in element-number. %lu\n", sizeof(myArray)/sizeof(float)); // %lu as long unsigned


printf("Hello loop. %f\n", loop_through_array(myArray,10));


// Make strings:
char str[] = "gg easy"; // ist ein char array; Größe automatisch bestimmt
printf("Hello String. %s\n", str); // Zur sting-Anzeige %s und pointer auf erstes Element übergeben
printf("Hello String. %s\n", (str+3)); // Starte bei Element 3 in string-Array
// Man kann arrays auch umgehen: Project morpheus_tutorial_strings
}




// Pointer mit Referenzen und Funktionen/Klassen:
// Grobe Architektur:
class Vektor{
public:
&Vektor() operator + (Vektor b){return &Vektor}
}

Vektor a(2,2);
Vektor b(7,7)

Vektor *meine_variable = a + b;
