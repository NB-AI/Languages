#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

class Tier{ // base/parent class
public:
    virtual void wieMachtDasTier(){ // (1) Virtual stellt dynamische Bindung her
    std::cout << "hello" << std::endl;
    }
protected: // Inhalte von protected nur in public/protected/private aufrufbar (innerhalb Klasse Tier)
           // Darf von Klassen, die von dieser Klasse Tier erben, aufgerufen werden!
    void foo(){std::cout << "foo" << std::endl;}

private: // Kann nur in Klasse Tier aufgerufen werden!
    void baz(){std::cout << "baz" << std::endl;}
};


class Hund: public Tier{ // ': public Tier' --> public-Methoden aus Tier werden zu public-Methoden in Hund! Selbes für protected
private:
    string name;
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}

    void test(){foo();} // foo() von Überklasse aufgerufen

    void wieMachtDasTier(){std::cout << "wuff" << std::endl;} // Überschreiben einer Funktion aus der parent-Klasse
};

class Kamel: protected Tier{ // ': protected Tier' --> public-Methoden aus Tier werden zu protected-Methoden in Hund! protected werden zu protected
                             // --> Keine public-Methoden mehr, die man erben könnte!
private:
    string name;
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}

    void test(){foo();} // foo() von Überklasse aufgerufen

};

class ladybird: private Tier{ // ': private Tier' --> public/private/protected von Überklasse werden zu protected!
private:
    string name;
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}

    void test(){foo();} // foo() von Überklasse aufgerufen

};

class black_ladybird: public ladybird{} // Von class Tier zu class ladybird wird alles private --> class black_ladybird kann diese noch nutzen, außerhalb der Klasse sind
                                        // die ehemals public methods nicht mehr aufrufbar!


int main(){
    Hund ace("Ace");
    ace.wieMachtDasTier();

    ace.test() // Über test() einfach foo() aus Überklasse aufrufen

    // black_ladybird birdy("Birdy") // Funktioniert gar nicht, da Konstruktoren (die auch Funktionen) nicht weitervererbt werden
    // Konstruktoren/Destruktionen müssen immer wieder neu geschrieben werden!
    // Überladene Operatoren/befreundete Funktionen nicht übertragen!

    // Dynamische Bindung: (1)
    Tier* abc = &ace; // Speicher Hund ace in einer Tiervariable abc, bisher ist abc noch kein richtiger Hund
                      // Konvertiere Hund in ein Tier, damit verschieden Tierarten-Rufe in einem Array gespeichert werden können: Tier abc = ace
                      // Tier* abc = &ace --> Caste etwas in einen anderen Pointer
    // Hund h = abc;
    // Pointer gebraucht, um Speicheradresse von class Hund wiederzufinden
    abc.wieMachtDasTier() // = "hello" --> Gewollt: "wuff" | "Tier abc = ace;" genutzt
    abc->wieMachtDasTier() // = "wuff" wie gewollt

    return 0;}
