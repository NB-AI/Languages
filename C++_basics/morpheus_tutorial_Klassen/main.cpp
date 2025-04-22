# include <stdio.h>
# include <math.h>
# include <iostream>
using namespace std;

// string ist eine Klasse, int nicht


class Kreis
{
public:
float radius;

float flaeche()
{return M_PI * radius * radius;}

}; // ";", damit Klasse abgeschlossen



int main()
{
Kreis frank; // Kreis hat Namen "frank"
frank.radius = 25;
cout << frank.flaeche();


// Konstruktoren: Man muss nicht jeden einzelnen Attributor, wie etwa "radius", extra definieren und beschreiben, wenn man eine Klasse aufruft!



return 0;}
