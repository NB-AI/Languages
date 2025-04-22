
*** 3.;
libname TASKS "/shared/home/path/casuser/Tasks";
run;

*** 6.;
filename xls_in "/shared/home/k11923286@students.jku.at/casuser/Tasks/baseball_data.xlsx";
proc import dbms=xlsx out=WORK.BASEBALL_DATA datafile=xls_in replace;
run;

*** 7.;
proc contents data=WORK.BASEBALL_DATA varnum;
run;

*** 8.;
data TASKS.BASEBALL_DATA; *** erzeuge neues Dataset;
set WORK.BASEBALL_DATA; *** verwende ein bestehendes Dataset;

*** 9.;
rename Frstname = FIRSTNAME
Lastnaem = LASTNAME;

*** 10.;
label nAtBat = "At_Bats"
nHits = "Hits"
nHome = "Home_Runs"
nRuns = "Runs"
nRBI = "RBIs";

run;

*** 11.;
proc contents data=TASKS.BASEBALL_DATA varnum;
run; 

*** 12.;
proc print data=TASKS.BASEBALL_DATA (firstobs=1 obs=20);
run;

*** 13.;
proc freq data=TASKS.BASEBALL_DATA;
	tables Team / plots=(freqplot cumfreqplot);
run;
/* shows us the frequency distribution over the different
Teams. freqplot gives us the single absolute frequnecies for 
each team as bar diagram. cumfreqplot delivers a plot
showing the cumulative absolute frequency over all teams also
as bar chart.
*/
