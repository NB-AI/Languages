# include <stdio.h>

int add(int a, int b) // returnt eine int number
{return a + b;}

int main(){

printf("Hello World. %d\n", add(5,32)); // %d beschreibt, was hinter Komma von %d, ...
int result = add(5,42); // Speichern: Hier wird gestakt: erst der Funktionsaufruf, dann die Argumente a und b, dann Funktion ausgeführt, dann Ergebnis von Funktion, dann Rücksprung,
                        // dann in Variable result --> Doppeltes Speichern von Ergebnis! Platzverschwendung!
                        // --> Deshalb pointer nutzen

}
