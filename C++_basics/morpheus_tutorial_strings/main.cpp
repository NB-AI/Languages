# include <stdio.h>
# include <iostream>
# include <string> // Keine Array-Nutzung für strings mehr nötig // string als namespace
# include <sstream> // Um string in Zahl zu konvertieren
using namespace std;

int main()
{
string s = "Hello String!";
cout << s;

cout << (s == "Hello String!");

s += "Hello back!";
s.insert(13, "Einschub"); // insert(Stelle, einzufügender_Text)
cout << s << s.length(); // "." als Zugriff auf s durch eine Funktion, die auf s basiert; length(): Number elements in string

s = "neuer String";
s.erase(0, 4); // string(Stelle, Anzahl_zu_löschender_Zeichen)

int position = s.find("Hello");

// Über string iterieren:
string::iterator i;
for(i=s.begin(); i<s.end();i++)
{
cout << *i;

}


// Convert string into int by using iostream
string abc = "42";
istringstream stream(abc); // istringstream: i - input nämlich ein string und bekommt dann einen stream
int a;
stream >> a; // in stream, der von abc abhängig, schreibe ich Zahl a --> wir erhalten 42 als Zahl!
cout << a;

// Alternative: erst mal was mit stream irgendwas und packen was rein (hier Zahl a):
string abc;
ostingstream stream;  // ostringstream braucht als input eine Zahl
int a = 34;
stream << a; // a in stream reinpacken
abc  = stream.str();// Was aus stream rauslesen
cout << a;

return 0;

}
