-- SELECT-Abfrage unter einem Namen im Server speichern, der auch für Nutzer nutzbar, die keinen Zugriff auf die
-- beinhalteten Tabellen haben

-- 19.1 Einfach Views anlegen
-- View anlegen:
create view v_name_view as select mitarbeiterid from mitarbeiter; -- 'v_' als Standard, um Views von Tabellennamen zu 
-- unterscheiden

-- View benutzen/ansehen:
select * from v_name_view;

-- 19.1.1 Übungen 
-- Übung 1
-- Dass nicht schon ein gleicher table-Name existiert. Nutze 'v_' als Präfix

-- Übung 2
-- Dass sie nicht die gleichen Namen bekommen

-- Übung 3
-- Die View ändert sich mit nächsten Aufruf

-- Übung 4
create view v_urlaub as select name,vorname,urlaubstage,urlaubgenommen from mitarbeiter;

-- Übung 5
create view v_praemie as select m.name,m.vorname,s.praemie,s.grund from mitarbeiter m inner join sachpraemie s 
on m.mitarbeiterid=s.mitarbeiterid;
-- s.grund -> Spaltenname der View: grund -> In select-Liste müssen unterschiedliche Namen sein


-- 19.2 Views und ORDER BY

-- MySQL, MariaDB, PostgreSQL:
create view v_1 as select name,vorname from mitarbeiter order by name;

-- MS SQL:
-- create view v_view_name as select 
-- TOP 100 PERCENT -- new
-- name from mitarbeiter order by name;

-- View-Ansicht als anderer Nutzer neu sortieren:
select * from v_1 order by vorname;

-- 19.2.1 Übungen
-- Übung 1
create view v_mitarbeiterbonus as select m.name,m.vorname,b.bonuszahlung from mitarbeiter m inner join bonus b 
on m.mitarbeiterid=b.mitarbeiterid
order by b.bonuszahlung;

-- Übung 2
-- Die alte ORDER BY Klausel wird überschrieben


-- 19.3 INSERT,UPDATE und DELETE auf Views anwenden
-- Über eine View Tabelle verändern!

-- 19.3.1 Eine INSERT-Anweisung auf Views anwenden
-- Primärschlüssel muss von Original-table dabei sein, wenn kein auto_increment
-- Basic view erstellen:
create view v_mitarbeiter as select mitarbeiterid,name,vorname from mitarbeiter;
Insert into v_mitarbeiter values (55, 'EBERT','JOSEF'); -- fügt Zeile direkt in table 'mitarbeiter' via view 'v_mitarbeiter'
-- ein
select * from mitarbeiter;

-- Basic view erstellen:
create view v_mitarbeiterkontakt as select m.mitarbeiterid,m.name,m.vorname,k.festnetz,k.mobilnetz 
from mitarbeiter m inner join kontakt k 
on m.mitarbeiterid=k.mitarbeiterid;
-- PostgreSQL kann bei Views, die auf mehrere Tabellen zugreifen nichts inserten, ohne vorher:
-- create rule rule_to_insert as on insert to v_mitarbeiterkontakt
-- do instead insert into mitarbeiter (mitarbeiterid,name,vorname)
-- values (new.mitarbeiterid, new.name,new.vorname);
select * from mitarbeiter; -- wie versprochen in table eingefügt
insert into v_mitarbeiterkontakt (mitarbeiterid,name,vorname) values (56,'ALBERS','DANIEL');
select * from v_mitarbeiterkontakt; -- Nicht inserted, da INSERT nur auf table mitarbeiter bezogen, sodass no INNER JOIN
-- des Wertes mit der anderen table vorhanden war
-- Via einer View immer nur INSERT bezogen auf EINE TABELLE möglich!


-- 19.3.2 Eine UPDATE-Anweisung auf Views anwenden

-- PostgreSQL lässt kein UPDATE bei Views zu, die auf mehere tables zugreifen. Deshalb zuerst:
-- create rule rule_to_update as on update to v_mitarbeiterkontakt 
-- do instead update mitarbeiter set name=new.name where mitarbeiterid=new.mitarbeiterid
-- nun ist die Tabelle 'mitarbeiter' via der View aktualisierbar
update v_mitarbeiterkontakt set name='WINTER' where mitarbeiterid=35;
select * from mitarbeiter where mitarbeiterid=35; -- Name von Mitarbeiter in grundlegender Tabelle geändert
select * from v_mitarbeiterkontakt where mitarbeiterid=35; -- Name Mitarbeiter auch in View geändert, da dieses nichts
-- an INNER JOIN ändert
-- UPDATE kann immer nur an einer Tabelle auf einmal durchgeführt werden!

-- 19.3.3 Eine DELETE-Anweisung auf Views anwenden 
-- Sobald in View mehrere Tabellen Löschung nicht möglich
delete from v_mitarbeiter where mitarbeiterid=2;
select * from mitarbeiter where mitarbeiterid<4; -- Zeile aus zugrundeliegender Tabelle gelöscht
select * from v_mitarbeiter where mitarbeiterid<4; -- Zeile in View nicht mehr da

-- 19.3.4 Views, auf die keine INSERT-, DELETE- oder UPDATE-Anweisung angewendet werden kann
-- Nur Werte, die direkt in table vorkommen, können dann via View INSERT/DELETE/UPDATE.
-- Alle Fälle, in denen INSERT/DELETE/UPDATE nicht nutzbar, B.S. 584

-- 19.3.5 Übungen
-- Übung 1
-- Dass man beim INSERT auch den Primärschlüssel angibt, der auch in der View enthalten sein sollte

-- Übung 2
create view v_mitarbeiterkrankenkasse as select mitarbeiterid,name,vorname,krankenversicherung from mitarbeiter;
insert into v_mitarbeiterkrankenkasse values (100,'Bergstein','Oliver','MH PLUS'); -- auch hier muss man nicht immer
-- die Spaltennamen angeben

-- Übung 3
-- Dass diese neue Zeile nur auf eine von mehreren Tabellen Bezug hat, sprich durch das INNER JOIN wird sie nicht in 
-- der View auftauchen

-- Übung 4
update v_mitarbeiter set name='LANG' where mitarbeiterid=6;

-- Übung 5
-- Man kann immer nur die Spalten einer einzelnen zugrundeliegenden Tabelle ändern

-- Übung 6
delete from v_mitarbeiter where mitarbeiterid=6;

-- Übung 7
-- Wenn Werte in der SELECT-Abfrage verwendet werden, die nicht in einer Tabelle stehen. Operation auf Zeilenebene


-- 19.4 Views entfernen oder ersetzen
-- View löschen:
drop view name_view;

-- View ersetzen/überschreiben oder erstellen mit MySQL,MariaDB,PostgreSQL:
create or replace view v_view_name as select name from mitarbeiter;
-- MS SQL:
-- Hier muss man View löschen und eine neue erstellen, um sie zu überschreiben

-- 19.4.1 Übungen
-- Übung 1
drop view v_mitarbeiterkrankenkasse;

-- Übung 2
create or replace view v_mitarbeiterkontakt as select mitarbeiterid,name,vorname,email from mitarbeiter;