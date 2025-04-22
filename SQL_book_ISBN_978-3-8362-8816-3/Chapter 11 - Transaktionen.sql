-- 11.1 Forderungen an relationale Datenbanksysteme
-- (Sequenz von) Operationen sollen trotz Störungen ganz oder gar nicht durchgeführt werden

-- 11.2 Transaktionen verstehen
-- 11.2.1 Allgemeiner Aufbau einer Transaktion
-- 11.2.2 Einen atomaren Datenzustand mit Transaktionen sicherstellen
-- explizite Transaktionsanweisung:
begin;
INSERT INTO kunde_intern VALUES(8,'Logistik');
INSERT INTO kunde_intern VALUES(9,'Entwicklung');
INSERT INTO kunde_intern VALUES(10,'Öffentlichkeitsarbeit');
INSERT INTO kunde_intern VALUES(11,'Innovationszentrum');
commit;

-- MS SQL Server 
-- BEGIN TRANSACTION;
-- COMMIT;

-- 11.2.3 Transaktionen mit ROLLBACK rückgängig machen
BEGIN;
INSERT INTO kunde_intern VALUES(20,'Kost 1');
INSERT INTO kunde_intern VALUES(17,'Kost 2');
INSERT INTO kunde_intern VALUES(18,'Kost 3');
INSERT INTO kunde_intern VALUES(19,'Kost 4');
select * from kunde_intern;

-- Diese Anweisungen, bei denen noch nicht COMMIT ausgeführt, rückgängig machen:
ROLLBACK;
select * from kunde_intern;

-- 11.2.4 Operationen mit Transaktionen isoliert ausführen
-- Vorstellung Isolationsstufen je nach Datenbanksystem, B.S. 412f


-- 11.3 Übungen
-- Übung 1
-- ACID = Atomar Consistency Isolated Duration

-- Übung 2
-- Er wird eingehüllt von BEGIN; (Start) und COMMIT; (Ende)

-- Übung 3
-- ROLLBACK;

-- Übung 4
-- Read (un-)commited, Repeatable read, Serializable












