* Exercise 3 - Transposing and Merging;

libname HYDRO "/shared/home/path/casuser/hydro";
libname LV "/shared/home/path/casuser/LV_Data";
run;


*** 3.1;
* run Create_Dogs_Long.sas first;

proc transpose data=work.dogs_long out=work.dogs_wide(drop=_name_) prefix=Histamine_;
 by DogID; * appears once in rows the row key;
 id Measurement; * is the time component, one DogID has several
 measurment values;
 var Histamine; * The column names 'Histamine_' gives the hint
 that Histamine variable is needed to be the cell content 
 related to each DogID in time Measurement;
run;

*** 3.2;
* first run all the create hydro sas files and then
the merging file from last session of 26-04-23, as
it creates the hydro_daily_xt file.;

* According to instruction the hydro_daily_xt shall be in hydro library. Let's
place it there:;
data hydro.hydro_daily_xt;
set lv.hydro_daily_xt;
run; 

proc sql;
create table hydro.hydro_daily_xt
as
select a.*, b.Messgroesse, b.Einheit
from hydro.hydro_daily_xt as a
left join work.dim_messung as b
on a.MessID=b.MessID
;
quit;


data hydro.hydro_daily_xt;
set hydro.hydro_daily_xt;

Messgroesse_Label = catt(upcase(Messgroesse), " (", kcompress(Einheit), ")");
* kcompress removes leading and following empty
spaces and because of the k is MBCS-aware
(multibyte character set);
run;


*** 3.3;
** Step 1;

data 
work.neusiedl(keep=Datum Wert_AVG) 
work.podersdorf(keep=Datum Wert_AVG)
work.breitenbrunn(keep=Datum Wert_AVG)
; *** erzeuge neue Datasets;
set hydro.hydro_daily_xt(where=(upcase(MessID)="W")) ; *** verwende ein bestehendes Dataset;
IF (upcase(Messstelle)="NEUSIEDL") THEN OUTPUT work.neusiedl;
ELSE IF (upcase(Messstelle)="PODERSDORF") THEN OUTPUT work.podersdorf;
ELSE IF (upcase(Messstelle)="BREITENBRUNN") THEN OUTPUT work.breitenbrunn;
run;


** Step 2;
data work.WATER_PNB;
  set work.neusiedl
      work.podersdorf
      work.breitenbrunn
  indsname = datasetname;
SourceDataset = datasetname;
Messstelle = scan(SourceDataset, 2, '.'); * take the 2. part when splitting by '.';
YEAR = year(Datum);
drop SourceDataset;
run;
