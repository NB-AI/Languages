# include <stdio.h>
# include <iostream>
using namespace std;

// Überladen für Addition von Listen/Matrizen/Graphen

class Vektor {
public:
double x,y,z;
Vektor(double a, double b, double c):x(a),y(b), z(c){} // Konstruktur: Initialisiert die drei Variablen x,y,z // a ist erster Vektor
                                                       // Vektor(...):Man_weißt_hier_Objekte_zu

// Vektoraddition:
Vektor operator + (Vektor  b){ // '+);' überladen; auch -*/=<> += << >> >>= <<= !=  ++ -- % &(bitwise and) |(bitwise or) && || ^ ->(1)(NICHT MACHEN) delete(überladbar)
return Vektor(x + b.x, y + b.y, z + b.z);} // (2) (3)
// Oder: (4)
Vektor operator + (Vektor * b){ // Call by reference
return Vektor(x + b->x, y + b->y, z + b->z);}

void printMe(){
cout << x << ", " << y << ", " << z << ">"; }

};

int main(){
Vektor nukular(5,5,5);
Vektor number0f911(9,1,1);

// Addieren von zwei Vektoren:
Vektor dieBartdie = nukular.operator+(number0f911); // (2); number0f911 als Prarameter
// Oder:
Vektor dieBartdie = nukular + number0f911; // (3)
// Oder: (1)
Vektor * abc = &nukular;
abc->printMe();
// Oder: (4)
Vektor dieBartdie = nukular + &number0f911;



nukular.printMe();
return 0;}
