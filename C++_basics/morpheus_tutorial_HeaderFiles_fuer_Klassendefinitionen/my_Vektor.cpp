// .cpp as c++


// Hier müssen wir den Code für Konstruktor, Operator und printMe niederschreiben, der in my_Vektor.h fehlt

#include "my_Vektor.h" // bei <> würde im Installationspfad gesucht werden; bei "" wird da gesucht, wo wir grad sind
#include <iostream> // Muss hinzugefügt werden, ansonsten findet compiler std::cout nicht!

Vektor::Vektor(double a, double b, double c){x=a;y=b;z=c;} // Konstruktur
                                                                                 // return-Wert Vektor::... --> ... gehört zu Klasse Vektor

Vektor Vektor::operator + (Vektor &b){return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);} // Operator

void Vektor::printMe(){std::cout << this->x << ", " << this->y << ", " << this->z << ">"; }
