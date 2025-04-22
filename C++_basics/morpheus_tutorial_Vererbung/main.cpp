#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

class Tier{
public:
    void wieMachtDasTier(){
    std::cout << "hello" << std::endl;
    }

};


class Hund: public Tier{ // ': public Tier' --> Hund als Mitglied der Klasse Tier
private:
    string name; //private: name wird geheim gehalten, man darf den Namen nur im Konstruktur setzen
public:
    Hund(string newname):name(newname){}
    string getName(){return this->name;}


};

class Dackel: public Hund{};


int main(){
    Hund ace("Ace"); // NICHT Hund ace="Ace", da dieses als char array interpretiert
    ace.wieMachtDasTier();
    ace.getName();

    // Überklasse auch aufrufbar:
    Tier aced;
    aced.wieMachtDasTier();

    return 0;}
