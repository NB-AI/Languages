-- 5.1 Mengenoperationen auf Ergebnistabellen anwenden
select * from mengea;

-- 5.1.1 Eine Vereinigungsmenge aus zwei Mengen bilden
select element from mengea UNION select element from mengeb;
-- Alternative:
select element from mengea UNION DISTINCT select element from mengeb; -- mit DISTINCT das Gleiche, da dieses schon als
-- default verwendet

-- Mit Duplikaten aus zwei Mengen
select element from mengea UNION ALL select element from mengeb;

-- 5.1.2 Eine Schnittmenge bilden
select element from mengea INTERSECT select element from mengeb; -- INTERSECT gibt es nicht für MySQL! Aber für MariaDB

-- 5.1.3 Eine Differenzmenge bilden
select element from mengea EXCEPT select element from mengeb; -- EXCEPT gibt es nicht für MySQL! Aber für MariaDB

-- 5.2 Eine Vereinigungsmenge bilden (UNION)
-- 5.2.1 Vereinigunsmengen von Ergebnistabellen bilden
-- Beliebig viele Tabellen(-Spalten) zusammenführen:
select artikelbezeichnung,kategorie,legierung from produkt 
union 
select artikelbezeichnung,kategorie,legierung from produktarchiv
union 
select artikelbezeichnung,kategorie,legierung from produkt;

-- Mit Duplikaten:
select artikelbezeichnung,kategorie,legierung from produkt union all select artikelbezeichnung,kategorie,legierung from produktarchiv;

-- Verhalten mit NULL-Werten:
insert into produkt values (6,null,null,null,null);
insert into produktarchiv values (150,null,null,null,null);
select artikelbezeichnung,kategorie,legierung from produkt union all select artikelbezeichnung,kategorie,legierung from produktarchiv;
-- Wenn nur union statt union all verwendet, dann nur eine Null-Zeile in Ergebnistabelle, ansonsten 2;
-- Gleiches gilt für INTERSECT/EXCEPT für PostgreSQL/MariaDB/MS SQL

-- 5.2.2 Übungen
-- Übung 1
select name,vorname from niederlassungbelgien
union -- eindeutige Verinigung (=keine Duplikate)
select name,vorname from niederlassungholland;

-- Übung 2
select name,vorname from niederlassungbelgien
union all
select name,vorname from niederlassungholland;

-- Übung 3
select name,vorname from niederlassungbelgien
union 
select name,vorname from niederlassungholland
union
select name,vorname from niederlassungschweiz;


-- 5.3 Die Schnittmenge von Ergebnistabellen bilden (INTERSECT)
-- 5.3.1 Schnittmengen in Ergebnistabellen
-- Funktioniert nicht für MySQL:
select artikelbezeichnung from produkt
intersect 
select artikelbezeichnung from produktarchiev;

-- Erhalt für eine Alternative für MySQL, da dieses INTERSECT nicht unterstützt:
select p.artikelbezeichnung,p.kategorie,p.legierung from produkt p INNER JOIN produktarchiv pa on
	p.artikelbezeichnung=pa.artikelbezeichnung
	and
    p.kategorie=pa.kategorie
    and
    p.legierung=pa.legierung
;

-- 5.3.2 Übungen
-- Übung 1
select t.name,t.vorname from niederlassungholland t inner join niederlassungbelgien tt on
	t.name=tt.name
    and
    t.vorname=tt.vorname
;

-- Übung 2
select t.name,t.vorname from niederlassungholland t 
	inner join niederlassungbelgien tt on
		t.name=tt.name
		and
		t.vorname=tt.vorname
	inner join niederlassungschweiz ttt  on
		tt.name=ttt.name -- can be also t.name
		and
		tt.vorname=ttt.vorname
;

-- Übung 3
select t.name,t.vorname,t.status from niederlassungholland t inner join niederlassungbelgien tt on
	t.name=tt.name
    and
    t.vorname=tt.vorname
    and
    t.status=tt.status
;
-- Wir haben eine weitere Bedingung, die erfüllt werden muss und so den Spaltenwert einschränkt

-- 5.4 Eine Differenzmenge aus Ergebnistabellen bilden (EXCEPT)

-- 5.4.1 Differenzmenge von Ergebnismenge bilden
-- MySQL:
select p.artikelbezeichnung,p.kategorie,p.legierung from produkt p
left outer join produktarchiv pa on
	p.artikelbezeichnung=pa.artikelbezeichnung
    and
    p.kategorie=pa.kategorie
    and
    p.legierung=pa.legierung
where pa.artikelbezeichnung is null and pa.kategorie is null and pa.legierung is null;

-- 5.4.2 Übungen
-- Übung 1
select h.name,h.vorname from niederlassungholland h
left outer join niederlassungbelgien b on
	h.name=b.name
    and
    h.vorname=b.vorname
where b.name is null and b.vorname is null;

-- Übung 2
select h.name,h.vorname from niederlassungholland h
left outer join niederlassungbelgien b on
	h.name=b.name
    and
    h.vorname=b.vorname
left outer join niederlassungschweiz s on 
	h.name=s.name
    and 
    h.vorname=s.name
where b.name is null and b.vorname is null and s.name is null and s.vorname is null;
-- Lösung Buch Seite 246


-- 5.5 Mengenoperationen in Kombination mit einer WHERE-Klausel verwenden
-- 5.5.1 Vor einer Vereinigungsoperation mit UNION filtern
-- Bereits Gefiltertes soll UNION bekommen. Gilt auch für INTERSECT, EXCEPT!
select artikelbezeichnung from produkt where artikelbezeichnung='Schraube 1'
union all
select artikelbezeichnung from produktarchiv where artikelbezeichnung='Schraube 2';

-- 5.5.2 Übungen
-- Übung 1
select name,vorname,status from niederlassungholland where status='aktiv'
union 
select name,vorname,status from niederlassungbelgien where status='aktiv';

-- 5.6 Vereinigungsmengen in Kombination mit ORDER BY-Klausel
-- ORDER BY zum Sortieren des Ergebnisses einer Mengenoperation:
select artikelbezeichnung from produkt
union
select artikelbezeichnung from produktarchiv
order by artikelbezeichnung;

-- 5.6.1 Übungen
-- Übung 1
select name,vorname from niederlassungholland 
union
select name,vorname from niederlassungbelgien
order by name;

-- Übung 2
select h.name,h.vorname from niederlassungholland h
left outer join niederlassungbelgien b on
	h.name=b.name
    and 
    h.vorname=b.name
where b.name is null and b.vorname is null
order by h.name;