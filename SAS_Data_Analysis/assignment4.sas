*** 4.1;

proc corr data=sashelp.cars plots(maxpoints=1000000)=matrix;
  var HORSEPOWER MPG_CITY MPG_HIGHWAY WEIGHT INVOICE;
run;


*** 4.2;

proc sgplot data=sashelp.cars(where=(upcase(Type) ^= "TRUCK" and upcase(Type) ^= "WAGON"));
title 'correlation between horsepower and MPG_highway considering different origins';
scatter x=horsepower y=mpg_highway / group=origin;
run;


*** 4.3;

proc sgplot data=sashelp.cars;
    vbox horsepower / group=type  ;
run;

proc sgplot data=sashelp.cars;
    vbox horsepower / category=type ;
run;
/*
--> gives the same boxplots but with nicer layout design. For group 
type is only provided with help of different colors and legend.
For category the individual types are provided along the x-axis.
*/

proc sgplot data=sashelp.cars;
    hbox horsepower / group=type ;
run;
/*
--> For hbox we get again the same information. Here the boxplots
are horizontal. For vbox we get vertical boxplots.
*/

proc sgplot data=sashelp.cars;
    hbox horsepower / category=type ;
run;

** additional analysis:;
proc sgplot data=sashelp.cars;
    vbox horsepower / category=type group=origin ;
run;
/*
--> It gives more precise information with a look at
different conditions. The boxes are grouped by the single
types. Each type has different boxes for the different 
origins.
*/


*** 4.4;

libname hydro "/shared/home/k11923286@students.jku.at/casuser/hydro";
run;

proc sort data=hydro.hydro_daily_xt out=work.hydro_daily_sort;
  by datum;
run;

* compute mean:;
proc means data=work.hydro_daily_sort mean maxdec=2;  
   where upcase(messid)="T";   
   format datum month.;
   var wert_max;
   output out=table_mean mean= / autoname;
   class datum;
run;

* visualize:;
title 'Monthly averaged maximal daily temperatures - several years aggregated';
proc sgplot data=work.table_mean;
   vbar datum / response=wert_max_mean;
   xaxis label='Month';
   yaxis label='Average maximal daily temperature [Degree Celsius]'
   values=(0 to 30);
run;
title;


*** 4.5;

%let from = 01OCT2021;
%let till= 31DEC2021;
title Daily maximal temperature of the 4. calendar quarter of 2021;
footnote justify=right time window: &from. -  &till.;

proc sgplot data=work.hydro_daily_sort;
  series x=datum y=Wert_max / lineattrs=(thickness=1.5); 

  where upcase(messid)="T" and "&from."d <= datum <= "&till."d;

  yaxis label="temperature [Degree Celsius]" values=(-5 to 30);
  xaxis label="date";
run;
title; footnote; 


*** 4.6;

proc means data=work.hydro_daily_sort min max range maxdec=1;  
   where upcase(messid)="W" and upcase(messstelle)="NEUSIEDL" and ("01Jan2015"d <= datum < "01Jan2023"d);   
   format datum yymmp.;
   var wert_max;
   output out=table_statistics / autoname;
   class datum;
run;

/* In den Instruktionen wird erwähnt, dass man
für jeden MONTAG die Statistiken ermitteln solle. 
Ich gehe davon aus, dass eigentlich "Monat" gemeint
war, da dies besser zu den Daten passen würde.
Die N Obs stimmen so auch überein mit dem
vorgeschlagenen Ergebnis. */