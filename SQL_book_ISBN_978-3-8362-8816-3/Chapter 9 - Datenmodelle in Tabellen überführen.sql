-- 9.1 Die Ausbildungsdatenbank anlegen
-- 9.1.1 Eine neue Datenbank mit UTF-8-Zeichensatz anlegen (MySQL, MariaDB)
create database ausbildungsdatenbank default character set utf8mb4;

-- 9.1.2 Eine neue Datenbank mit UTF-8-Zeichensatz anlegen (PostgrSQL)
-- CREATE DATABASE ausbildungsdatenbank ENCODING 'UTF8';

-- 9.1.3 Eine neue Datenbank mit Unicode-Zeichensatz anlegen (MS SQL Server)
-- CREATE DATABASE ausbildungsdatenbank;

-- 9.1.4 Übung
-- MySQL, MariaDB:
-- create database bibliothek default character set uft8mb4;

-- 9.2 Tabellen mit Beziehungen zu anderen Tabellen erstellen
-- 9.2.1 Die Ausbildungsdatenbank im Modell erfassen -- eine Wiederholung
-- 9.2.2 Tabellen erstellen, die in einer 1:1-Beziehung stehen
-- Zuerst normale table erstellen:
create table auszubildender(
	ausid smallint primary key not null,
    name varchar(120),
    vorname varchar(120),
    geburtsdatum date
);

-- table mit Fremdschlüssel erstellen:
create table ausbildungsvertrag(
	vid smallint primary key not null,
    vertragsdatum date,
    
	fk_ausid smallint,
    constraint fk_auszubildender foreign key (fk_ausid) references auszubildender (ausid), -- create referenced foreign
    -- key auf Tabellenebene
    constraint uq_fk_ausid unique (fk_ausid)
);

-- 9.2.3 Tabellen erstellen, die in einer 1:n-Beziehung stehen
-- Gleiches Prinzip wie Kapitel darüber, nur dass foreign key nicht unique ist!
create table adresse(
	aid smallint primary key not null,
    starsse varchar(200),
    nr varchar(5),
    plz int,
    ort varchar(200),
    
    fk_ausid smallint,
    constraint fk_adresse_auszubildender foreign key (fk_ausid) references auszubildender (ausid)
);

-- Weitere 1:n-Beziehung:
-- create simple table, die 1-Komponente:
create table ausbildungsberuf(
	berufsid smallint primary key not null,
    berufsbezeichnung varchar(200)
);


-- table mit foreign key muss erweitert werden (n-Komponente):
drop table ausbildungsvertrag;
create table ausbildungsvertrag(
	vid smallint primary key not null,
    vertragsdatum date,
    
	fk_ausid smallint,
    constraint fk_auszubildender foreign key (fk_ausid) references auszubildender (ausid), -- create referenced foreign
    -- key auf Tabellenebene
    constraint uq_fk_ausid unique (fk_ausid),
    
    -- ab hier Erweiterung:
    -- Sortierung von constraints und Spaltennamen unwichtig:
    fk_berufsid smallint,
    constraint fk_ausbildungsberuf foreign key (fk_berufsid) references ausbildungsberuf (berufsid) -- fk = foreign key
);

-- 9.2.4 Tabellen erstellen, die in einer m:n-Beziehung stehen
-- bereits vorhandene table 'ausbildungsberuf' als ein Teil der Beziehung.
-- zweiter Teile der Beziehung: einfache table createn:
create table lehrfach(
	lehrfachid smallint primary key not null,
    lehrfach varchar(200)

);

-- Verbindungstabelle mit zwei Fremdschlüsseln und diese als ein zusammengesetzter Primärschlüssel erstellen:
create table beruflehrfach(
	fk_berufsid smallint not null,
    fk_lehrfachid smallint not null,
    
    primary key (fk_berufsid, fk_lehrfachid),
    
    constraint fk_ausbildungsberuf2 foreign key (fk_berufsid) references ausbildungsberuf (berufsid),
    -- constaints müssen immer unterschiedliche Namen haben (MySQL, MariaDB, MS SQL); gilt nicht für PostgreSQL, hier egal
    constraint fk_lehrfach foreign key (fk_lehrfachid) references lehrfach (lehrfachid)
);

-- 9.2.5 Tabellen erstellen, die mit sich selbst in Beziehung stehen
-- 1:n-Beziehung für eine table:
create table mitarbeiterausbildungsbetrieb(
	mitarbeiterid smallint primary key not null,
    
    name varchar(120),
    vorname varchar(120),
    
    fk_mitarbeiterid smallint,
    constraint fk_mitarbeiterausbildungsbetrieb foreign key (fk_mitarbeiterid) 
		references mitarbeiterausbildungsbetrieb (mitarbeiterid)
);


-- 9.3 Übung
create database bibliothek default character set utf8mb4;

-- Tabellen erstellen:
-- Starke Entitäten zuerst:
create table verlag(
	verlagid smallint primary key not null,
    verlag varchar(300)
);

create table fachbereich(
	fachbereichid smallint primary key not null,
    fachbereich varchar(200)
);

-- tables, die nicht nur wegen anderen tables existieren:
create table fachbuch(
	fachbuchid smallint primary key not null,
    isbn varchar(120),
    title varchar(300),
    
    fk_verlagid smallint,
    constraint my_cons1 foreign key (fk_verlagid) references verlag (verlagid)
);

-- tables, die nur aufgrund einer m:n-Beziehung existieren:
create table fachbereichfachbuch(
	fk_fachbereichid smallint,
    fk_fachbuchid smallint,
    
    constraint my_cons2 primary key (fk_fachbereichid,fk_fachbuchid),
    -- alternative:
    -- primary key (fk_fachbereichid,fk_fachbuchid),
    
    constraint my_cons3 foreign key (fk_fachbereichid) references fachbereich (fachbereichid),
    constraint my_cons4 foreign key (fk_fachbuchid) references fachbuch (fachbuchid)
);


-- 9.4 Die referenzielle Integrität verstehen
-- Wie man Primär-/Fremdschlüssel ändern darf und wann nicht
-- Fremdschlüssel kann, wenn bei create table angegeben, auch null-Werte aufweisen







