#include <stdio.h> // include weitere Dateien; <> Systemdatei; "MeineFile.h"


int main()
{
float z; // == 0
int a = 42;
char b = 78; // charakters als Zahlen, die nach AISC bezeichnet werden
// string über arrays basteln
printf(" Hello World %c\n",b); // %d für integer a, f für float, c für char (wandelt charakter-zahl in seine eigentliche Bedeutung um)--> dadurch wird Zahl hier hinten gedruckt

int d = a++ ;// zuerst wird d Wert von a erhalten und dann wird a 1 höher
int d = ++a; // zuerst wird a um 1 erhöht, dann wird dieser Wert d zugeschrieben
a += 4 ;// a erhöht um 4

int d = a & b; // Zugriff auf einzelne Bit; ein LOGISCHES &: jeder einzelne Bit von a gerundet mit jedem einzelnen Wert von b - e. g. a = 010, b = 011 --> 010; selbes mit | or, ^ xor, ~ nor

int d = (int)b; // caste b in ein integer; anders rum gehts ohne (int)


int jahr;
int monat;
scanf("%d.%d.%d", &a, &monat, &jahr) ;//einlesen von etwas, einspeichern in die Variable a


}
