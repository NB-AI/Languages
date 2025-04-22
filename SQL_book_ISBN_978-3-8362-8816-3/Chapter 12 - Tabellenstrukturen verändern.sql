-- Datenstrukturen + Einschränkungen Tabellen nachträglich ändern

-- 12.1 Eine Tabelle umbenennen

-- MySQL, MariaDB:
alter table infokunde rename kundeinfo; -- In 'kundeinfo' umbenennen
-- Alternative:
rename table infokunde to kundeinfo; -- mit dieser Variante mehrere Tabellen auf einmal umbenennen:
rename table altername1 to neuername1, alternamte2 to neuername2, altername3 to neuerename3;

-- PostgreSQL:
-- alter table infokunde rename to kundeinfo;

-- MS SQL:
-- EXEC SP_RENAME 'datenbankschema_dbo.infokunde', neuer_Datenbankobjektname;

-- 12.2 Spalten einer Tabelle ändern
-- 12.2.1 Eine Spalte umbenennen
-- Bis MySQL Version 8.0 oder neuer, MariaDB:
alter table kundeinfo change informationkunde information varchar(120); -- Datentyp kann leicht abgeändert werden, z. B. von varchar(120) zu 
-- varchar(140)
-- alter table table_name change alter_Spaltenname neuer_Spaltenname varchar(120);
-- Alternative:

-- MySQL ab Version 8.x (x>0), MariaDB, PostgreSQL
alter table kundeinfo rename column informationkunde to information;

-- MS SQL:
-- EXEC SP_RENAME 'datenbankschema_dbo.table_name.old_column_name', new_column_name;

-- 12.2.2 Den Datentyp einer Spalte ändern

-- MySQL, MariaDB:
alter table kundeinfo modify bewertung smallint unsigned;
-- alter table table_name modify column_name new_data_type;
-- Prüfung:
update kundeinfo set bewertung=50000 where infoid=3;

-- PostgreSQL:
-- alter table table_name alter column column_name type integer(neuer_Datentyp);

-- MS SQL:
-- alter table table_name alter column column_name integer;
-- Prüfung PostgreSQL, MS SQL:
-- update table_name set column_name=2147000000 where infoid=3;

-- 12.2.3 Eine Spalte als Primärschlüsselspalte definieren
-- Wenn kein primary key in table, diesen nachholen:
-- MySQL, MariaDB, PostgreSQL, MS SQL:
alter table kundeinfo add constraint arbitrary_constraint_name primary key(infoid); -- Spalte infoid erfüllt die Voraussetzungen, um eine 
-- primary key Spalte zu werden

-- Prüfung:
insert into kundeinfo (infoid,information) values(3,'Standardkunde');


-- primary key Rechte entziehen:
-- MySQL, MariaDB:
alter table kundeinfo drop primary key;
-- alter table table_name drop primary key;

-- PostgreSQL, MS SQL:
-- alter table table_name drop constraint_name;

-- 12.2.4 Einer Spalte eine NOT NULL-Einschränkung zuordnen 
-- Nur möglich, wenn Spalte nicht schon null-Werte hat
-- MySQL, MariaDB:
alter table kundeinfo modify firma varchar(120) not null;
-- alter table table_name modify column_name data_type not null;

-- Überprüfung:
insert into kundeinfo (infoid,information,firma,bewertung) values (4,'Guter Kunde!',null,3);
-- Fehlermeldung nötig, dann wissen wir, dass null nicht länger zulässig

-- PostgreSQL:
-- alter table table_name alter column column_name set not null;

-- MS SQL:
-- alter table table_name alter column column_name varchar(120) not null;


-- 12.2.5 Einer Spalte eine NULL-Einschränkung zuordnen

-- MySQL, MariaDB:
alter table kundeinfo modify firma varchar(120) null;
-- alter table table_name modify column_name data_type null;

-- Überprüfung:
insert into kundeinfo (infoid,information,firma,bewertung) values (5,'Guter Kunde!',null,3); -- sollte ohne Fehlermeldung funktionieren

-- PostgreSQL:
-- alter table table_name alter column column_name drop not null;

-- MS SQL:
-- alter table table_name alter column column_name varchar(120)(data_type) null;


-- 12.2.6 Einer Spalte einen Standardwert (DEFAULT VALUE) zuordnen
-- ändert nichts an vorhandenen Werten, sondern nur an zukünftig eingefügten (für set, drop)
select * from dsgvo;
insert into dsgvo values (1,'Schrauben Meier GmbH', null);

-- MySQL, MariaDB, PostgreSQL:
alter table dsgvo alter column status set default 'nicht zugestimmt';
insert into dsgvo (dsgvoid) values (4);
select * from dsgvo;

-- MS SQL:
-- alter table table_name add constraint arbitrary_constraint_name default 'default-Wert' for column_name;


-- Standardwertzuordnung entfernen: 
-- MySQL, MariaDB, PostgreSQL:
alter table dsgvo alter column status drop default;

-- Überprüfung:
insert into dsgvo (dsgvoid) values (5); -- Bug für MySQL, MariaDB; funktioniert bei PostgreSQL, MS SQL
select * from dsgvo;

-- MS SQL:
-- alter table table_name drop constraint constraint_name;


-- 12.2.7 Einer Spalte eine UNIQUE-Einschränkung zuordnen
-- MySQL, MariaDB, PostgreSQl, MS SQL:
alter table kundeinfo add constraint arbitrary_constraint_name1 unique (firma);
-- MS SQL betrachtet auch NULL eindeutig!
-- Überprüfung: Inserten von Doppelgängerspaltenwert

-- Entfernen der UnIQUE constraint 
-- MySQL, MariaDB:
alter table kundeinfo drop index arbitrary_constraint_name1;

-- PostgreSQL, MS SQL:
-- alter table table_name drop constraint constraint_name;


-- 12.2.8 Eine Spalte mit einer CHECK-Einschränkung versehen

-- 1. Vorbereitung. Anpassen der Spaltenwerte, damit nach CONSTRAINT-Erstellung CHECK keine Fehlermeldung:
update kundeinfo set bewertung=1 where infoid=3;

-- 2. CONSTRAINT CHECK in table einfügen. MySQL, MariaDB, PostgreSQL, MS SQL:
alter table kundeinfo add constraint arbitrary_constraint_name3 check(bewertung=1 or bewertung=2 or bewertung=3 or bewertung=4 or bewertung=5);

select * from kundeinfo;

-- Entfernen von CHECK:
-- MySQL ab 8.0.16:
alter table kundeinfo drop check arbitrary_constraint_name3;
-- Alternative:
-- MySQL (meine Beobachtung), MariaDB, PostgreSQL, MS SQL:
-- alter table table_name drop constraint constraint_name;


-- 12.3 Spalten hinzufügen und entfernen
-- 12.3.1 Einer Tabelle eine Spalte hinzufügen

-- MySQL, MariaDB, PostgreSQL:
alter table kundeinfo add column datuminfo date;

-- MS SQL:
-- alter table table_name add column_name data_type;


-- 12.3.2 Eine Spalte aus einer Tabelle entfernen
-- MySQL, MariaDB, PostgreSQL, MS SQL:
alter table kundeinfo drop column informationkunde2;


-- 12.4 Beziehungen zwischen Tabellen herstellen und entfernen
-- Fremdschlüssel erstellen:
-- MySQL, MariaDB, PostgreSQl, MS SQL:
alter table anschrift add constraint arbitrary_constraint_name4 foreign key (fk_kundeid) references premiumkunde (kundeid);

-- Fremdschlüssel entfernen:

-- MySQL, MariaDB:
alter table anschrift drop foreign key arbitrary_constraint_name4;
-- Alternative:
-- MySQL (meine Beobachtung), MariaDB (maybe), PostgreSQl, MS SQL:
alter table anschrift drop constraint arbitrary_constraint_name4 ;


-- 12.5 Übungen -- hier nochmal alle Formeln der Reihe nach übersichtlich
-- Übung 1
alter table artikel rename artikelaktuell;

-- Übung 2
alter table artikelaktuell rename column bezeichnung_artikel to bezeichnung;

-- Übung 3
alter table artikelaktuell modify status varchar(300);

-- Übung 4
alter table artikelaktuell add constraint u4 primary key (artikelid);

-- Übung 5
alter table artikelaktuell drop primary key;

-- Übung 6
alter table artikelaktuell modify tiefe decimal(8,2) not null;

-- Übung 7
alter table artikelaktuell modify tiefe decimal(8,2) null;

-- Übung 8
alter table artikelaktuell alter column preis set default 0.00;

-- Übung 9
alter table artikelaktuell alter column preis drop default;

-- Übung 10 
alter table artikelaktuell add constraint u10 unique (bezeichnung);

-- Übung 11
alter table artikelaktuell drop index u10;

-- Übung 12
update artikelaktuell set preis=999 where preis>999;
alter table artikelaktuell add constraint u11 check(preis<1000);

-- Übung 13
alter table artikelaktuell drop check u11;

-- Übung 14
alter table artikelaktuell add column kommentar varchar(300);

-- Übung 15
alter table artikelaktuell drop column kommentar;

-- Übung 16
alter table artikelinfo add constraint u16a primary key (artikelid); -- damit unter Zeile funktioniert

alter table positionartikel add constraint u16 foreign key (fk_artikelinfo_artikelid) references artikelinfo (artikelid);
-- artikelid needs to be a primary key!

-- Übung 17
alter table positionartikel drop foreign key u16;









