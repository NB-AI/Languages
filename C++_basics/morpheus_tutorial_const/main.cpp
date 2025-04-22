# include <stdio.h>
# include <iostream>
using namespace std;

// const: Man kann Betroffenes nicht mehr überschreiben/verändern, nur noch lesen

class Vektor {
public:
static int dimension;

// 1.:
const double x; // Nach Konstruktor kann man diese Variable nicht mehr verändern, sondern nur noch lesen
                // Darf nur im Konstruktor geschrieben werden!
double y,z;

// Oder 2.:
double x,y,z; // Alle Variablen werden durch const Vektor als const definiert

Vektor(double x, double y, double z):this->x(x),this->y(y), this->z(z){} // Konstruktur

Vektor operator + (Vektor &b){ // Call by reference
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);} // 2.: Durch pointer geht const-Info verloren! this kann nicht const sein
// Lösung:
Vektor operator + (const Vektor &b){ // Vektor b wird nur gelesen und nicht überschrieben: Passt!
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}

// Constant function:
const Vektor operator + (Vektor &b){ // Return-Wert ist eine Konstante
return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}

void printMe()const{ // constant function: Funktion darf nicht schreiben (innerhalb der Funktion)
// Geht nicht: this->x = 20;, da read only
cout << this->x << ", " << this->y << ", " << this->z << ">"; }
};
int Vektor::dimension = 3 // :: ist Zuweisungsoperator!
                          // Initialsierung von static variable
int main(){
Vektor number0f911(9,1,1);

// 1.:
Vektor nukular(5,5,5);
Vektor dieBartdie = nukular + number0f911;

// Oder 2.:
const Vektor nukular(5,5,5); // Ganzer Vektor und somit auch Werte innerhalb diesen als const definiert
Vektor dieBartdie = number0f911 + nukular;


// Geht nicht: dieBartdie.x = 10;
dieBartdie.printMe();
return 0;}
