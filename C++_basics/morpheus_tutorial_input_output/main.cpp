#include <stdio.h>
# include <iostream>
using namespace std; // Nun können wir cin statt std::cin eingeben

int main()
{
// User gibt etwas ein:
int i;
std::cin >> i;// std: Zugriff auf namespace std/standard
              // cin: input
              // >>: wir schreiben in Variable i rein
              // cin >>: User schreibt in Variable i rein
printf("your input + 10: %d\n", i+10);

// Wir wollen etwas raus:
std::cout << "Du hast " << i << "eingeben.\n";// Man bekommt etwas von std::cin (deshalb << hier)
                                              // Oder:
printf("%d\n",i);
    return 0;
}

