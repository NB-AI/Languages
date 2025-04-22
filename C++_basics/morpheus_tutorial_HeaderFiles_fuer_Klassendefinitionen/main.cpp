# include <stdio.h>
# include <iostream>
using namespace std;

// Klassendefinitionen, die in Header Files gespeichert werden sollen
// Viele Klassen, die nicht alle in einer einzigen Datei sein soll. Deshalb Klassen auslagern und dann includen.

#include "my_Vektor.h"


int Vektor::dimension = 3;
int main(){

Vektor number0f911(9,1,1);
Vektor nukular(5,5,5);
Vektor dieBartdie = number0f911 + nukular;
dieBartdie.printMe();

return 0;}
