-- 13.1 Spaltenwerte addieren / 13.2 Spaltenwerte subtrahieren / 13.3 Spaltenwerte multiplizieren / 
-- 13.4 Spaltenwerte dividieren / 13.5 Spaltenwerte modulieren
select bonus+monatslohn+3 from mitarbeiter;
select 3+4; -- keine table nötig!

-- Auch in update + insert möglich!

-- 13.6 Nach dem Ergebnis einer Rechnung filtern -- where
select stundenlohn*stundenpromonat from mitarbeiter where stundenlohn*stundenpromonat<monatslohn;

-- 13.7 Nach dem Ergebnis einer Berechnung sortieren lassen -- order by
select bonus-monatslohn from mitarbeiter order by bonus-monatslohn;
-- Aliastrick:
select bonus-monatslohn as a from mitarbeiter order by a;

-- 13.8 Übungen
-- Übung 1
select jahr,q1,q2,q3,q4, q1+q2+q3+q4 as summequartale from umsatzausgaben;

-- Übung 2
select invest-personal as differenz,jahr from umsatzausgaben;

-- Übung 3
select jahr,q1,q2,q3,q4, q1+q2+q3+q4-miete-nebkosten-personal-invest as gewinn from umsatzausgaben;

-- Übung 4
select (miete+nebkosten+personal+invest)*10 as nebenkosten10jahre from umsatzausgaben where jahr=2003;

-- Übung 5
select (miete+nebkosten+personal+invest)/4 as kostenquartal from umsatzausgaben;

-- Übung 6
select (miete+nebkosten+personal+invest)/4 as kostenquartal from umsatzausgaben order by (miete+nebkosten+personal+invest)/4 desc;
-- Neater:
select (miete+nebkosten+personal+invest)/4 as kostenquartal from umsatzausgaben order by kostenquartal desc;

