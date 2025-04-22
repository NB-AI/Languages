/* main task:
What are the two most interesting code snippets 
in the three articles?

1.
data _NULL_;
set ...;

--> create data set without records and variables. E.g.
make an caculation without storing a memory consuming 
data set:

data _null_;
    x = 5 * 10;
    put x;
run;

With this way you can also operate one the level of 
variables of a data set which is opened by "set".



2.
Crating a loop with 

do Year = 2015 to 2025;
  FirstFullSatInFeb = intnx('week.7',mdy(1,31,year),1);
  EasterMonday      = holiday('EASTER',year)+1;
  NumSkiWeekends    = intck('week.1',FirstFullSatInFeb,EasterMonday);
  output;
end;
run;

--> Calculations become possible for a changing variable. 
Other variables can consider that changing/looped variable.
As outcome of the calculations a new variable can be formed.
*/





*** side task:;

*** 5.1 simulate timeseries data with data step and functions;

** simply run code from editor:;

* prepare table:;
proc format;
 invalue fl_mon
     1 =438
     2 =426
     3 =516
     4 =494
     5 =506
     6 =536
     7 =566
     8 =573
     9 =478
    10 =508
    11 =479
    12 =490;
run;

* generate data:;
data flights_simul;
 *** Initialize the seed for the random number generator;
 call streaminit(20886); *** you can use any number;
 format Date yymmp7. Passengers 8.;
 drop year month;
  do Year = 1981 to 2000; *** Loop over Years;
     do month = 1 to 12;  *** Loop over Months;
         *** Prepare the TIME Variable;
         date = mdy(month,1,year);

         * basic form of time series:;
         passengers = (input(month, fl_mon.)-400)*40;

         *** Add a linear trend to the data;
         passengers =  Passengers + (year-1981+1)*1000;
         *** Add random variation to the data;
         passengers = passengers + rand('uniform')*1000;


         * add changes and outliers:;
         *** Add outliers and level shifts;
         if year in (1986,1987) then passengers = passengers * 1.2;

         passengers =  Passengers + (year in (1992)) * (-month*300);

         if date = '01APR1997'd then passengers = passengers * 1.25;
         if date = '01SEP1998'd then passengers = passengers * 0.8;
         if date = '01APR1990'd then passengers = passengers * 1.2;

       * closing data step:;
       *** Output the record;
       output;
     end;
  end;
run;

* print selected records:;
proc print data=flights_simul;
 where year(date) = 1992;
run;

* make lineplot:;
proc sgplot data=flights_simul;
 series x=date y=passengers;
run;


*** 5.2 reference lines in line-charts to highlight data-driven events;

** run the code from the underlying article with slight path change;

** run the create data sets provided by link in introduction first;


** example 1:
* getting data sets:;
proc adaptivereg data= AirlinePassengersSmooth plots=all ;
 model pass_smooth_backwTr = date/ maxbasis=11;
 ods output BWDParams=KnotPoints;
 output out=flights_adpt predicted=pred_adpt;
run;

* create refline statement through step:;
filename reflines '/shared/home/k11923286@students.jku.at/casuser/tasks/reflines_brk.sas';
data _NULL_;
 set KnotPoints;
 where name not in ("Basis0", "Basis1");
 file reflines;
 put @04 "refline " knot " / axis = x;";
run;

/* content of the refline above e.g.:
   refline 14792  / axis = x;
   refline 15553  / axis = x;
   refline 15096  / axis = x;
   refline 11596  / axis = x;
*/

* line plot:;
proc sgplot data=flights_adpt;
 series x=date y=passengers;
 series x=date y=pass_smooth_backwTr/lineattrs=(pattern=4);
 series x=date y=pred_adpt/lineattrs=(pattern=3);
 %include reflines;
run;
   refline 15706  / axis = x;

** example 2;

* save list detected events:;
proc x13 data=flights_911 date=date;
   var passengers;
   arima model=( (0,1,1)(0,1,1) );
   outlier;
   ods output RegParameterEstimates=RegParameterEstimates;
run ;

* write refline statement:;
filename reflines 'c:/tmp/reflines_outliers.sas';
data _NULL_;
 set RegParameterEstimates;
 file reflines;
  Date=cats("'01",compress(substr(regvar,3,length(regvar))),"'d");
  put @04 "refline " Date " / axis = x label = '"regvar "';";
run;

/* example refline out:
   refline '01SEP2001'd  / axis = x label = 'LS SEP2001 ';
   refline '01NOV2001'd  / axis = x label = 'LS NOV2001 ';
   refline '01DEC2002'd  / axis = x label = 'AO DEC2002 ';
   refline '01DEC2003'd  / axis = x label = 'LS DEC2003 ';
*/

* line-chart:;
proc sgplot data=flights_911;
   series x=date y=passengers;
   yaxis label='Passengers';
   xaxis label="Date";
   %include reflines;
run;

* own labels:;
proc sgplot data=flights_911;
   series x=date y=passengers;
   yaxis label='Passengers';
   xaxis label="Date";
   refline '01SEP2001'd  / axis = x label="Level Shift at 9/11";
   refline '01NOV2001'd  / axis = x label="Level Shift +";
   refline '01DEC2002'd  / axis = x label="Outlier +";
   refline '01DEC2003'd  / axis = x Label="Level Shift -";
run;


** using it for analytics:;

Pass_Change_PrevMonth = dif(passengers);
EasterMonth = (month(date)=month(holiday('Easter',year(date)));

filename refl_dif 'c:/tmp/sasensei/reflines_dif.sas';
* small path change here!;

data flights_911_flag;
 set flights_911;
 Pass_Change_PrevMonth = dif(passengers);
 EasterMonth = (month(date) = month(holiday('Easter',year(date))));
run;

** Be careful when combining DIF/LAG with IF statements in a datastep;
data _null_;
 set work.flights_911_flag;
 format Date 8.; 
 file refl_dif;
 if month(date)=4 and EasterMonth=0 then do;
    if Pass_Change_PrevMonth<0 then put @04 "refline " Date  " / axis = x label = 'March-Easter April Decrease';";
	else put @04 "refline " date  " / axis = x label = 'March-Easter April Increase';";
 end;
run;

proc sgplot data=flights_911;
 series x=date y=passengers;
 yaxis label='Passengers';
 xaxis label="Date";
 %include refl_dif;
run;




















