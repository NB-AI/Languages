-- 10.1 Zeilen in Tabellen einfügen, die in Beziehung zueinander stehen -- nichts Neues, Kapitel ignorierbar
-- 10.1.1 Zeilen in die Tabelle 'auszubildender' einfügen -- nichts Neues einfach Zeilen einfügen wie gewohnt, da 
-- große Entität/Elterntabelle 
-- 10.1.2 Zeilen in die Tabelle 'ausbildungsberuf' einfügen -- nichts Neues, selbes wie Kapitel davor
-- 10.1.3 Zeilen in die Tabelle 'lehrfach' einfügen -- nichts Neues, selbes wie Kapitel davor
-- 10.1.4 Zeilen in die Tabelle 'adresse' einfügen (inklusive der Beziehungen) einfügen -- zwar in 1:n-Beziehung, 
-- aber man muss lediglich Fremdschlüsselwert (auch null) angeben beim Inserten
-- 10.1.5 Zeilen in die Tabelle 'ausbildungsvertrag' einfügen (inklusive der Beziehungen) einfügen -- nichts Neues
-- 10.1.6 Zeilen in die Tabelle 'beruflehrfach' einfügen (inklusive der Beziehungen) einfügen -- nichts Neues
-- 10.1.7 Zeilen in die Tabelle 'mitarbeiterausbildungsbetrieb' einfügen (inklusive der Beziehungen) einfügen -- nichts Neues


-- Aus den Unterkapiteln hier drüber, unwichtig:

INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (1,'Müller','Ralf','2001.04.01');
INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (2,'Klein','Sabine','2002.05.10');
INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (3,'Lang','Peter','2001.03.11');
INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (4,'Berg','Frank','2002.07.20');
INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (5,'Erde','Sabine','2001.01.23');
INSERT INTO auszubildender (ausid,name,vorname,geburtsdatum)
VALUES (6,'Grün','Justus','2001.04.15');

INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (1,'Energieelektroniker');
INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (2,'Mechatroniker');
INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (3,'Buchhalter');
INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (4,'Industriekaufmann');
INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (5,'Schlosser');
INSERT INTO ausbildungsberuf (berufsid,berufsbezeichnung)
VALUES (6,'Elektriker');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (1,'Mathematik');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (2,'Buchhaltung 1');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (3,'Buchhaltung 2');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (4,'Mechanik Grundlagen 1');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (5,'Mechanik Grundlagen 2');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (6,'Englisch');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (7,'Elektronik Grundlagen 1');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (8,'Elektronik Grundlagen 2');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (9,'Rechnungsbearbeitung 1');
INSERT INTO lehrfach (lehrfachid,lehrfach)
VALUES (10,'Rechnungsbearbeitung 2');

INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (1,'Mondstraße','8',50827,'Köln',1);
INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (2,'Sternstraße','10',50127,'Bonn',3);
INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (3,'Sonnenstraße','1',50129,'Bonn',5);
/*Ohne Zuordnung zu Auszubildenden*/
INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (4,'Jupiterstraße','11',50827,'Köln',NULL);
INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (5,'Uranusstraße','9',50127,'Bonn',NULL);
INSERT INTO adresse (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (6,'Marsstraße','9',50129,'Bonn',NULL);

INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (1,'2015.06.01',5,2);
INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (2,'2015.06.01',4,4);
INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (3,'2015.06.01',1,3);
INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (4,'2015.06.01',3,1);
INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (5,'2015.06.01',6,1);
INSERT INTO ausbildungsvertrag (vid,vertragsdatum,fk_ausid,fk_berufsid)
VALUES (6,'2015.06.01',2,5);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (1,1);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (1,6);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (1,7);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (1,8);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (4,2);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (4,3);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (4,6);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (4,9);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (6,1);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (6,4);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (6,7);
INSERT INTO beruflehrfach (fk_berufsid,fk_lehrfachid)
VALUES (6,8);

INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (1,'Müller','Alfred',NULL);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (2,'Ungern','Peter',1);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (3,'Erdenschein','Claudia',1);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (4,'Sternenschein','Ute',1);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (5,'Augustus','Frank',1);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (6,'Erdenfels','Christine',NULL);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (7,'Hoffnung','Ralf',6);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (8,'Freud','Erika',6);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (9,'Bergfels','Diether',6);
INSERT INTO mitarbeiterausbildungsbetrieb (mitarbeiterid,name,vorname,
fk_mitarbeiterid)
VALUES (10,'Lemon','Reinhold',6);

-- 10.1.8 Übungen
-- Übung 1
insert into verlag values (1,'Rheinwerk Verlag');
insert into verlag values (2,'Elektro Verlag');
insert into verlag values (3,'Mechanik Verlag');
insert into verlag values (1+3,'Kaufmann Verlag'); -- 1+3 wird als 4 anerkannt
insert into verlag values (5,'Medien Verlag');

select * from verlag;

insert into fachbereich values (1, 'Elektrotechnik');
insert into fachbereich values (2, 'Kaufmann');
insert into fachbereich values (3, 'Mechanik');
insert into fachbereich values (4, 'Pneumatik');

-- Übung 2
insert into fachbuch values (1,1235,'Mechanik',3);
insert into fachbuch values (2,9878,'Elektrotechnik',2);
insert into fachbuch values (3,2323,'Elektronik',2);
insert into fachbuch values (4,2254,'Pneumatik',3);
insert into fachbuch values (5,4455,'Mathematik Grundlagen 1',2);
insert into fachbuch values (6,4456,'Mathematik Grundlagen 2',2);
insert into fachbuch values (7,5566,'Mengenlehre',null);
insert into fachbuch values (8,7766,'Kommunikation 1',null);
insert into fachbuch values (9,7767,'Kommunikation 2',null);

select * from fachbuch;

-- Übung 3
insert into fachbereichfachbuch values (3,1);
insert into fachbereichfachbuch values (1,3);
insert into fachbereichfachbuch values (4,4);
insert into fachbereichfachbuch values (1,5);
insert into fachbereichfachbuch values (1,6);
insert into fachbereichfachbuch values (1,7);
insert into fachbereichfachbuch values (2,8);
insert into fachbereichfachbuch values (2,9);


-- 10.2 Zeilen aus Tabellen, die in Beziehung stehen, mit JOIN verbunden abfragen
-- Zeigt was JOINS sind

-- 10.2.1 Zeilen mit einem INNER JOIN verbinden -- nur die Werte aus zwei Tabellen, die durch Schlüssel verbunden
select name,vorname,plz,ort from auszubildender inner join adresse on ausid=fk_ausid;
-- Aufbau select * from table1 inner join table2 on primary_key_table1=foreign_key_table2
-- Alternative:
select name,vorname,plz,ort from auszubildender join adresse on ausid=fk_ausid;

-- 10.2.2 Zeilen mit einem LEFT OUTER JOIN verbinden
select name,vorname,plz,ort from auszubildender left outer join adresse on ausid=fk_ausid;
-- Alternative:
select name,vorname,plz,ort from auszubildender left join adresse on ausid=fk_ausid;

-- Auszubildende ohne Adresse finden (where hinten anfügen):
select name,vorname,plz,ort from auszubildender left outer join adresse on ausid=fk_ausid where plz is null;


-- 10.2.3 Zeilen mit einem RIGHT OUTER JOIN verbinden
select name,vorname,plz,ort from auszubildender right outer join adresse on ausid=fk_ausid;
-- Alternative:
select name,vorname,plz,ort from auszubildender right join adresse on ausid=fk_ausid;

-- Auszubildende ohne Adresse finden (where hinten anfügen):
select name,vorname,plz,ort from auszubildender right outer join adresse on ausid=fk_ausid where name is null;
-- egal, welche Spalte von der table1 man benutzt in der where-Klausel


-- 10.2.4 Zeilen mit einem FULL OUTER JOIN verbinden

-- Für andere Datenbanken wie PostgreSQL, MS SQL:
-- Alle beide Tabellen werden vereint
-- select name,vorname,plz,ort from auszubildender full outer join adresse on ausid=fk_ausid;
-- damit FULL OUTER JOIN müssen wir in where nur die Werte mit einem null-Wert selektieren:
-- select name,vorname,plz,ort from auszubildender full outer join adresse on ausid=fk_ausid where plz is null or name is null;

-- full outer join nicht möglich bei MySQL, MariaDB. UNION benutzen, siehe:
-- 10.2.5 Einen FULL OUTER JOIN unter MySQL oder MariaDB nachbilden
select name,vorname,plz,ort from auszubildender left outer join adresse on ausid=fk_ausid
union
select name,vorname,plz,ort from auszubildender right outer join adresse on ausid=fk_ausid;

-- integrating WHERE to get exclusive or:
select name,vorname,plz,ort from auszubildender left outer join adresse on ausid=fk_ausid where plz is null
union
select name,vorname,plz,ort from auszubildender right outer join adresse on ausid=fk_ausid where name is null;

-- 10.2.6 Zeilen mit einem CROSS JOIN verbinden -- alle Werte aus table1 mit allen Werten aus table2 verbunden
-- (kartesisches Produkt)
select name,vorname,plz,ort,strasse from auszubildender cross join adresse;
-- keine Null-Werte in Ergebnistabelle, da 2 Zeilen aus den 2 tables einfach immer zu einer einzigen zusammengefügt, egal,
-- ob die Information stimmt oder nicht


-- 10.2.7 Zeilen von drei Tabellen mit einem INNER JOIN verbinden
-- macht bei einer m:n-Beziehung, die mit 3 tables abgebildet ist, Sinn
select berufsbezeichnung,lehrfach from ausbildungsberuf
inner join beruflehrfach on berufsid=fk_berufsid
inner join lehrfach on fk_lehrfachid=lehrfachid;
-- select * from table1 
-- inner join table2 on pk_table1=fk_table2
-- inner join table3 on fk_table2=pk_table3

-- auch mehr als 3 tables möglich


-- 10.2.8 Spalten in einem JOIN über Tabellennamen referenzieren
-- Join für Tabellen mit gleichen Spaltennamen. Für SQL unklar, welche Spalten aus, welcher Tabelle gemeint. Lösung:

-- einfache table für Beispiel anlegen:
CREATE TABLE sportag (
teilnehmerid SMALLINT PRIMARY KEY NOT NULL,
name VARCHAR(120),
vorname VARCHAR(120),
fk_ausid SMALLINT,
CONSTRAINT fk_ausid_auszubildender
FOREIGN KEY (fk_ausid)
REFERENCES auszubildender (ausid)
);

INSERT INTO sportag (teilnehmerid,name,vorname,fk_ausid)
VALUES (1,'Müller','Ralf',1);
INSERT INTO sportag (teilnehmerid,name,vorname,fk_ausid)
VALUES (2,'Klein','Sabine',2);

-- Lösung Problem gleicher Spaltennamen:
select auszubildender.name, sportag.vorname from auszubildender inner join sportag on auszubildender.ausid=sportag.fk_ausid;

-- Meine Entdeckung: wenn man einfach alle Spaltenwerte zweier Tabellen möchte, reicht:
select * from auszubildender inner join sportag on ausid=fk_ausid;

-- 10.2.9 Spalten in einem JOIN über Tabellenaliasse referenzieren
-- Aliasse als abgekürzte Tabellennamen, um Zeit zu sparen:
select a.name, s.vorname from auszubildender a inner join sportag s on a.ausid=s.fk_ausid;

-- Spalten verschiedener Tabellen zur Unterscheidung in der Ausgabe Namen geben:
select a.name as aus_name, s.name as spag_name from auszubildender a inner join sportag s on a.ausid=s.fk_ausid;

-- 10.2.10 Zeilen mit einem Self Join verbinden
-- In diesem Fall Aliasse nötig:
select ma1.name as vorgesetzter_name, ma2.name as mitarbeiter_name from mitarbeiterausbildungsbetrieb ma1 inner join
mitarbeiterausbildungsbetrieb ma2 on ma1.mitarbeiterid=ma2.fk_mitarbeiterid;
-- ma1 bezieht sich auf Primärschlüssel und bringt Vorgesetzte ins Spiel; ma2 bezieht sich auf Fremdschlüssel und gibt
-- die Mitarbeiter an, die als Fremdschlüssel den Vorgesetzten aus ma1 haben

-- 10.2.11 Zeilen mit einem INNER JOIN ohne Schlüsselvergleich verbinden
-- Tabellen ohne Fremdschlüssel verbinden. Möglich durch Vergleich in der on-Klausel zweier Spalten mit gleichen 
-- (konvertierbarem) Datentyp
select a.name, s.teilnehmerid from auszubildender a inner join sportag s on a.name=s.name;
-- funktioniert mit allen JOIN-Arten (inner, left/right/full outer, cross, Self)!

-- 10.2.12 Übungen
-- Übung 1
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch inner join verlag on fk_verlagid=verlagid;

-- Übung 2
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch left join verlag on fk_verlagid=verlagid;

-- Übung 3
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch right join verlag on fk_verlagid=verlagid;

-- Übung 4
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch left join verlag on fk_verlagid=verlagid
union
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch right join verlag on fk_verlagid=verlagid;

-- Übung 5
select title,isbn,fk_verlagid,verlag,verlagid from fachbuch cross join verlag;

-- Übung 6
select title,fachbereich from fachbuch 
inner join fachbereichfachbuch on fachbuchid=fk_fachbuchid
inner join fachbereich on fk_fachbereichid=fachbereichid;

-- Übung 7
create table ausleihe(
	ausleiheid smallint not null,
    exemplarid smallint not null,
    
    primary key (ausleiheid,exemplarid),
    
    von date not null,
    bis date not null,
    isbn varchar(120) not null,
    titel varchar(300), -- weiße Raute/leere Raute: null-Werte zugelassen
    
    fk_fachbuchid smallint,
    constraint my_cons7 foreign key (fk_fachbuchid) references fachbuch (fachbuchid)
    
);
INSERT INTO ausleihe (ausleiheid,exemplarid,von,bis,isbn,titel,fk_fachbuchid) 
VALUES (1,1,'2015-04-01','2015-05-01','9878','Elektrotechnik',2);
INSERT INTO ausleihe (ausleiheid,exemplarid,von,bis,isbn,titel,fk_fachbuchid)
VALUES (2,3,'2015-05-10','2015-05-20','9878','Elektrotechnik',2);

-- Mit Aliassen:
select f.isbn as buch_isbn, f.title as buch_title, 
a.isbn ausleihe_isbn, -- man kann das 'as' auch einfach weglassen
a.titel as ausleihe_title, a.von as ausleihe_start,
a.bis as ausleihe_ende from fachbuch f inner join ausleihe a on f.fachbuchid=a.fk_fachbuchid;

-- Ohne Aliasse, Lösung Buch:
select fachbuch.isbn, fachbuch.title, ausleihe.isbn, ausleihe.titel, ausleihe.von,
ausleihe.bis from fachbuch inner join ausleihe on fachbuch.fachbuchid=ausleihe.fk_fachbuchid;

-- Übung 8
-- vgl. Übung 7

-- Übung 9
CREATE TABLE fachbereichhierarchie (
fachbereichid SMALLINT PRIMARY KEY,
fachbereich VARCHAR(200),
fk_fachbereich SMALLINT,
CONSTRAINT fk_fachbereich_hierarchie
FOREIGN KEY (fk_fachbereich)
REFERENCES fachbereichhierarchie (fachbereichid)
);

INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (1,'Elektrotechnik',NULL);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (2,'Kommunikationselektronik',1);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (3,'Energieelektronik',1);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (4,'Kaufmann',NULL);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (5,'Industriekaufmann',4);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (6,'Einzelhandelskaufmann',4);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (7,'Mechanik',NULL);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (8,'Industriemechaniker',7);
INSERT INTO fachbereichhierarchie (fachbereichid,fachbereich,fk_fachbereich)
VALUES (9,'Feinmechaniker',7);

select t1.fachbereich as fachbereich_übergeordnet,t2.fachbereich as fachbereich_untergeordnet
from fachbereichhierarchie t1 inner join fachbereichhierarchie t2
on t1.fachbereichid=t2.fk_fachbereich;

-- Übung 10
select f.isbn as isbn_buch, f.title as buch_title, a.von as start_ausleihe, a.bis as end_ausleihe 
from fachbuch f inner join ausleihe a
on f.isbn=a.isbn;


-- 10.3 Beziehungen (Schlüsselbeziehungen) ändern
-- 10.3.1 Beziehungen aus Zeilen aus einer Kindtabelle ändern
-- Verändern des Fremdschlüssels durch einfaches UPDATE, in welchem auf die id der Fremdschlüssel-Tabelle verwiesen:
update adresse set fk_ausid=5 where aid=1;

-- 10.3.2 Beziehungen aus Zeilen einer Elterntabelle ändern (ON UPDATE CASCADE)
-- einfache Elterntabelle erstellen:
create table auszubildender_neu(
	ausid smallint primary key not null,
    name varchar(120),
    vorname varchar(120),
    geburtsdatum date
);

INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (1,'Müller','Ralf','2001.04.01');
INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (2,'Klein','Sabine','2002.05.10');
INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (3,'Lang','Peter','2001.03.11');
INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (4,'Berg','Frank','2002.07.20');
INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (5,'Erde','Sabine','2001.01.23');
INSERT INTO auszubildender_neu (ausid,name,vorname,geburtsdatum)
VALUES (6,'Grün','Justus','2001.04.15');

-- Kindtabelle erstellen, die sich jetzt schon auf Primärschlüsseländerung der Elterntabelle vorbereitet:
create table adresse_neu(
	aid smallint primary key not null,
    strasse varchar(200),
    nr varchar(5),
    plz int,
    ort varchar(200),
    fk_ausid smallint,
    
    constraint fk_adresse_auszubildender_neu foreign key (fk_ausid) references auszubildender_neu (ausid)
    on update cascade -- Primärschlüssel der Elterntabelle kann geändert werden; der Fremdschlüssel dieser Tabelle
    -- wird automatisch angepasst
    on delete cascade -- Gilt Gleiches nur für Löschvorgang einer Zeile in der Elterntabelle
);

INSERT INTO adresse_neu (aid,strasse,nr,plz,ort,fk_ausid) 
VALUES (1,'Mondstraße','8',50827,'Köln',1);
INSERT INTO adresse_neu (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (2,'Sternstraße','10',50127,'Bonn',3);
INSERT INTO adresse_neu (aid,strasse,nr,plz,ort,fk_ausid)
VALUES (3,'Sonnenstraße','1',50129,'Bonn',5);

select * from auszubildender_neu inner join adresse_neu on ausid=fk_ausid;

-- Updaten des Primärschlüssels der Elterntabelle:
UPDATE auszubildender_neu SET ausid=10 WHERE ausid=1;
UPDATE auszubildender_neu SET ausid=30 WHERE ausid=3;
UPDATE auszubildender_neu SET ausid=50 WHERE ausid=5;

select * from auszubildender_neu inner join adresse_neu on ausid=fk_ausid;

-- 10.3.3 Übungen
-- Übung 1 -- Fremdschlüssel updaten
update ausleihe set fk_fachbuchid=3 where fk_fachbuchid=2;
select * from fachbuch inner join ausleihe on fachbuchid=fk_fachbuchid;

-- Übung 2 -- Primärschlüssel updaten
create table ausgemustert(
	exemplarid tinyint primary key not null, 
    isbn varchar(120)
);

create table grund(
	gundid tinyint primary key not null,
    ausmusterungsgrund varchar(3000),
    fk_exemplarid tinyint,
    
    constraint my_cons8 foreign key (fk_exemplarid) references ausgemustert (exemplarid)
    on update cascade

);

insert into ausgemustert values (28,8976);
insert into ausgemustert values (29,8976);
insert into ausgemustert values (5,3456);
insert into ausgemustert values (6,3456);

insert into grund values (1,'beschädigt',28);
insert into grund values (2,'verschmutzt',29);
insert into grund values (3,'veraltet',5);
insert into grund values (4,'veraltet',6);

select * from ausgemustert inner join grund on exemplarid=fk_exemplarid;

update ausgemustert set exemplarid=30 where exemplarid=28;

select * from ausgemustert inner join grund on exemplarid=fk_exemplarid;


-- 10.4 Beziehungen (Schlüsselbeziehungen) aufheben oder löschen
-- 10.4.1 Zeilen aus Kindtabellen auf NULL setzen
update adresse_neu set fk_ausid=null where aid=1;

-- Überprüfung, ob diese Beziehung noch besteht:
select * from auszubildender_neu left join adresse_neu on ausid=fk_ausid;

-- 10.4.2 Zeilen aus Kindtabellen löschen
delete from adresse_neu where aid=2;

select * from adresse_neu;

-- 10.4.3 Zeilen aus Elterntabellen löschen 
-- Möglichkeit 1: Die referenzierenden Zeilen der Kindtabelle vorher löschen
-- Möglichkeit 2: Benutzen von ON DELETE CASACADE bei der Erstellung der Kindtabelle, sodass mit Löschung der
-- Primärschlüsselzeile der Elterntabelle, alle darauf bezogenen Zeilen der Kindtabelle ebenfalls gelöscht: vgl.
-- create table adresse_neu

delete from auszubildender_neu where ausid=50;

-- 10.4.4 Übungen
-- Übung 1 -- Fremdschlüsselwert auf null setzen
update grund set fk_exemplarid=null where fk_exemplarid=30;

select exemplarid,isbn,ausmusterungsgrund from grund inner join ausgemustert where fk_exemplarid=exemplarid;

-- Übung 2 -- Zeile aus Kindtabelle löschen
delete from grund where fk_exemplarid=29;

select exemplarid,isbn,ausmusterungsgrund from grund inner join ausgemustert where fk_exemplarid=exemplarid;

-- Übung 3 -- Zeile aus Elterntabelle löschen
drop table grund;
create table grund(
	grundid tinyint primary key not null,
    ausmusterungsgrund varchar(3000),
    fk_exemplarid tinyint,
    
    constraint my_cons8 foreign key (fk_exemplarid) references ausgemustert (exemplarid)
    on delete cascade

);

INSERT INTO grund (grundid,ausmusterungsgrund,fk_exemplarid)
VALUES (1,'beschädigt',30);
INSERT INTO grund (grundid,ausmusterungsgrund,fk_exemplarid)
VALUES (2,'verschmutzt',29);
INSERT INTO grund (grundid,ausmusterungsgrund,fk_exemplarid)
VALUES (3,'veraltet',5);
INSERT INTO grund (grundid,ausmusterungsgrund,fk_exemplarid)
VALUES (4,'veraltet',6);

select exemplarid,isbn,ausmusterungsgrund from grund inner join ausgemustert where fk_exemplarid=exemplarid;

delete from ausgemustert where exemplarid=30;

select exemplarid,isbn,ausmusterungsgrund from grund inner join ausgemustert where fk_exemplarid=exemplarid;


