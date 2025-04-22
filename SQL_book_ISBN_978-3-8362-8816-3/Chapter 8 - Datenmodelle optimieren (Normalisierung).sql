-- 8.1 Redundanzen erkennen
-- 8.1.1 Was ist eine Redundanz?
-- 8.1.2 Was bedeutet Normalisierung?

-- 8.2 Die 1. Normalform anwenden
-- Die Attribute einer Entität müssen atmor und einwertig sein 
-- Lösung: Informationen über mehrere Spalten verteilen

-- 8.3 Die 2. Normalform anwenden
-- 1. Normalform erfüllt + jedes Attribut muss ganzheitlich vom Primärschlüssel abhängen
-- Lösung: 1 Tabelle in 2 Tabellen teilen

-- 8.4 Die 3. Normalform anwenden
-- Erste 2 Normalformen erfüllt +
-- Kein Nicht-Schlüsselattribut A soll von einem anderen Nicht-Schlüsselattribut B transitiv abhängig sein, sodass
-- A abhängig von B, B abhängig vom Primärschlüssel
-- Lösung: A aus Tabelle löschen + neue Tabelle mit B als Primärschlüssel und mit A machen
-- Wenn A/B ein character, dann in alte table mit einer A/B-id ersetzen und in neue table nur diese A/B-id als primary
-- key mit A/B aufnehemen  

-- 8.5 Denormalisierung
-- Normalisierungen rückgängig machen

-- 8.6 Übungen
-- Übung 1
create table table812(
	ausid smallint auto_increment primary key,
    auszubildender_name varchar(30) not null,
    auszubildender_vorname varchar(30) not null,
    urlaub_start date,
    urlaub_end date
	
);

insert into table812 (auszubildender_name,auszubildender_vorname,urlaub_start,urlaub_end) values ('Müller','Ralf','2016-04-05','2016-08-25');
insert into table812 (auszubildender_name,auszubildender_vorname,urlaub_start,urlaub_end) values ('Klein','Sabine','2016-04-05','2016-04-20');

select * from table812;
drop table table812;

-- Übung 2
create table table813a(
	ausid smallint auto_increment primary key,
    name varchar(30) not null,
    vorname varchar(30) not null
);

insert into table813a (name,vorname) values ('Müller','Ralf');
insert into table813a (name,vorname) values ('Klein','Sabine');


create table table813b(
	telid smallint auto_increment primary key,
    vorwahl varchar(10),
    durchwahl bigint,
	ausid smallint 
);

insert into table813b (vorwahl,durchwahl,ausid) values ('022x',88888888,2);
insert into table813b (vorwahl,durchwahl,ausid) values ('022x',99999999,1);

select * from table813a;
select * from table813b;

drop table table813a;
drop table table813b;

-- Übung 3
-- durchwahl abhängig von vorwahl, vorwahl abhängig von telid

-- Über die Lösung hier nicht ganz sicher, Buch scheint sich selbst zu widersprechen:

create table table814a(
	telid smallint primary key,
    durchwahl bigint,
    vorwahlid smallint,
    fk_ausid smallint
    
);

insert into table814a values (1,99999999,1,2);
insert into table814a values (2,88888888,1,1);

create table table814b(
	vorwahlid smallint primary key, -- Man braucht diese neue id, da Vorwahl nur ein character und keine Zahl!
    vorwahl varchar(10)
);

insert into table814b values (1,'022x');

select * from table814a;
select * from table814b;

drop table table814a;
drop table table814b;





