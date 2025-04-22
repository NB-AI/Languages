#include <iostream>
# include <math.h>

using namespace std;

class Kreis{
private: // Nur innerhalb der entsprechenden Klasse kann man auf Objekte in private zugreifen
         // Wenn man nichts hinschreibt, ist es so wie 'private:'
float radius; // Außerhalb der Klasse kein direkter Zugriff auf radius möglich!
              // Innerhalb Klasse radius veränderbar:

void die(){cout << "private method | you have chosen too small r!";}

public:

Kreis(){radius = 42}

Kreis(float r){setRadius(r);}


void setRadius(float r){
if(r>0) // then we want to set the radius
{radius = r;}
// else nothing happens
// Oder:
else{die();}

}

// Damit radius außerhalb Klasse für Nutzer einsehbar:
float getRadius(){return radius;}

float flaeche(){M_PI*radius*radius;}


}




int main()
{
Kreis hanspeter(12)
Kreis * pointeraufhp = &hanspeter;
pointeraufhp->setRadius(1337); // Ändert Kreiswert; checkt, ob diese Zahl > 0 (vgl. void setRadius()), wenn nicht, dann alter radius-Wert beibehalten
                               // Geht nicht, when radius public und nicht private: pointeraufhp->radius = -1. Wenn private, dann Fehlermeldung

// What value radius has:
cout << hanspeter.getRadius();



return 0;
}
