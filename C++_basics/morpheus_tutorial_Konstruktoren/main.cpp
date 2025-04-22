## include <stdio.h>
# include <math.h>
# include <iostream>
using namespace std;

// Konstruktoren: Man muss nicht jeden einzelnen Attributor, wie etwa "radius", extra definieren und beschreiben, wenn man eine Klasse aufruft!


class Kreis
{
public:
float radius;
// Oder:
Kreis k; // recursive design, mit:
Kries(float r, Kreis k_neu):radius(r), k(k_neu) {}


Kreis()// Kreis überladen, um ()-Konstruktor zu verwenden
{radius = 42;} // Standardwert für radius, wenn sonst kein Wert angegeben wird


Kreis(float); // Konstruktor; was zu returnen ist, gleicher Name wie Klasse von Nöten! (1)
// Oder:
Kreis(float r)// (2)
{radius = r;}
// Oder:
Kreis(float r):radius(r){}// (3); Den Wert auf radius r setzen und danach noch machen, was in den {} steht
                          // Kreis(float r):radius(r), zweiterWert(z){}


float flaeche()
{return M_PI * radius * radius;} // Man kann hier nicht so einfach radius verwenden, da es nicht vorbestimmt sein kann


};

Kreis::Kreis(float r) // Klasse::Methode (1)
{radius = r;}



int main()
{
// Vorher:
// Kreis frank;
// frank.radius = 25; // Diese Zeile soll mit Konstruktor gespart werden
// Jetzt:
Kreis frank(25);
// Oder:
Kreis frank = 25; // eigentlich float benötigt, aber okay
// Oder:
Kreis frank{25};
// Oder:
Kreis frank = {25} // hier können mehrere Parameter mit ',' eingefügt werden!


Kreis hanspeter; // Nutzen eines default Konstruktors, default-Konstruktor nimmt aber keine Parameter auf --> = Kreis hanspeter(): () nur bei Parametereingabe
                 // --> Dieser Konstruktur nicht definiert! --> Error
hanspeter.radius = 1334; // Verändern der Variable radius im Kreis hanspeter --> Wir erhalten neue Fläche


cout << frank.flaeche();

// Pointer auf Klassen:
Kreis * pointeraufhp = &hanspeter; // Ganze riesige Kreis-Klasse auf stack so groß wie Variable
cout << pointeraufhp->flaeche();
hanspeter.radius = 1445 // Man ändert was bei hanspeter, doch pointer bekommt dies mit und wird verändert!
cout << pointeraufhp->flaeche();

pointeraufhp-<radius = 13; // pointer verändert hanspeter, auf den gezeigt!
cout << hanspeter.flaeche();


return 0;}
