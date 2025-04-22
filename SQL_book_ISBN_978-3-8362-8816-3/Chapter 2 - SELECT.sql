-- SELECT als ledigliche Abfrage

-- Getting names of all employees in table mitarbeiter:
SELECt name,vorname FROM mitarbeiter;
select name FROM mitarbeiter;

-- getting whole dataframe:
select * from mitarbeiter;

-- 2.1.5 Übungen 
-- Übung 2
select name,vorname,eintrittsdatum,austrittsdatum,austrittsgrund From mitarbeiter;

-- where
select *from mitarbeiter where name='Lang';
select name,vorname,festnetz,mobilnetz from mitarbeiter where name='Lang';
select name,vorname,plz from mitarbeiter where plz=50000;
select name,vorname,plz from mitarbeiter where plz='50000'; -- kein Unterschied

-- Unverheiratete Mitarbeiter:
select name,vorname,steuerklasse,verheiratet from mitarbeiter where verheiratet<>'ja';

-- Mitarbeiter mit Bonus kleiner als 500:
select name,vorname,bonus from mitarbeiter where bonus<500;

-- Mitarbeiter Mitglied bereits vor diesem Datum:
select name,vorname,eintrittsdatum from mitarbeiter where eintrittsdatum<='1978-01-01';

-- Mitarbeiter mit mehr als 500 Bonus:
select name,vorname,bonus from mitarbeiter where not bonus<=500;

-- Doppelte Negierung:
select name,vorname from mitarbeiter where not name<>'Winter';

-- in between:
select name,vorname,umsatz from mitarbeiter where umsatz between 200000 and 600000;
select name,vorname,umsatz from mitarbeiter where umsatz not between 200000 and 600000;

-- LIKE:
select name,vorname,strasse from mitarbeiter where strasse like '%straße';
select name,vorname,strasse from mitarbeiter where strasse like '%STRAße'; -- kein unterschied

-- alles, was nicht auf straße endet
select name,vorname,strasse from mitarbeiter where strasse not like '%straße';

-- Mitarbeiter eines Teams finden:
select mitarbeiterid,name,vorname from mitarbeiter where name in ('Stein','Klein','Schneider');

-- null-Werte:
-- Spalten, die überprüfen, ob name null oder Klein ist
select name,name=null,name='Klein' from mitarbeiter; 

-- Einzelne Werte ohne Tabelle überprüfen:
select null=null; -- Ergebnis null, da diese nicht gleich sein können, da sie nicht definiert sind
select 1=1;

-- Alle Mitarbeiter mit NULL Umsatz:
select name,vorname,abteilung,umsatz from mitarbeiter where umsatz is null;

-- Alle Mitarbeiter, die Umsatzwerte haben (nicht NULL):
select name,vorname,abteilung,umsatz from mitarbeiter where umsatz is not null;

-- Vergleich Spaltenwerte untereinander:
select name,vorname,umsatz,bonus from mitarbeiter where bonus>umsatz;

-- 2.2.14 Übungen:
-- Übung 1:
select * from mitarbeiter where abteilung='Vertrieb';

-- Übung 2:
select name,vorname,urlaubgenommen from mitarbeiter where urlaubgenommen=30;

-- Übung 3:
select name,vorname,eintrittsdatum,eintrittsdatum='1978-05-22' from mitarbeiter;

-- Übung 4:
select name,vorname,bankinstitut from mitarbeiter where bankinstitut!='Stadtsparkasse Köln';

-- Übung 5:
select name,vorname,ueberstunden from mitarbeiter where ueberstunden<=0;

-- Übung 6:
select name,vorname,ueberstunden from mitarbeiter where ueberstunden>0;

-- Übung 7:
SELECT name,vorname, eintrittsdatum from mitarbeiter where eintrittsdatum>='2000-01-01';

-- Übung 8:
select mitarbeiterid,name,vorname,anzahlkinder from mitarbeiter where not anzahlkinder=0;

-- Übung 9:
select mitarbeiterid,name,vorname,eintrittsdatum from mitarbeiter where eintrittsdatum between '1990-01-01' and '2000-01-01';

-- Übung 10:
select name,vorname,geschlecht,geschlecht='m' from mitarbeiter;
-- Lösung:
select name,vorname,geschlecht from mitarbeiter where geschlecht LIKE '_'; 

-- 2.3 boolean in where
select name,vorname,ueberstunden,anzahlkinder,abteilung from mitarbeiter where ueberstunden>0 and anzahlkinder>0 and abteilung='Verkauf';

select name,vorname,abteilung from mitarbeiter where abteilung='Einkauf' OR abteilung='Controlling';

-- Finden der ausgetretenen Leute, die nicht wegen Ruhestand aufhörten!:
select name, austrittsdatum, austrittsgrund from mitarbeiter where austrittsdatum IS not null and not austrittsgrund='ruhestand';
-- is not null: ist hier überflüssig, da es normalerweise selber rausgefiltert wird
-- A NOT B: Bedingung A=wahr B=falsch, damit wahr

-- A OR NOT B: A=wahr oder (execlusive) B=A, damit wahr
select name, abteilung,austrittsgrund from mitarbeiter where abteilung='Einkauf' or not austrittsgrund='abfindungsprogramm';
-- Finden der Menschen in abteilung Einkauf/Menschen der Abteilung Einkauf mit Abfindungsprogramm/Menschen einer 
-- anderen Abteilung ohne Abfindungsprogramm

-- stärkere Bindung von AND als für OR:
select name,urlaubstage,urlaubgenommen from mitarbeiter where urlaubstage=30 and urlaubgenommen<20 or urlaubstage=15 and urlaubgenommen<10;
-- Klammersetzung:
select name, steuerklasse,anzahlkinder,verheiratet from mitarbeiter where steuerklasse=1 and (anzahlkinder>0 or verheiratet='ja');

-- 2.3.10 Übungen
-- Übung 1:
select name,geschlecht,abteilung from mitarbeiter where (geschlecht='m' and abteilung='Vertrieb');

-- Übung 2:
select name, krankenversicherung from mitarbeiter where krankenversicherung='MH Plus Bonn' or krankenversicherung='IKK gesund plus';

-- Übung 3:
select name, gebdatum, austrittsgrund from mitarbeiter where gebdatum<'1955-01-01' and austrittsgrund is null;

-- Übung 4:
select name, geschlecht, anzahlkinder,verheiratet, 5000 from mitarbeiter where geschlecht='w' and anzahlkinder>0 and verheiratet='nein';

-- 2.4 Ergebniszeilen einer select Anweisung einschränken - Anzahl Ergebnisse für ersten Überblick einschränken
-- 2.4.1 FETCH, LIMIT, TOP
-- für MySql- und MariaDB-Datenbank:
select name,vorname from mitarbeiter limit 2; -- limitieren des Ergebnisses auf 2 Zeilen vom df
-- für Microsoft SQL Server:
-- select TOP 2 name,vorname from mitarbeiter;
-- für PostgreSQL-Datenbank:
-- select name from mitarbeiter fetch first 2 rows only;

-- 2.4.2 Übungen
-- Übung 1
-- limit

-- Übung 2
select * from krankenkasse limit 10;

-- 2.5 Datensätze sortiert abfragen

-- aufsteigende Sortierung:
select name from mitarbeiter order by name;
-- same:
select name from mitarbeiter order by name asc;

-- absteigend:
select name from mitarbeiter order by name desc;

-- mehrere Spalten:
select name,vorname from mitarbeiter order by name,vorname; -- order by a,b --> a dominant
-- Was auch geht, meine Entdeckung:
select name,vorname from mitarbeiter order by name desc,vorname; -- nur name in descending order
select name,vorname from mitarbeiter order by name,vorname desc; -- nur vorname in descending order
select name,vorname from mitarbeiter order by name desc,vorname desc;

-- WHERE und ORDER BY
select name,abteilung from mitarbeiter where abteilung='Controlling' order by name;

-- 2.5.7 Übungen
-- Übung 1
select name,vorname,abteilung from mitarbeiter order by abteilung;

-- Übung 2
select name,vorname,abteilung from mitarbeiter order by abteilung desc;

-- Übung 3
select name,vorname,abteilung,bonus from mitarbeiter order by abteilung,bonus;

-- Übung 4
select name,vorname,austrittsdatum from mitarbeiter order by austrittsdatum desc;
-- hier werden auf einmal auch null-Werte angezeigt

-- Übung 5
select name,vorname,austrittsgrund,austrittsdatum from mitarbeiter where austrittsgrund='Ruhestand' order by austrittsdatum;

-- 2.6 Konstanten in die Spaltenauswahlliste aufnehmen
-- In der Ausgabe visualisieren von Dingen für Interpretierer von Daten
-- Konstante über alle Zeilen gleich
select 'Herzlichen Glückwunsch zum Geburtstag';
select 'Guten Tag',name from mitarbeiter limit 2;

-- Übung 2.6.3
-- Übung 1
select 'Hallo','Du';

-- Übung 2
select name,vorname,'hat man',gebdatum,'Geburtstag' from mitarbeiter;

-- Übung 3
select name,vorname,' erhält ',120,' Leistungspunkte' from mitarbeiter;

-- 2.7 Spalten einen Alias zuordnen
-- In der Ausgabe Spaltenüberschriften für besseres Verständnis verwenden
select name neuer_name, vorname from mitarbeiter;
-- same:
select name AS neuer_name,vorname from mitarbeiter;

-- Konstantenüberschrift:
select name,vorname, 500 zusatzbonus from mitarbeiter;

-- 2.7.4 Übungen
-- Übung 1
select name Name,vorname Vorname,strasse Strasse,hausnummer Hausnummer,plz Postleitzahl,ort Ort from mitarbeiter limit 2;

-- Übung 2
select 'Willkommen' Begruessung, name, vorname from mitarbeiter limit 2;

-- 2.8 Gleiche Ergebniszeilen ausschließen (DISTINCT)
-- Duplicate full rows
select distinct name,vorname from mitarbeitergleich;

-- 2.8.1 Übungen
-- Übung 1
select distinct produkt,beschreibung,marktbewertung from produktgleich;

-- Übung 2
-- Weil die beiden Zeilen nicht genau identisch sind.
