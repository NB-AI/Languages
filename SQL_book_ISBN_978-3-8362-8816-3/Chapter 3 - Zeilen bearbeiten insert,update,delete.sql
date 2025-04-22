select * from qualifikationen;

-- Einfügung mit expliziter Spaltenangabe:
insert into qualifikationen (qid,bezeichnung,kuerzel,kategorie) values (1,'Word','msw','Office');
-- Reihenfolge der Spaltennamen unwichtig:
insert into qualifikationen (bezeichnung,kuerzel,kategorie,qid) values ('Word','msw','Office',2);

-- Nicht alle Spalten müssen ausgefüllt werden:
insert into qualifikationen (qid,bezeichnung) values (3,'Outlook');
-- Alternative, null beim Namen nennen:
insert into qualifikationen (qid,bezeichnung,kuerzel,kategorie) values (4,'Ms project', NULL,NULL);

-- Wenn man für alle Spalten Werte einträgt, kann man Auflistung der Spaltennamen
-- (qid,bezeichnung,kuerzel,kategorie) auch weglassen:
insert into qualifikationen values (5, 'Excel',NULL, 'table');
-- Dafür nötig, herauszufinden, in welcher Reihenfolge sich die Spalten befinden:
select 
	table_name,column_name,ordinal_position 
from 
	information_schema.columns 
where 
	table_name='qualifikationen' 
order by 
	ordinal_position;

-- Wir können Zeile auch bei Index plazieren, der weitaus höher ist, als der letztplatzierte (meine Entdeckung):
insert into qualifikationen (qid,bezeichnung,kuerzel,kategorie) values (11,'Ms project', null,NULL);

-- 3.1.3 Übungen
-- Übung 1
insert into qualifikationen (qid,bezeichnung,kuerzel,kategorie) values (6, 'SQL', 'ITE', 'Informatik');

-- Übung 2
insert into qualifikationen (bezeichnung,qid,kategorie,kuerzel) values ('Administrator',7,'Support','ADA');

-- Übung 3
insert into qualifikationen (qid,bezeichnung) values (8,'Catering');
-- We observe nan values for columns where no value filled insert

-- Übung 4
insert into qualifikationen (qid,bezeichnung,kuerzel,kategorie) values (12,'Projektleitung',null,null);

-- Übung 5
insert into qualifikationen values (13,'Personalverwaltung','PEV','Personal');

-- Have a look what inserting changed in the table:
select qid,bezeichnung,kuerzel,kategorie from qualifikationen;


-- 3.2 Zeilen mit einer UPDATE-Anweisung ändern

UPDATE qualglobal SET kuerzel='SQL' where kuerzel='DAT';
-- Überprüfung, ob es funktioniert hat:
select * from qualglobal where kuerzel='SQL';

-- Zwei Spaltenwerte auf einmal anpassen mit nur einer bereits vollzogenen Änderung:
update qualglobal set kuerzel='SAP', kategorie='Informatik' where kuerzel='SHD';


-- 3.2.4 Alle Spaltenwerte zu einem Wert ändern
update qualglobal set kategorie='Derzeit keine Kategorie';
update qualglobal set kategorie='geänderter Wert';
update qualglobal set kategorie=null;

-- 3.2.6 Schlüsselwertspalten mit UPDATE neuen Wert zuweisen
update qualglobal set qid=100 where qid=5;

-- 3.2.7 Übungen
-- Übung 1
update qualglobal set bezeichnung='Second Level Helpdesk' where qid=2;
select qid,bezeichnung from qualglobal where qid=2;

-- Übung 2
update qualglobal set bezeichnung='First Level Helpdesk', kuerzel='FLS' where qid=3;
select * from qualglobal where qid=3;

-- Übung 3
update qualglobal set kuerzel=null where kuerzel='MSO';
select kuerzel from qualglobal where kuerzel=null;
-- Lösung:
select kuerzel from qualglobal where kuerzel is null;


-- Übung 4
update qualglobal set kategorie='Wird überarbeitet';
select kategorie from qualglobal;

-- Übung 5
update qualglobal set qid=5 where qid=100;

select * from qualglobal; 


-- 3.3 Zeilen mit einer DELETE Anweisung löschen
-- 3.3.1 Eine Zeile einer Tabelle löschen
select * from qualglobal; 
delete from qualglobal where qid=4;

-- 3.3.2 Mehrere Zeilen einer Tabelle löschen
delete from qualglobal where kuerzel is null;

-- 3.3.3 Alle Zeilen löschen, Spaltennamen bleiben bestehen
delete from qualglobal;

select * from qualglobal; 

-- 3.3.4 Übungen
-- Übung 1
delete from qualglobalarchiv where qid=2;
select qid from qualglobalarchiv;

-- Übung 2
delete from qualglobalarchiv where qid in (5,6,7);
-- Alternative:
delete from qualglobalarchiv where qid=5 or qid=6 or qid=7;
select qid from qualglobalarchiv;

-- Übung 3
delete from qualglobalarchiv;
select * from qualglobalarchiv;


-- 3.4 Alle Zeilen einer Tabelle mit einer TRUNCATE-Anweisung löschen; Spaltennamen bleiben bestehen
-- 3.4.1 Anweisung ausführen
select * from hardwarearchiv;
truncate table hardwarearchiv;

-- 3.4.2 Übungen
-- Übung 1
truncate table hardware;

-- Übung 2
-- Die Daten werden nirgends gesichert, sondern endgültig gelöscht, indem entweder kein Änderungsprotokoll geschrieben wird
-- oder eine neue leere Tabelle angelegt wird. 



