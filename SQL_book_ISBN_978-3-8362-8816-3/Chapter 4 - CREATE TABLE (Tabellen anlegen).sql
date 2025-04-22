-- 4.1 Datentypen
-- 4.1.5 Übungen
-- Übung 1
-- 1 Byte = 8 bit --> maximal number 2**8 - 1 = 255
-- Lösung für Dezimalzahl 178 ist 10110010 im Binärcode. Begründung: 2**7=128, sodass nur noch 50 von 178 fehlen, dieses
-- markiert das erste Bit links. Das letzte Bit steht für den Wert von 2**0. x in 2**x wird der Reihe nach runtergezählt.
-- 2**5 + 2**4 + 2**1 = 32 + 16 + 2 = 50

-- Übung 2
-- 2**(8*3)-1 = 2**24 - 1 = 16777215

-- Übung 3
-- TINYINT (1 Byte), SMALLINT (2), MEDIUMINT (3)
-- Genaue Datenbanklösung im Buch S. 174

-- Übung 4
-- DECIMAL, NUMERIC, -- nicht sicher ob diese auch: FLOAT, DOUBLE

-- Übung 5
-- TIMESTAMP, YEAR, DATE
-- Genaue Datenbanklösung im Buch S. 174

-- Übung 6
-- CHAR, VARCHAR. CHAR setzt für alle ungenutzten Zeichen der festgelegten Länge einer Kette ein Leerzeichen. 
-- VARCHAR lässt unbesetzte Stellen einfach aus.


-- 4.2 Datentypen umwandeln

-- 4.3 Typenkonvertierung
-- 4.3.1 Explizite Typenkonvertierung:
-- Kreieren einer Table mit der Spalte 'konvertierungsergebnis' mit einer konvertierten Integer zu einer Dezimalzahl
select cast(5 as decimal(6,3)) as kovertierungsergebnis;

-- MySQL, MariaDB:
select cast(3.4 as signed integer) as vondezimalzuanzahl; 
-- Ab .5 wird aufgerundet:
select cast(3.5 as signed integer) as vondezimalzuanzahl;

-- PostgreSQL, MS SQL Server:
-- SELECT CAST(3.4 AS INTEGER) AS vondezimalzuanzahl;

-- 4.3.2 Implizite Typenkonvertierung
select 4 + '9'; -- =13; gibt mathematische Addition zweier Zahlen zurück (trifft auf alle Datenbanken zu)
select 4 + '09'; -- auch hier

select 4+' 09.00 '; -- = 13 für MySQL, MariaDB; nicht möglich für PostgreSQL, MS SQL; Leerzeichen in ' 09.00 '
select 4+'09.53'; -- = 13.53; auch hier

select 4.53 + '9'; -- =13.530000000000001 kleiner Rundungsfehler für  MySQL, MariaDB; genaues Ergebnis mit PostgreSQL, MS SQL

select '3.47'+'9.53'; -- =13 für MySQL, MariaDB; nicht möglich für PostgreSQL; MS SQL: string+string a la Python

-- 4.3.3 Übungen
-- Übung 1
select cast('5' as unsigned integer) + 20;

-- Übung 2
select 100000 + '5.8';


-- 4.4 Einfache Tabellen mit CREATE TABLE erstellen
-- 4.4.1 Zielstruktur der Tabelle
-- 4.4.2 Tabelle anlegen
-- Kreieren einer Tabelle mit all ihren Spaltennamen und Datentypen der einzelnen Spalten:
create table dienstwagen(
	dienstwagenid smallint primary key, -- Festlegen eines Primärschlüssels, der als Index fungiert; er muss bei insert
    -- immer angegeben werden und kann nicht null sein
    kennzeichen char(9),
    erstzulassung date,
    kostenstelle smallint,
    hersteller varchar(200),
    modell varchar(200),
    leistung decimal(5,2),
    motor varchar(100),
    getriebe varchar(100),
    mitarbeiter varchar(300)
);

-- Überprüfen, ob eben erstellte Tabelle auch existiert:
select table_name from information_schema.tables where table_name='dienstwagen';
-- Rückgabe des Tabellennamens, wenn diese Tabelle auch existiert

-- Informationen in Tabelle setzen:
insert into dienstwagen (dienstwagenid,kennzeichen,erstzulassung) values (0,'XX-XX-XX1','2014-08-05');
-- Die eingefügten Informationen sollen dem Datentypen der jeweiligen Spalten entsprechen

select * from dienstwagen;

-- 4.4.3 Tabellen mit DROP-Anweisung löschen
drop table dienstwagen;

-- 4.4.4 Tabelle mit Prmärschlüssel ausstatten -> Bereits besprochen 

-- 4.4.5 Automatisch hochzählende numerische Primärschlüssel festlegen (Autoinkrementschlüssel)
create table dienstwagen(
	dienstwagenid smallint auto_increment primary key, -- mit PostgreSQL: dienstwagenid SERIAL PRIMARY KEY,
    -- mit MS SQL: dienstwagenid SMALLINT IDENTITY(startwert, schrittweite) PRIMARY KEY, 
    kennzeichen char(9),
    erstzulassung date
);

-- Jetzt da dienstwagenid-Wert automatisch generiert wird, wird der manuell eingefügte Wert 0 einfach ignoriert:
insert into dienstwagen (dienstwagenid,kennzeichen,erstzulassung) values (0,'XX-XX-XX1','2014-08-05'); 

-- dienstwagenid mit primary key muss nun nicht mehr angegeben werden:
insert into dienstwagen (kennzeichen,erstzulassung) values ('XX-XX-XX1','2014-08-05'); 

select * from dienstwagen;

-- 4.4.6 Reservierte Schlüsselwörter
-- Für Spalten- und Tabellennamen keine Anweisungen aus SQL nehemen. Liste von Tabus online (Buch S. 192)

-- 4.4.7 Übungen
-- Übung 1
create table fahrzeugtyp(
	typeid smallint auto_increment primary key,
    hersteller varchar(200),
    modell varchar(200),
    leistung decimal(5,2),
    motor varchar(100),
    getriebe varchar(100)
);

-- Übung 2
insert into fahrzeugtyp (hersteller,modell,leistung) values ('Toyota', 'X2', 555.22);
insert into fahrzeugtyp (hersteller,modell,leistung) values ('MAN', 'MANSuper', 900); -- 900 wird automatisch zu 
-- erforderlicher decimal(5,2) konvertiert
 
select typeid,hersteller,modell,leistung from fahrzeugtyp;

-- Übung 3
drop table fahrzeugtyp;


-- 4.5 Spalten Einschränkungen (CONSTRAINTS) zuordnen
-- 4.5.1 Spalten als Pflichtfelder (NOT NULL) definieren
drop table dienstwagen;
create table dienstwagen(
	dienstwagenid smallint primary key,
    kennzeichen char(9) not null, -- Wert in einer Zeile darf niemals null sein
    erstzulassung date not null,
    kostenstelle smallint null, -- Wert in einer Zeile darf null sein, muss nicht angegeben werden, da default value,
    -- ist auch bei den folgenden Zeilen der Fall:
    hersteller varchar(200),
    modell varchar(200),
    leistung decimal(5,2),
    motor varchar(100),
    getriebe varchar(100),
    mitarbeiter varchar(300)
);

insert into dienstwagen (dienstwagenid,kennzeichen,erstzulassung) values (1,'XX-XX-XX1','2015-01-04');
-- not null Datentyp-Spalten müssen immer mit Value ausgefüllt werden

select * from dienstwagen;

-- 4.5.2 Spalten mit UNIQUE-Einschränkung versehen
drop table dienstwagen;
create table dienstwagen(
	dienstwagenid smallint primary key,
    motor varchar(100) unique, -- Nur einzigartige Werte, keine Duplikate
    getriebe varchar(100) null unique,
    mitarbeiter varchar(300) not null unique
);

insert into dienstwagen (dienstwagenid,motor,getriebe,mitarbeiter) values (1,'4 Zylinder','Generation X', 'Ralf Müller');

select * from dienstwagen;

-- 4.5.3 Standardwerte mit DEFAULT für Spalten festlegen
drop table dienstwagen;
create table dienstwagen(
	dienstwagenid smallint primary key,
    kostenstelle smallint default 0, -- Anfangswert von 0 für jeden entry dieser Spalte festgelegt
    mitarbeiter varchar(300) not null default 'nobody' -- durch 'not null' wird der default value nicht durch null-Werte
    -- überschrieben
);

insert into dienstwagen (dienstwagenid,mitarbeiter) values (1,'Ralf Müller');
select * from dienstwagen;

-- 4.5.4 Bedingungen mit einer CHECK-Einschränkung für Spalten festlegen
drop table dienstwagen;
create table dienstwagen(
	dienstwagenid smallint primary key,
    motor varchar(100) check(motor='Diesel' or motor='Benzin') -- Später können in der Tabelle für die Spalte 'motor'
    -- nur 'Diesel' oder 'Benzin' eingetragen werden
);

insert into dienstwagen (dienstwagenid, motor) values (1,'Diesell'); -- sollte nicht funktionieren, da 'Diesell' gegen
-- die CHECK-Anweisung 'Diesel' oder 'Benzin' verstößt. Meine MySQL-Version < 8.0.16, daher wird die Zeile dennoch
-- ohne jeglichen Fehler erstellt

select * from dienstwagen;

-- 4.5.5 Übungen
-- Übung 1
create table mitarbeitergeschenk(
	geschenkid smallint auto_increment primary key,
    artikel varchar(200) not null,
    preis decimal(5,2) not null,
    jahreszugehoerigkeit smallint not null
);

insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Uhr',150.0,10);
insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Gemälde',900.0,20);

select * from mitarbeitergeschenk;

-- Übung 2
drop table mitarbeitergeschenk;
create table mitarbeitergeschenk(
	geschenkid smallint auto_increment primary key,
    artikel varchar(200) not null unique, -- wenn 'null unique', dann auch okay. Dann darf null unendlich oft vorkommen
    -- mit dieser MySQL-Version. Andere Werte dürfen nur einmal vorkommen
    preis decimal(5,2) not null,
    jahreszugehoerigkeit smallint not null
);
insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Uhr',150.0,10);
insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Gemälde',900.0,20);

insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Uhr',20.0,4);
-- Wir erhalten eine Fehlermeldung aufgrund der Duplizierung eines Wertes 'Uhr' mit der Einschränkung UNIQUE der Spalte
-- 'artikel'

-- Übung 3
drop table mitarbeitergeschenk;
create table mitarbeitergeschenk(
	geschenkid smallint auto_increment primary key,
    artikel varchar(200) not null unique, 
    preis decimal(5,2) not null default 0.00,
    jahreszugehoerigkeit smallint not null
);

insert into mitarbeitergeschenk (artikel,jahreszugehoerigkeit) values ('Uhr',10);
insert into mitarbeitergeschenk (artikel,jahreszugehoerigkeit) values ('Gemälde',20);

select * from mitarbeitergeschenk;
drop table mitarbeitergeschenk;

-- Übung 4
drop table mitarbeitergeschenk;
create table mitarbeitergeschenk(
	geschenkid smallint auto_increment primary key,
    artikel varchar(200) not null unique, 
    preis decimal(5,2) not null,
    jahreszugehoerigkeit smallint not null check(jahreszugehoerigkeit=5 or jahreszugehoerigkeit=10 or jahreszugehoerigkeit=15 or jahreszugehoerigkeit=20)
);

insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Uhr',150.00,10);
insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Gemälde',900.00,20);

insert into mitarbeitergeschenk (artikel,preis,jahreszugehoerigkeit) values ('Goodie',4.00,1);
-- check funktioniert mit meiner Version nicht

select * from mitarbeitergeschenk;
drop table mitarbeitergeschenk;

-- 4.6 Spalten auf Tabellenebne Einschränkungen (CONSTRAINT) zuordnen
-- 4.6.1 Primärschlüssel auf Tabellenebene festlegen

-- Primary key für eine Spalte auf Tabellenebene festlegen:
create table zweigstellen(
	land varchar(200),
    zweigstellenid smallint,
    namezweigstelle varchar(200),
    constraint pk_land_zweigstellen primary key (land)
);

drop table zweigstellen;

-- Zusammengesetzter primary key für mind. 2 Spalten auf Tabellenebne festlegen:
create table zweigstellen(
	land varchar(200),
    zweigstellenid smallint,
    namezweigstelle varchar(200),
    constraint pk_land_zweigstellen primary key (land, zweigstellenid) -- Die Kombination aus diesen zwei Spaltenwerten
    -- ergibt einen einzigartigen primary key; Reihenfolge Zeilen in Tabelle gegeben durch Reihenfolge der insert-Anweisungen
);

-- 4.6.2 Eine UNIQUE-Einschränkung auf Tabellenebene festlegen
drop table zweigstellen;
create table zweigstellen(
	globalid smallint primary key, -- primary key nicht vergessen, nach dem die Tabellen-Zeilen sortiert werden
	land varchar(200),
    zweigstellenid smallint,
    namezweigstelle varchar(200),
    constraint pk_land_zweigstellen unique (land, zweigstellenid)  -- Die Kombination von 'land' und 'zweigstellenid'
    -- muss immer einzigartig sein
);

-- 4.6.3 Eine CHECK-Einschränkung auf Tabellenebene festlegen
drop table zweigstellen;
create table zweigstellen(
	globalid smallint primary key, -- primary key nicht vergessen
	land varchar(200),
    zweigstellenid smallint,
    namezweigstelle varchar(200),
    mitarbeiterplanzahl smallint,
    mitarbeiteristzahl smallint,
    constraint ch_mitarbeiterzahl check(mitarbeiterplanzahl>=mitarbeiteristzahl) 
    -- Spaltenwerte werden miteinander vergleichbar; nur Werte einfügbar, die dieser Bedinung entsprechen
    -- (ab bestimmter MySQL-Version möglich)
);

-- 4.6.4 Übungen
-- Übung 1
create table produktionsmaschinen(
	maschinenid smallint,
    variante smallint,
    bezeichnung varchar(200),
    constraint kombi primary key (maschinenid,variante)
);

insert into produktionsmaschinen values (100, 4, 'Schrederer');
insert into produktionsmaschinen values (101, 4, 'Schrederer XL');

select * from produktionsmaschinen;

-- Übung 2
drop table produktionsmaschinen;
create table produktionsmaschinen(
	globalid smallint primary key,	
	maschinenid smallint,
    variante smallint,
    bezeichnung varchar(200),
    constraint kombi unique (maschinenid,variante)
);

insert into produktionsmaschinen values (1,100, 4, 'Schrederer');
insert into produktionsmaschinen values (2,101, 4, 'Schrederer XL');
insert into produktionsmaschinen values (3,100, 3, 'Schrederer');
insert into produktionsmaschinen values (4,101, 3, 'Schrederer XL');

select * from produktionsmaschinen;

-- Übung 3
drop table produktionsmaschinen;
create table produktionsmaschinen(
	globalid smallint primary key,	
	maschinenid smallint,
    variante smallint,
    bezeichnung varchar(200),
    laufzeit int,
    maxlaufzeit int,
    constraint kombi unique (maschinenid,variante), 
    constraint vergleich check(laufzeit<maxlaufzeit) -- wir können ganz einfach zweites constraint hinzufügen
    
);

insert into produktionsmaschinen values (1,100, 4, 'Schrederer',7,10);
insert into produktionsmaschinen values (2,101, 4, 'Schrederer XL',9,12);
insert into produktionsmaschinen values (3,100, 3, 'Schrederer',1,7);
insert into produktionsmaschinen values (4,101, 3, 'Schrederer XL',33,2);

select * from produktionsmaschinen;
