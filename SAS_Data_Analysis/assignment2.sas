/* Use run line before executing Create_claims_data.sas. Finally,
run the rest of this file here. */
*** libname TASKS "/shared/home/path/casuser/Tasks";
run;

*** 1.;
/* Hülle zum Erstellen eines Formats: */
proc format;
 value QUTR
         . = "missing"
       1-3 = "Quarter1"
       4-6 = "Quarter2"
       7-9 = "Quarter3"
      9-12 = "Quarter4";
run;

*** 2.-15.;
*** Shift CLAIMS from TASKS to WORK library: ;
data WORK.CLAIMS; *** erzeuge neues Dataset;
set TASKS.CLAIMS; *** verwende ein bestehendes Dataset;
run;


*** 12. we only want to work with samples fulfilling INCOME>200000;
data TASKS.CLAIMS_XT; *** erzeuge neues Dataset;
set WORK.CLAIMS (WHERE=(INCOME>200000)); *** verwende ein bestehendes Dataset;
/*
Kein 'run;', bevor nicht all das, was mit der file/Tabelle arbeitet,
abgeschlossen ist.
*/

*** 2.;
AGE_DECADE = floor(AGE/10);

*** 3.;
if missing(CLM_DATE) then CLAIM_MONTH = .;
*** . as numerisch , "" als Character.;
else                      CLAIM_MONTH = month(clm_date);

*** 4.;
CLAIM_QUARTER = CLAIM_MONTH;
format CLAIM_QUARTER QUTR.;

*** 5.;
if CLM_FLAG = "Yes" then CLM_FLAG_NUM = 1;
else if CLM_FLAG = "No" then  CLM_FLAG_NUM = 0;
else                         CLM_FLAG_NUM = .;
/*
missing values shall be assigned to . (numeric placeholder), also
the case for strings with false content
*/

*** 6.;
sas_time_curr = DATE(); 
format BIRTH sas_time_curr date9.; *** shall have of course the same time format;
AGE_TODAY = floor((intck('month',birth,sas_time_curr) - (day(sas_time_curr) < day(birth))) / 12); 
/* in optional task further explained */

*** optional A.;
format INITDATE date9.;
START_AGE = floor((intck('month',birth,initdate) - (day(initdate) < day(birth))) / 12); 
/* day(initdate) < day(birth) gives us 1 for the case that the day of initdate is 
in timeline before the birthday. Therefore, substract 1 when this is the case 
because person had not birthdays this year so far.
When we are not in the birth month, e.g. initdate month is January and 
birth is in February, then we substract one month in total but because
of floor() it doesn't make a difference in the START_AGE.
/12 to get out the number of years.
floor() rounds down the number of years when it is a float, e.g.
4.5 --> 4  
*/

*** 7.;
if GENDER = "M" then MALE = 1;
else                 MALE = 0;

*** 8.;
POLICYNO_DIG = floor(POLICYNO *10**(-7)) - floor(POLICYNO *10**(-8))*10;

*** 9.;
RISK_POINT = 0;
IF AGE < 30 THEN RISK_POINT = RISK_POINT + 1;
***IF DENSITY IN("URBAN", "Highly Urban") THEN RISK_POINT = RISK_POINT + 1;
IF DENSITY = "Urban" or DENSITY = "Highly Urban" THEN RISK_POINT = RISK_POINT + 1;
IF HOMEKIDS >= 1 THEN RISK_POINT = RISK_POINT + 1;
IF RED_CAR = "yes" THEN RISK_POINT = RISK_POINT + 1;
IF CAR_USE = "Commercial" THEN RISK_POINT = RISK_POINT + 1;
IF KIDSDRIV = 1 THEN RISK_POINT = RISK_POINT + 1;

*** 13.;
IF CLM_AMT > 90000 THEN CLM_AMT = 90000;

*** 14.;
DENSITY = SUBSTR(DENSITY, LENGTH(DENSITY)-4, LENGTH(DENSITY));
CAR_USE = SUBSTR(CAR_USE,1,4); 
/* I am not sure if you want that we change also the single variables
or simply use the new values for our new variable DENSITY_CARUSE. 
When this is the case, we can easily create DENSITY2 and CAR_USE2
as variables or put the substring formula directly into the 
CATT() function below. */
DENSITY_CARUSE = CATT(DENSITY, "_", CAR_USE);
run;

*** 15.;
data 
TASKS.CLAIMS_YES(DROP=CLM_FLAG)
TASKS.CLAIMS_NO(DROP=CLM_FLAG)
; *** erzeuge neue Datasets;
set TASKS.CLAIMS_XT ; *** verwende ein bestehendes Dataset;
IF (CLM_FLAG="Yes") THEN OUTPUT TASKS.CLAIMS_YES;
ELSE IF (CLM_FLAG="No" ) THEN OUTPUT TASKS.CLAIMS_NO;
run;



