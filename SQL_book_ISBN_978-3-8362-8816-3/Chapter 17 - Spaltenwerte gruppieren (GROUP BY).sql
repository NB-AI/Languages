-- Aggregatfunktion: Zeilen gleicher Gruppen ausgewertet

-- 17.1 Die Aggregatfunktion COUNT answenden
select count(bonusid) from bonus group by mitarbeiterid; 

-- Zeilen zählen, die not null:
select count(mitarbeiterid) from bonus; -- identische Werte der 'mitarbeiterid' als unterschiedliche behandelt

-- Zeilen zählen, die not null + von duplizierten Spaltenwerten nur einer gezählt wird:
-- e.g. mitarbeiterid: 10,14,10 --> count:2 instead of 3
select count(distinct mitarbeiterid) from bonus;

-- Anzahl der jeweiligen Gruppenmitglieder zählen:
select mitarbeiterid, count(*) from bonus group by mitarbeiterid;

-- 17.1.1 Übungen
-- Übung 1
select count(bankid) as anzahlInstitutePerBLZ,bankleitzahl from kreditinstitut_auszug group by bankleitzahl;

-- Übung 2
select count(*) from kreditinstitut_auszug; -- Anzahl der Zeilen in einer table zählen


-- 17.2 Die Akkregatfunktion SUM anwenden
-- Wie viel Bonus jeder Mitarbeiter gruppiert nach 'mitarbeiterid' erhalten hat:
select mitarbeiterid,sum(bonuszahlung) from bonus group by mitarbeiterid;

-- 17.2.1 Übungen
-- Übung 1
select auszahlungsdatum,sum(bonuszahlung) from bonus group by auszahlungsdatum order by auszahlungsdatum;

-- Übung 2
select sum(bonuszahlung) from bonus;


-- 17.3 Die Aggregatfunktion AVG anwenden
-- Erhalt der durchschnittlichen Bonuszahlung je Gruppenmitglied
select avg(bonuszahlung) from bonus group by mitarbeiterid;

-- 17.3.1 Übungen
-- Übung 1
select auszahlungsdatum,avg(bonuszahlung) from bonus group by auszahlungsdatum order by auszahlungsdatum;

-- Übung 2
select avg(bonuszahlung) from bonus;

-- 17.4 Die Aggregatfunktion MAX anwenden -- MIN
-- Maximaler,minimaler Betrag einer Gruppe durch ein Gruppenmitglied:
select mitarbeiterid,max(bonuszahlung),min(bonuszahlung) from bonus group by mitarbeiterid;

-- 17.4.1 Übungen
-- Übung 1
select auszahlungsdatum,max(bonuszahlung) from bonus group by auszahlungsdatum order by auszahlungsdatum;

-- Übung 2
select max(bonuszahlung) from bonus;


-- 17.5 NULL-Werte berücksichtigen
-- Problematik 1: Null-Werte können eine eigene Gruppe bilden und andere Gruppen beim Aggregieren outperformen, doch
-- gibt diese Gruppe keinerlei Info, um wen es sich dabei eigentlich handelt (e.g. 'mitarbeiterid' is null)
-- Meine Lösung: Nutzung von: where group_col_name is not null

-- Problematik 2: Gruppen enthalten keine null-Werte, aber die zu aggregierende Spalte (e.g. 'bonuszahlung')
-- Lösung: Aggregatfunktionen ignorieren NULL-Werte automatisch
-- COUNT(*) beachtet null-Werte!
-- Wenn man null-Werte dennoch beachten möchte und diesen Wert 0 zuordnet:
select avg(case when bonuszahlung is null then 0 else bonuszahlung end), mitarbeiterid from bonus
where mitarbeiterid=10 group by mitarbeiterid;

-- 17.5.1 Übungen
-- Übung 1
-- NULL bildet eine eigene Gruppe

-- Übung 2
-- Sie ignorieren NULL-Werte, als würde die Zeile nicht existieren, es sei denn, man verwendet count(*), um jede Zeile 
-- zu zählen


-- 17.6 Nach aggregierten Werten einer Gruppierung filtern (HAVING)
-- HAVING Aggregatfunktion(Gruppe)>...alter
-- like WHERE only for groups; where nicht nutzbar für Aggregatfunktionen, da deren Ergebnis noch nicht in der table existiert

-- Nur BLZ zurückgeben, die einmal vorkommen:
select bankleitzahl, count(bankleitzahl) from kreditinstitut_auszug 
-- where -- where immer vor group by!
group by bankleitzahl 
having count(bankleitzahl)=1;

-- 17.6.1 Übungen
-- Übung 1
select bankleitzahl, count(bankleitzahl) from kreditinstitut_auszug group by bankleitzahl having count(bankleitzahl)>1; 

-- Übung 2
-- Weil das Ergebnis der Aggregatfunktionen noch nicht existent ist und WHERE auf Zeilenebene der table operiert


-- 17.7 Nach zwei oder mehr Spalten gruppieren
select ort,bezeichnung,count(*) as Anzahl_institute from kreditinstitut_auszug group by ort,bezeichnung;

-- 17.7.1 Übungen
-- Übung 1
select jahr,monat,mitarbeiterid,sum(anzahlstunden) from arbeitszeit_auszug group by jahr,monat,mitarbeiterid
order by jahr,monat,mitarbeiterid;

-- Übung 2
select jahr,monat,mitarbeiterid,sum(anzahlstunden) from arbeitszeit_auszug group by jahr,monat,mitarbeiterid
having sum(anzahlstunden)>176
order by jahr,monat,mitarbeiterid;