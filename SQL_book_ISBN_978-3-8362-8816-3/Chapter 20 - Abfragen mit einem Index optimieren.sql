-- Abfragen zeitlich optimieren

-- 20.1 Einführung
-- Indexbeispiel B-Tree-Index
-- Mind. eine Spalte kann mit Index versehen werden, der Primärschlüssel


-- 20.2 Syntax: Index erstellen
create index index_name on table_name (col_name1,col_name2,...); -- mehrfach vorkommende col_values zulässig
-- Wenn Spaltenwerte des Index einzigartig sein müssen:
create unique index index_name on table_name (col_name1,col_name2,...);
-- Dieser kann nur angelegt werden, wenn Spaltenwerte wirklich unique. Überprüfung dieser:
select spalte from table group by spalte having count(spalte)>1; 
-- Wenn leer, dann kann UNIQUE INDEX erstellt werden, doch muss auch noch überprüft werden, ob Index-Spalte in 
-- Orinal-table auch UNQUE angelegt ist


-- 20.3 Eine Tabelle mit vielen Zeilen generieren 
-- Viele Zeilen auf einmal in eine table einfügen:
insert into kreditinstitutneu (bankid,bankleitzahl,bezeichnung,plz,ort)
select -- Subquery/Unterabfrage
	-- TOP 300000 -- MS SQL
    k1.bankid,k1.bankleitzahl,k1.bezeichnung,k1.plz,k1.ort from kreditinstitut k1 cross join kreditinstitut k2
limit 30000; -- MySQL, MariaDB -- Einfügen von 300000 Zeilen
-- FETCH FIRST 300000 ROWS ONLY; -- PostgreSQL


-- 20.4 Einen Index für eine Tabelle anlegen -- schon im Vorkapitel geregelt
-- Wenn SELECT mit WHERE das zweite Mal aufgerufen, so ist es schon im Cache gespeichert, daher wird Ergebnis sofort alter
-- geliefert. Verzicht auf Cache-Nutzung, MySQL, MariaDB:
select sql_no_cache * from kreditinstitutneu where bankleitzahl=37050198;
-- MS SQL, Cache leeren: 
-- DBCC DROPCLEANBUFFERS;


-- 20.5 Einen Index über mehrere Spalten anlegen -- vgl. 20.2
-- SELECT-Abfragen können auf diesen Index zugreifen. 
-- create index  ... (jahr,monat,tag)
-- diesen nutzen: select * from table where jahr=... and monat=... and tag=...;


-- 20.6 Den Index einer Tabelle löschen

-- Anlegen Index erstellt eine Indextabelle. Vor Löschung sicherstellen, dass er in keiner SELECT mehr verwendet. Dann:
-- MySQL, MariaDB, MS SQL:
drop index index_name on table_name;
-- PostgreSQL:
-- drop index index_name;

-- 20.7 Fremdschlüsselspalten indexieren
-- Als Alternative zu CREATE INDEX:
-- Index auf Tabellenebene während CREATE TABLE erstellen (möglich für MySQL, MariaDB, MS SQL; NICHT PostgreSQL):
-- create table table_name(
-- all as always,
-- constraint which defines fk as foreign key (as always),
-- INDEX index_name (fk) -- new create index auf Tabellenebene
-- );
-- Damit klappt die JOIN-Anweisung zwischen zwei Tabellen viel schneller; auch alle WHERE profitieren


-- 20.8 Übungen
-- Übung 1
create index index_arbeitszeit_mitarbeiter on arbeitszeit (mitarbeiterid);

-- Übung 2
create index index_plzort on kreditinstitutneu (ort,plz);
select * from kreditinstitutneu where ort='Berlin' and plz=10789 -- darüber erstellter Index speziell für die table
-- 'kreditinstitutneu' einfach so anwendbar
limit 10; -- reduzieren des Outputs auf 10 Zeilen!

-- Übung 3
drop index index_arbeitszeit_mitarbeiter on arbeitszeit;
drop index index_plzort on kreditinstitutneu;

-- Übung 4
create table bestellpostion(
	position_id integer primary key not null,
    artikelbezeichnung varchar(120),
    menge integer,
    fk_bestellung_id integer,
    constraint my_cons9 foreign key (fk_bestellung_id) references bestellung (bestell_id),
    
    index index_name1 (fk_bestellung_id)
);