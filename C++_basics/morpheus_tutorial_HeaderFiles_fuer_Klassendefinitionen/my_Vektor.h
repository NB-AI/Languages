// Eine Header-Datei: Für den importierenden Programmierer ist so alles auf einen Blick erfassbar, ohne dass er sich die zweite cpp-Datei (my_Vektor.cpp) anschauen müsste.

// Wenn diese Datei schon einmal definiert/included wurde, dann wird sie nicht nochmal kompiliert
# ifndef VEKTOR_H // ifndef: if not defined; VEKTOR_H als beliebige Variable
                  // dann:
# define VEKTOR_H


class Vektor {
public:
static int dimension;

double x,y,z;

Vektor(double a, double b, double c); // Es gibt da einen Konstruktur, doch wie genau er aussieht, muss in anderen Datei nachgelesen werden
// Normalerweise würde Konstruktor so aussehen:
//Vektor(double x, double y, double z):this->x(x),this->y(y), this->z(z){} // Konstruktur

Vektor operator + (Vektor &b); // Es gibt da einen Operator, doch wie genau er aussieht, muss in anderen Datei nachgelesen werden
// Normalerweise würde Operator so aussehen:
//Vektor operator + (Vektor &b){
//return Vektor(this->x + b.x, this->y + b.y, this->z + b.z);}

void printMe(); // Selbes hier
// Normalerweise das angehängt:
//const{cout << this->x << ", " << this->y << ", " << this->z << ">"; }
};

#endif // Wenn file bereits definiert, dann springe gleich zum Ende
