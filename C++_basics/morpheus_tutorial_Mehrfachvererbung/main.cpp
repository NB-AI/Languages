#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

// 'a::b' meint, dass von a b verwendet wird!!!

class Tier{ // base/parent class
public:
    virtual void wieMachtDasTier(){ std::cout << "hello" << std::endl;}

    virtual void lead(){std::cout << "follow me 1" << std::endl;} // (1)
    // Oder (2):
    virtual void lead() = 0; // Jedes Tier muss diese Funktion lead haben, aber es steht hier noch nichts drin --> Dann bei jeder Kind-Klasse diese Funktion überschreiben
                             // nur in parent Klasse = Abstrakte Klasse

};

class Blindenfuehrer_Hund{
public:
    virtual void lead(){std::cout << "follow me" << std::endl;}
};


class Hund: public Tier, public Blindenfuehrer_Hund{
private:
    string name;
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}
    void test(){wieMachtDasTier();}
    void wieMachtDasTier(){std::cout << "wuff" << std::endl;}

    void lead(){std::cout << "follow überschrieben" << std::endl; // Überschreiben einer doppelten Funktion in den parentKlassen
    Blindenfuehrer_Hund::lead();} // (2), nehme die Funktion lead() aus der Klasse Blindenfuehrer_Hund!
                                  // Funktioniert auch für (1)!
};


int main(){
    Hund ace("Ace");
    Tier* abc = &ace;
    abc->wieMachtDasTier(); // = "wuff" wie gewollt

    ace.lead(); // Wenn class Tier und class Blindenfuehrer_Hund die gleiche Methode haben, dann Fehler! (Diamantenproblem)
               // Dann doppelte Funktion in der Kindklasse überschreiben!
               // Fazit, um doppelte Funktionen zu vermeiden: 'Klassenname_Funktionsname(){}'!

               // (2) Oder eine pure virtual function: Kann nur überschrieben werden und muss jedes mal überschrieben werden

    return 0;}
