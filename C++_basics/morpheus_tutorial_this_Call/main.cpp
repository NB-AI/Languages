# include <stdio.h>
# include <iostream>
using namespace std;

// this: man verweißt auf das aktuelle Objekt

class Vektor {
public:
double x,y,z;
Vektor(double x, double y, double z):this->x(x),this->y(y), this->z(z){} // Konstruktur: Initialisiert die drei Variablen x,y,z // a ist erster Vektor
                                                                         // NICHT x(x), aber this->x(x)
                                                                         // ->, weil call of reference
// Vektoraddition:
Vektor operator + (Vektor  b){ // Call by value: Wenn etwas an b geändert, dann ist dies eine weitere Version von b (es gibt 2 b-s!)
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}
// Oder: (4)
Vektor operator + (Vektor * b){ // Call by reference: Wir sparen enorm viel Speicherplatz, weil mit jedem Aufruf von class Vektor keine ganzen Vektoren, sondern Referenzen gespeichert werden
return Vektor(this->x + b->x, this->y + b->y, this->z + b->z);}
// Oder: (5)
Vektor operator + (Vektor &b){ // Call by reference; '&b': Man hat hier nur eine Adresse, daher als würde man Objekt tatsächlich übergeben (b.x möglich)
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}

void printMe(){
cout << this->x << ", " << this->y << ", " << this->z << ">"; } // this als das Objekt, auf das die Funktion gerade aufgerufen
                                                             // Man kann this auch weglassen, aber dann unsicherer (besonders, wenn Konstruktor)

};

int main(){
Vektor nukular(5,5,5);
Vektor number0f911(9,1,1);

Vektor dieBartdie = nukular + number0f911;
// Oder: (4)
Vektor dieBartdie = nukular + &number0f911; // Nachteil: wir müssen hier unten immer '&' verwenden
// Oder: (5)
Vektor dieBartdie = nukular + number0f911;

dieBartdie.printMe(); // nukular als das Objekt, auf das Funktion aufgerufen --> Damit ist es this-Objekt
return 0;}
