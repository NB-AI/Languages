#include <iostream>
#include <stdio.h>
#include <string>

#include <pthread.h>

void *laufenlassen(void* tid) // tid = thread ID | Funktion, die für Threading sorgt
{
    long id = (long)tid; // Caste id zurück zu int
    std::cout << "working hard at "<< id << std::endl;
    pthread_exit(NULL); // thread soll sterben
    }

int main(int argc, char const *argv[]){
    void *status;
    // Array aus threads und threads erstellen:
    pthread_t fred[10]; // pthread_t = Datentyp von den Threads, eine Threadklasse | 10 für die Anzahl der Kerne
    pthread_attr_t  attribute; // Attribut für thread
    pthread_attr_init(&attribute); // Initialsieren eines Attributes eine threads
    pthread_attr_setdetachstate(&attribute, PTHREAD_CREATE_JOINABLE);
    for (long i=0; i<10; i++){
        std::cout << "Creating thread " << i << std::endl;
        pthread_create(&fred[i], &attribute, laufenlassen, (void *)i); // Wir brauchen Adresse an i-ter Stelle
                                                          // laufenlassen: hier übergeben wir einen Pointer auf eine Funktion, Name der Funktion als pointer auf sie!
                                                          // (void *) i: Argument of function laufenlassen(), hier wurde (void *) gecastet, da sonst Fehlermeldung
                                                          // Wenn mehrere Argumente i: dann einfach Klasse erstellen und dessen Output hier rein und dann umwandeln

                                                          // threads sollen joinable werden: pthread_create(..., a, ..., ...): a beschreibt Eigenschaften für threads, NULL möglich
        pthread_join(fred[i], &status); // Warten auf thread[i], der grade erstellt wurde
        std::cout << "Thread " << i << " ist fertig" << std::endl;
    }

    for(int i; i<10;i++){
        pthread_join(fred[i], &status); // Warten auf thread[i], der grade erstellt wurde
        std::cout << "Thread " << i << " ist fertig (second time)" << std::endl;


    }

    return 0;}

// Funktioniert nicht, deshalb z. B. im Terminal eingeben:
// $ g++ main.cpp -lpthread
// $ ./a.out
// threads schreiben parallel in die Ausgabe
// Okay, wenn Bildschirmausgabe oder anderes
// Ansonsten synchronisieren, dann ein Thread nach dem anderen gemacht
