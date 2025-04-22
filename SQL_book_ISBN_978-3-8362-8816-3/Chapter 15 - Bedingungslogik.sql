-- Wie if-Clause

-- 15.1 Die CASE-Klausel
-- 15.2 Bedingungslogik in einer Spaltenauswahlliste einer SELECT-Anweisung anwenden
select case when austrittsdatum is null then 'aktiver Mitarbeiter' else 'ausgeschieden' end,austrittsdatum from mitarbeiter;

-- 15.3 Bedingungslogik in einer ORDER BY-Klausel anwenden
-- Sortieren bestimmer Spaltenwerte
select austrittsgrund from mitarbeiter 
where austrittsgrund is not null
order by case 
when austrittsgrund='ruhestand' then 0
else 1 end;

-- 15.4 Übungen
-- Übung 1
select quartal,umsatz,case when umsatz<6000000 then 'rot' when umsatz<9000000 then 'gelb' when umsatz<12000000 then 'green' end as statusumsatz from umsatz;

-- Übung 2
select case when geschlecht='w' then 'Frau' else 'Herr' end as anrede, name,vorname from mitarbeiter;