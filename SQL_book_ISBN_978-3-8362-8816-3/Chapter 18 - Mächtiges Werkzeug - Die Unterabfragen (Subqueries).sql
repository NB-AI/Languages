-- Verwendbar in SELECT, UPDATE, INSERT, DELETE


-- 18.1 Unterabfragen, die in Korrelation zueinander stehen
-- Aus zwei verschiedenen tables gleichzeitig Informationen abfragen via verbindende Spalte 'mitarbeiterid':
select m.mitarbeiterid,m.name,m.vorname,m.bonus from mitarbeiter m
where m.bonus>(select max(bonuszahlung) from bonus b where m.mitarbeiterid=b.mitarbeiterid group by mitarbeiterid);
-- innerhalb der 2. select-Anweisung nicht immer nötig, table_kürzel. ('b.') zu benutzen
-- da 'm.bonus>?', muss '?' ein einziger Wert sein

select (select anrede from anrede where mitarbeiter.geschlecht=anrede.geschlecht) as anrede,vorname from mitarbeiter;
-- Auch hier werden table-name nur in WHERE gebraucht
-- Alternative: INNER JOIN

-- 18.1.1 Übungen
-- Übung 1
select name,vorname,
(select count(s.mitarbeiterid) from sachpraemie s 
where s.mitarbeiterid=m.mitarbeiterid
group by mitarbeiterid having count(s.mitarbeiterid)>0) as Anzahl_Prämien
from mitarbeiter m
having Anzahl_Prämien is not null -- Ein Alias auch nutzbar wie eine AGGREGAT-Funktion! 
-- Nicht nutzbar in WHERE, da WHERE nur auf bereits bestehende table-Zeilen aufbaut
-- Hier: wir möchten nicht die ganzen NULL-Werte Mitarbeiter, die in der Tabelle 'praemie' nicht vorkamen
-- Alternative: EXISTS
order by Anzahl_Prämien; 

-- Alternative: B.S. 551f

-- Übung 2
select name,vorname,
(select sum(preis) from sachpraemie s where s.mitarbeiterid=m.mitarbeiterid group by mitarbeiterid) as Prämienpreis
from mitarbeiter m
having Prämienpreis is not null
order by Prämienpreis;


-- 18.2 Unterabfragen, die nicht in Korrelation zueinander stehen
-- Das Resultat von Abfrage A wird in Abfrage B innerhalb von A weiter ausgewertet. B wird nur einmal aufgerufen!

-- Erhalt aller Mitarbeiter, die einen Bonus erhalten haben:
select name,vorname from mitarbeiter 
where mitarbeiterid in (select mitarbeiterid from bonus group by mitarbeiterid);
-- (In Übung 1 ein paar Zeilen drüber wurden die nicht enthaltenen Mitarbeiter erst in HAVING augefiltert)

-- Tabelle mit einem Teil einer anderen Tabelle vergleichen:
-- Maximaler Bonus von jedem Mitarbeiter:
select m.name,b.max_bonus from mitarbeiter m -- alias auch hier verwendbar
inner join 
(select mitarbeiterid,max(bonuszahlung) as max_bonus from bonus group by mitarbeiterid) b -- gibt uns eine table
-- 'mitarbeiterid' wird in der finalen table nicht ausgegeben, aber wird im ON gebraucht
on m.mitarbeiterid=b.mitarbeiterid;

-- 18.2.1 Übungen
-- Übung 1
select name, vorname
from mitarbeiter 
where
mitarbeiterid in (select mitarbeiterid from sachpraemie group by mitarbeiterid);

-- Übung 2
select m.name,m.vorname,s.boni
from mitarbeiter m
inner join
(select sum(preis) as boni,mitarbeiterid from sachpraemie group by mitarbeiterid) s
where s.mitarbeiterid=m.mitarbeiterid;

-- 18.3 Vergleichsoperatoren auf Unterabfragen mit ANY, SOME und ALL anwenden
-- where spalte1/wert (=/!=/</>/<=/>=) (ANY/SOME/ALL)/IN/NOT IN(which is <>) (Unterabfrage, eine Spalte mit mind. 1 Wert)
-- SOME=ANY
-- a <> ALL b: not all, a nicht in b enthalten

-- 18.3.1 Übungen
-- Übung 1
-- Um zu schauen, ob ein Wert spalte1 = ein Wert spalte2

-- Übung 2
-- Es gibt keinen

-- Übung 3
-- Um Spalten auf ihre absolute Gleichheit zu prüfen

-- Übung 4
select name from mitarbeiter where steuerklasse not in (select steuerklassezahl from steuerklasse);
-- Alternative:
select name from mitarbeiter where steuerklasse <> all (select steuerklassezahl from steuerklasse);


-- 18.4 Auf die Existenz von Ergebniszeilen aus Unterabfragen prüfen (EXISTS)
-- Prüfen, ob zeile_einer_unterabfrage existent:
-- WHERE EXISTS (zeile_einer_unterabfrage)
-- EXISTS prüft auf NULL oder nicht NULL

-- Nur Angabe von Mitarbeitern, die in Unterabfrage existent:
select name from mitarbeiter m 
where exists (select mitarbeiterid from bonus b where b.mitarbeiterid=m.mitarbeiterid);

-- Mitarbeiter, die nie in Unterabfrage-Tabelle vorkommen:
-- Mitarbeiter ohne Bonus:
select name from mitarbeiter m 
where 
not -- new
exists (select mitarbeiterid from bonus b where b.mitarbeiterid=m.mitarbeiterid);

-- 18.4.1 Übungen
-- Übung 1
-- Prüfung auf null oder nicht null

-- Übung 2
-- Genau wie 18.3.1 Übung 4 mit neuer Methode
select name from mitarbeiter m where not exists 
(select steuerklassezahl from steuerklasse s where m.steuerklasse=s.steuerklassezahl);
