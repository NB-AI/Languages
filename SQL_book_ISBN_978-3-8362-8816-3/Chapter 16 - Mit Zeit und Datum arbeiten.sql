-- 24 Zeitzonen festgelegt im Wertebereich +/- 12 als UTC. London Greenwhich als Zentrum 0 der Zeit, daher GMT, 
-- wenn von Zeitzonen die Rede

-- 16.1 Datumsformate

-- 16.2 Skalarfunktion für Zeit- und Datumsangaben in SQL benutzen
-- SQL-Standard:
select current_date; -- nach ISO 8601
select current_time;
select current_timestamp; -- out: current_date current_time -- MS SQL lässt nur diese zu -- z. B. Zeitpunkt einer 
-- Tabellen SELECT-Abfrage angeben

-- 16.2.1 Datum, Zeit und Zeitstempel vom Datenbankserver ermitteln lassen
-- 16.2.2 Ergebnislisten mit einem Berichtsdatum verstehen
-- 16.2.3 Übungen
-- Übung 1
-- ISO 8601

-- Übung 2
select name,vorname,urlaubstage,urlaubgenommen, current_timestamp as datumstandurlaub from mitarbeiter;


-- 16.3 Zeit- und Datumsangaben formatieren
-- 16.3.1 Datumsformatierungen unter MySQL und MariaDB (DATE_FORMAT)
-- DATE_FORMAT(datum,format)
-- format: Muster/Formate/Abkürzungen, B.S. 494ff, daraus folgt z. B.:
select date_format(current_timestamp, '%d.%M-%Y') as reportdatum;
-- Auch mit Spaltenwerten:
select date_format(gebdatum, '%d.%m.%y') from mitarbeiter;

-- Englische Monatsangaben von '%M' ins Deutsche übersetzen:
-- Umgebungsvariable auf deutsch stellen:
set lc_time_names=de_DE; -- de: deutsche Sprache; DE: nach deutscher Konvention

-- 16.3.2 Datumsformatierung unter PostgreSQL (TO_CHAR)
-- to_char(date,format)
-- fromat: B.S. 499f
-- select to_char(current_timestamp,'DD.MM-YYYY');
-- Month shall be a german word:
-- set LC_TIME=German_Germany; -- German: deutsch, Germany: nach deutschem Gebrauch -- LC=local
-- select to_char(gebdatum,'DD. TMMonth YYYY');

-- 16.3.3 Datumsformatierung unter MS SQL Server (FORMAT)
-- FORMAT(wert,format) or FORMAT(wert,format,Sprache_Land_e.g.de_DE)
-- format: B.S. 503f
-- select format(current_timestamp,'dd.MM.yyyy');

-- 16.3.4 Übungen
-- Übung 1
select date_format(current_timestamp,'%H:%i:%S');

-- Übung 2
set lc_time_names=de_DE;
select name,vorname,date_format(gebdatum,'%d. %M %Y'),date_format(eintrittsdatum,'%d.%m.%y') from mitarbeiter;


-- 16.4 Datumsangaben extrahieren (EXTRACT)
-- MySQL, MariaDB, PostgreSQL:
-- EXTRACT(teile_datum from datum) -- teile_datum: B.S. 508f
select extract(year from gebdatum) from mitarbeiter;

-- MS SQL:
-- DATEPART(teile_datum, datum) -- teile_datum: B.S. 511f
-- select datepart(year,gebdatum) from mitarbeiter;


-- 16.4.1 Übungen
-- Übung 1
select name,vorname,extract(year from austrittsdatum) from mitarbeiter; -- auch null-Werte dabei

-- Übung 2
select extract(month from auszahlungsdatum),mitarbeiterid,bonuszahlung from bonus;


-- 16.5 Mit Datumsangaben rechnen
-- 16.5.1 Mit Datumswerten rechnen unter MySQL und MariaDB
-- Datum + Intervall:
select date_add('2021-03-01', INTERVAL 10 DAY); -- DAY: Datumseinheit, B.S. 515
-- Datum - Intervall:
select date_sub('2021-03-01', INTERVAL 10 HOUR); -- Datum geht von Punkt 24 Uhr aus

-- 16.5.2 Mit Datumswerten rechnen unter PostgreSQL
-- select date 'jahr-monat-tag' + interval 'x datumseinheit' -- oder mit - -- datumseinheit: B.S. 516
-- e.g.: select date '2021-04-13' + interval '10 DAY';

-- 16.5.3 Mit Datumswerten rechnen unter MS SQL
-- Addieren:
-- select dateadd(datumseinheit,zahl,datum) -- datumseinheit: B.S. 518
-- Subtrahieren:
-- select dateadd(datumseinheit,-zahl,datum)

-- e.g. select dateadd(day,10,'2021-03-01T00:00:00.000'); -- T: Time, eine Zeitangabe folgt nun


-- 16.5.4 Übungen
-- Übung 1
select date_add('2021-04-01', interval 10 month);
-- Datumsangabe geht auch mit Punkten:
select date_add('2021.04.01', interval 10 month);

-- Übung 2
select date_sub('2021-04-01', interval 10 month);

 
