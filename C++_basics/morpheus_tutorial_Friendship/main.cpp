#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

class Hund{
    friend class HundManager; // Ganze Klasse als Freund definieren. Hat Zugriff auf ALLE private-Attribute
private: // Muss wegen Zeile drüber dran stehen
    string name; //private: name wird geheim gehalten, man darf den Namen nur im Konstruktur setzen
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}

    friend void adopt(Hund &h) // Hund zur Adoption freigeben
                                // Befreundete Funktion, die darf alles und nicht zur Klasse gehört!
                                // Sie darf eine private Variable ändern!!! (here string name)
};

void adopt(Hund &h) // Wenn adopt()-Funktion zur Klasse gehören würde, dann müsste man Hund::adopt schreiben; tut sie aber nicht!
                    // Funktion kann Namen von Hund ändern
{h.name = "Goofy";}

int main(){
    Hund ace("Ace"); // NICHT Hund ace="Ace", da dieses als char array interpretiert
    adopt(ace); // Adoptiere Hund Ace
    cout << ace.getName();
    return 0;}


