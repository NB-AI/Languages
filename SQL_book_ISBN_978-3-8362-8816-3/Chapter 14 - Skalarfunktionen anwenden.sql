-- 14.1 Funktionen für Textwerte
-- Alle Funktionen:
-- LOWER,UPPER,TRIM (spaltenname/Textliteral) -- trim entfernt Leerzeichen/Tabs vor/hinter Spaltenwerten
-- SUBSTRING (spaltenname FROM start_number FOR length_number)
-- CONCAT (spaltenname1,spaltennam2,...)/(spaltenname1 || spaltenname2 || ...)/MS SQL:(spaltenname1+spaltenname2+...)
-- concatenate einzelner Werte, Spalte behält genauso viele Einträge!

-- Funktionen können auch verschachtelt aufgerufen werden, sodass eine Spalte mehrmals bearbeitet!

-- 14.1.... Einsatz
select lower(artikelbezeichnung),artikelbezeichnung from produkt;

-- 14.1.3 Spaltenwerte von führenden und endenden Leerzeichen befreuen (TRIM)
-- wichtig bei Nutzung WHERE

-- MySQL, MariaDB: beliebiges Zeichen entfernbar, aber immer eine Zeichenart:
select trim(both 'S' from artikelbezeichnung) from produkt;
-- Alle Tabs und Leerzeichen gleichzeitig entfernbar:
select trim('	' from trim(both ' ' from artikelbezeichnung)) as artikelOhneLeerzeichen from produktleerzeichen;	
-- (Optionen: both - vorne + hinten; leading - vorne; trailing - hinten; gilt für alle 4 Datenbanken)
-- ... mit 
-- PostgreSQL:
-- select trim(both 'Eingabe von Tab + Leerzeichen' from column_name) as arbitrary_name from table_name;
-- ... mit
-- MS SQL (ab Version 2017):
-- select trim('Eingabe von Tab + Leerzeichen' from column_name) as arbitrary_name from table_name;
-- ... mit
-- MS SQL (vor Version 2017), ohne Tabluatorenentfernung:
-- select ltrim(rtrim(column_name)) as arb_name from table_name;
-- ltrim - left trim; Ausgabe von 2 Spalten


-- 14.1.4 Text aus Spaltenwerten extrahieren (SUBSTRING)
-- Gibt immer nur String zurück!

-- MySQL, MariaDB, PostgreSQL:
select substring(artikelbezeichnung from 1 for 8) as extrakt1bis8inkludiert from produkt
where substring(artikelbezeichnung from 1 for 8)='Schraube';
-- MS SQL:
-- select substring(column_name,start_number,end_number) as alias_name from produkt;


-- 14.1.5 Textspaltenwerte verkettet ausgeben -- (CONCAT)
-- Mehrere Spaltenwerte zu einem Spaltenwert zusammenfügen

-- MySQL, MariaDB:
select concat(artikelbezeichnung,' ',kategorie,' ',legierung) as new from produkt;

-- PostgreSQL, SQL-Standard:
-- select col_name1||' '||col_name2||' '||col_name3 as alias_name from table_name;

-- MS SQL:
-- select col_name1+' '+col_name2+' '+col_name3 as alias_name from table_name;


-- 14.1.6 Übungen
-- Übung 1
select lower(legierung) as legierungklein, upper(legierung) as legierunggross from produkt; 

-- Übung 2 
select trim(both ' ' from legierung) from produktleerzeichen;

-- Übung 3
select substring(artikelbezeichnung from 10 for 1) from produkt;

-- Übung 4
select substring(artikelbezeichnung from 10 for 1) from produkt
where substring(artikelbezeichnung from 10 for 1)='1' or substring(artikelbezeichnung from 10 for 1)='2';
-- Alternative:
select substring(artikelbezeichnung from 10 for 1) from produkt
where substring(artikelbezeichnung from 10 for 1) in ('1','2');

-- Übung 5
select concat('_',artikelbezeichnung,'_',legierung,'_') from produktleerzeichen;


-- 14.2 Funktionen für Zahlenwerte
-- 14.2.1 Die Länge einer Zeichenkette ermitteln (CHAR_LENGTH, LEN)

-- MySQL, MariaDB, PostgreSQL:
select char_length(legierung) from produkt;

-- MS SQL:
-- select len(legierung) from produkt;


-- 14.2.2 Die Startposition einer Zeichenkette in einem Textwert ermitteln (POSITION, CHARINDEX)

-- An welcher Position/Index kommt Eisen vor?:
-- MySQL, MariaDB, PostgreSQL, SQL-Standard:
select position('Eisen' in legierung),legierung from produkt;

-- MS SQL:
-- select charindex('Eisen' in legierung) from produkt;


-- 14.2.3 Potenzen berechnen (POWER)
-- Basis: zu multiplizierende Zahl; Exponent: # Multiplikationen
-- POWER(basis, exponent)
select power(100,2) from produkt; 


-- 14.2.4 Eine Quadratwurzel berechnen (SQRT)
select sqrt(9);

-- 14.2.5 Übungen
-- Übung 1 
select artikelbezeichnung, char_length(artikelbezeichnung) from produktleerzeichen;
-- Aufgrund von Leerzeichen und Tabs kann es zu sehr unterschiedlichen Spaltenwertenlängen kommen

-- Übung 2
select position('n' in kategorie) from produkt;

-- Übung 3
select artikelbezeichnung,power(5,3) from produkt;

-- Übung 4
select artikelbezeichnung,sqrt(64) from produkt;


-- 14.3 Verschachtelte Funktionsaufrufe
select substring(legierung from position('Eisen' in legierung) for char_length('Eisen')) from produkt;

-- MS SQL:
-- select substring(legierung, patindex('%Eisen%',legierung),len('Eisen')) from produkt;

-- Getting current user:
select session_user(); -- put SELECT in front of it!

-- 14.3.1 Übungen
-- Übung 1
-- Von innen nach außen

-- Übung 2
select upper(trim(both ' ' from trim(both '	' from artikelbezeichnung))) from produktleerzeichen;


