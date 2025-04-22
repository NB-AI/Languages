-- 6.1 Benutzer anlegen (CREATE USER)
-- 6.1.1 Nutzer in einer MySQL- oder MariaDB-Datenbank anlegen
create user hans identified by 'secret';

-- 6.1.2 Nutzer in einer PostgreSQL-Datenbank anlegen
-- CREATE USER hans PASSWORD 'secret';

-- 6.1.3 Nutzer in einer MS SQL Server-Datenbank anlegen
-- CREATE LOGIN hans WITH PASSWORD = 'secret'; -- Login anlegen
-- CREATE USER hans FOR LOGIN hans; -- Benutzer anlegen


-- 6.2 Benutzer entfernen
DROP USER hans; -- für MySQL, MariaDB, PostgreSQL

-- für MS SQL Server-Datenbank:
-- DROP LOGIN hans;
-- DROP USER hans;

-- 6.3 Eine Verbindung für einen Datenbankbenutzer erstellen
-- für ihn Verbindung erstellen:

-- 6.3.1 Verbindung für MySQL-Datenbank einrichten
create user hans identified by 'secret';
-- Vgl. Buch S. 256 f.

-- 6.3.2 Verbindung für eine MariaDB-Datenbank herstellen
-- Vgl. Buch S. 257 f.

-- 6.3.3 Verbindung für eine PostgreSQL-Datenbank herstellen
-- Vgl. B.S. 258-261

-- 6.3.4 Verbindung für eine MS SQL Server-Datenbank herstellen
-- Vgl. B.S. 261


-- 6.4 Berechtigungen verwalten
-- 6.4.1 Berechtigungen vergeben (GRANT)
grant select,update on mitarbeiter to hans; -- table 'mitarbeiter'

-- MySQL, MariaDB. User die Tabelle nutzen lassen:
-- use uebungsdatenbank;
-- select * from mitarbeiter;

-- 6.4.2 Berechtigungen entziehen (REVOKE)
revoke select,update on mitarbeiter from hans;


-- 6.5 Mit Rollen Berechtigungen zuordnen
-- Um nicht jeden Nutzer für jede table einzeln machen zu müssen -> Rollen
-- 6.5.1 Rollen anlegen (CREATE ROLE)
create role personal; -- Die Rolle scheint eine Art MySQL-User zu sein

-- 6.5.2 Rollen mit Berechtigungen ausstatten
-- Genauso wie die Zuweisung für User:
grant select,insert,update on abteilung to personal;

-- 6.5.3 Rollen Datenbanknutzern zuordnen
GRANT personal TO hans; -- MySQL, MariaDB, PostgreSQL
-- ALTER ROLE personal ADD MEMBER hans; -- MS SQL Server

-- für Userskript gilt:
-- set role 'personal'; -- nötig bei MySQL, MariaDB
-- use uebungsdatenbank; -- nötig bei MySQL, MariaDB
-- bevor mit Datenbank gearbeitet

-- 6.5.4 Rollen Berechtigungen entziehen
revoke select,insert,update on abteilung from personal;

-- 6.5.5 Rollen entfernen
-- MS SQL: Erst Entfernen aller Mitglieder, hier erst mal hans:
-- EXEC sp_droprolemember 'personal', 'hans';
drop role personal;


-- 6.6 Übungen
-- Übung 1
create user thomas identified by 'secret';

-- Übung 2
grant select,update,insert on artikel to thomas;
-- bei Verbindung thomas:
-- use uebungsdatenbank;
-- select * from artikel;

-- Übung 3
revoke select,update,insert on artikel from thomas;

-- Übung 4
drop user thomas;

-- Übung 5
create role vertrieb;
grant select,insert,update on artikel to vertrieb;

create user frank; -- auch ohne Passwort Nutzer erstellbar
create user ralf;

grant vertrieb to frank;
grant vertrieb to ralf;

-- Für Nutzerskripts:
-- set role 'vertrieb';
-- use uebungsdatenbank;
-- select * from artikel;

-- Übung 6
revoke insert,update on artikel from vertrieb;

-- Übung 7
-- PostgreSQL, zuerst müssen alle Berechtigungen der Rolle gelöscht werden:
-- revoke select on artikel from vertrieb;
drop role vertrieb;

drop user frank;
drop user ralf;

-- Weitere User-Verwaltung-Anmerkungen:
-- Getting all MySQL users and roles:
SELECT User, Host FROM mysql.user;
-- Shwoing grant for a user in MySQL:
SHOW GRANTS FOR 'user'@'host';
-- Nutzer Admin-Rechte für überall geben:
GRANT CREATE ROLE  ON *.* TO 'sql_side_user1'@'localhost' WITH GRANT OPTION;
-- Then restart MySQL Workbench

-- Getting current user:
select session_user(); -- put SELECT in front of it!

