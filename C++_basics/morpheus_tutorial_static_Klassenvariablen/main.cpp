# include <stdio.h>
# include <iostream>
using namespace std;

// this: man verweißt auf das aktuelle Objekt

class Vektor {
public:
static int dimension; // static variable, die für alle Objekte (hier nukular, dieBartdie, number0f911) gleich!
                      // Sie ist veränderbar.
                      // Muss außerhalb der Klasse initialisiert werden!
                      // z. B. Counter: wie viele Vektoren habe ich schon gemacht?

double x,y,z; // Instanzvariablen: Können sich je nach Objekt ändern
Vektor(double x, double y, double z):this->x(x),this->y(y), this->z(z){} // Konstruktur

Vektor operator + (Vektor &b){ // Call by reference
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}

void printMe(){
cout << this->x << ", " << this->y << ", " << this->z << ">"; }
};
int Vektor::dimension = 3 // :: ist Zuweisungsoperator!
                          // Initialsierung von static variable
int main(){
Vektor nukular(5,5,5);
Vektor number0f911(9,1,1);

Vektor dieBartdie = nukular + number0f911;
nukular.dimension = 4; // static variable geändert, aber auch bei anderen Objekten (number0f911, dieBartdie)
cout << nukular.dimension;
//dieBartdie.printMe(); // nukular als das Objekt, auf das Funktion aufgerufen --> Damit ist es this-Objekt
return 0;}
