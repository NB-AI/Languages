cas cas1;
caslib _all_ assign;

*** note that the TASKS library must be defined in your SAS session
    You should already have this available from the other Tasks with a statement like:
    LIBNAME tasks '... pathname ... ';
libname tasks "/shared/home/path/casuser/tasks";
libname lv "/shared/home/path/casuser/LV_Data";
run;

data lv.bigorganics_trn
     lv.bigorganics_tst;
 call streaminit (2603);
 set tundata.bigorganics;
 if rand('Uniform') < 0.7 then output lv.bigorganics_trn;
 else output lv.bigorganics_tst;
run;



*** Load to Memory for in-memory Procedures;

data casuser.bigorganics_trn;
 set lv.bigorganics_trn;
run;


data casuser.bigorganics_tst;
 set lv.bigorganics_tst;
run;

*** Deskriptive Auswertung;

** Statistische Eckdaten;


%macro prepareDescriptiveData(in_data, out_data);

data &out_data.;
 set &in_data.;

/*
Interessant könnte es sein, die Häufigkeitsverteilung des Alters in Jahrzehnten zu 
erfassen, um einen einfacheren Überblick zu erhalten:
*/
demAffl_tenth = floor(DemAffl/10);
age_decade = floor(DemAge/10);

if 0 <= PromSpend < 100 then promSpend_ord=0;
else if 100 <= PromSpend < 999.99 then promSpend_ord=1;
else if 1000 <= PromSpend < 9999.99 then promSpend_ord=2;
else if 10000 <= PromSpend < 99999.99 then promSpend_ord=3;
else if not missing(PromSpend) then promSpend_ord=4;

promTime_quartalized = floor(PromTime/3);

* Es funktioniert nicht, eine Varaible direkt in einen anderen Datentypen zu
transformieren. Deshalb:;
if upcase(PromClass)="" then promClass_ord=.;
else if  upcase(PromClass)="TIN" then promClass_ord=0;
else if  upcase(PromClass)="SILVER" then promClass_ord=1;
else if  upcase(PromClass)="GOLD" then promClass_ord=2;
else if  upcase(PromClass)="PLATINUM" then promClass_ord=3;

drop PromClass id;
run;

%mend;

%prepareDescriptiveData(casuser.bigorganics_trn, casuser.des_data);

* Erster Einblick in das neue Datenset: ;
proc print data=casuser.des_data ( where=(promSpend_ord>500));
run;


proc contents data=casuser.des_data;
run;

** 1. Basisstatistik:;
* DemAffl, DemAge, PromTime sind genaugenommen ordinal. Z. B. ist für das
Alter nicht klar, wie viele Monate/Tage/... die Person alt ist, nur das Jahr
ist bekannt. Dennoch wird auch in Studien gerne z. B. das Durschnittalter
metrisch durch den Mittelwert berechnet. Deshalb behandle ich sie in der
Basisstatistik und Korrelationsanalyse als metrisches Daten: ;
title "Basisstatistik für metrische Variablen";
proc means data=casuser.des_data n nmiss median mean std kurt skew min max;
var DemAffl DemAge PromSpend PromTime TargetAmt;
run;
title;
*
PromSpend: Mittelwert und Median liegen weit auseinander. Die Werte weißen 
darauf hin, dass es nach oben hin mindestens einen Ausreiser geben muss, der
den Mittelwert mitzieht.
PromTime: Obwohl ein Maximalwert von 39 erreicht, wird liegen Median (5) und
Mittelwert (ca. 6.56) deutlich darunter. Zu vermuten ist, dass das Programm
mehrheitlich Neukunden/-kundinnen hat. 
Das wird auch bei TargetAmt nochmal verdeutlicht, das die Anzahl der eingelösten
Gutscheine widergibt. Der Median liegt bei 0, der Durschnistt bei ca. 0.3 .
;


* Nominale und Ordinale Variablen sollen auch beachtet werden:;
/*
Bei nominalen und oridnalen Variablen ist es inkorrekt, 
statistische Werte, wie z. B. den Durchschnitt, zu nehmen. 
Um dennoch einen Überblick über deren Verteilung zu 
bekommen wird proc freq verwendet. 

Metric (mehr oder minder): DemAffl, DemAge, DemCluster
Ordinal: DemClusterGroup, PromClass
Nominal: DemGender, DemReg, DemTVReg
*/
title "Basisstatistik für ordinale Variablen";
proc means data=casuser.des_data n nmiss median min max;
var age_decade demAffl_tenth promClass_ord promSpend_ord promTime_quartalized;
run;
title;
* promTime_quartilized: Der Median=1 zeigt, dass mindestens die Hälfte der Kunden sich
erst im ersten Quartal ihrer Mitgliedschaft befinden. ;

* nominal:;
title "Häufigkeitsverteilungen der nominalen Variablen";
proc freq data=casuser.des_data;
tables DemCluster DemClusterGroup DemGender DemReg DemTVReg TargetBuy / nocum;
run;
title;
*
Es wurde die Häufigkeitstabelle statt des 
Balkendiagramms gewählt, da diese genauere 
Auskunft gibt.

DemGender: nicht bevölkerungsrepräsentativ, da deutliches Übergewicht der Frauen
(61.63 %) und U (unknown oder drittes Geschlecht?, 8.84 %). Daher
werden später zufällige Frauen für das Modell aussortiert. Meine
Lineare Regression hatte aufgrund dessen einen höheren R^2-Wert.
TargetBuy: Deutliches Übergewicht von 0 (75.06 %). Daher könnte ein
Modell lernen, immer 0 vorherzusagen. Deshalb werden später zufällig
samples mit Wert 0 aussortiert, sodass 0 und 1 gleichverteilt sind. 
;

************************************************;
** 2. Korrelationsanalyse;
* info correlation types: https://researchbasics.education.uconn.edu/types_of_correlations/;
* https://www.scribbr.com/statistics/correlation-coefficient/;
* https://support.sas.com/documentation/cdl/en/procstat/63104/HTML/default/viewer.htm#procstat_corr_sect004.htm;

* Zwischen metrischen Variablen:;
title "Korrelationen zwischen metrischen Variablen";
proc corr nomiss nosimple data=casuser.des_data;
var DemAffl DemAge PromSpend PromTime TargetAmt;
run;
title;
*
Es besteht eine deutliche Korrelation zwischen DemAffl und TargetAmt (0,46460).
Daher könnte DemAffl im Modell einen starken Einfluss auf die Vorhersagen haben.

Das DemAge weist eine negative Korrelation mit dem TargetAmt auf (-0,30658). Je höher das Alter, desto weniger eingelöste Gutscheine. 
Daher könnte auch das Alter ein wichtiges Feature für die Modellvorhersagen sein. 
Die metrischen Prädiktorvariablen weisen untereinander keine auffällig starken Korrelationen auf.
;

* Ordinale und mertrische Variablen:;
title "Korrelationen für ordinale und metrische Variablen";
proc corr nomiss nosimple spearman data=casuser.des_data;
run;
title;
*
Mit einem Wert von 0.41078 lässt sich die Tendenz aufzeigen, dass umso höher das Alter,
desto mehr wurde in vorherigen Aktionen ausgegeben.

Wenig überraschend ist der Zusammenhang zwischen den beiden Zielvariablen TargetBuy und TargetAmt beinahe perfekt (0.99467). 
Das Model wird nur TargetBuy beachten, da in der Aufgabenstellung dies die Zielvariable ist. 
TargetAmt wird ignoriert, um nicht den Lernprozess zu verfälschen.
;

* Nominal vs ordinal/nominal --> ChiSquare;
* Nominal vs nominal --> Cramer's V;
title "Assoziationen für nominale und ordinale Variablen";
proc freq data=casuser.des_data;
tables (DemGender DemReg DemTVReg TargetBuy)*(demAffl_tenth age_decade DemGender DemReg DemTVReg DemClusterGroup promClass_ord promSpend_ord promTime_quartalized TARGETBUY TARGETAMT) / chisq noprint ;
run;
title;
*
Es liegt eine leichte Assoziation zwischen TargetBuy und DemGender vor, was anhand des Cramer's Vs in Höhe von 0.2343 klar wird. 
Daher scheint ein Geschlecht stärker auf Gutscheineinlösungen anzusprechen. Der Zusammenhang ist jedoch nicht stark ausgeprägt.

Ein leichter Zusammenhang mit Cramer's V=0.1136 liegt zwischen TargetBuy und promClass_ord (ord für ordinal) vor. 
Der Statuslevel der Mitgliedschaft scheint auch mit der Bereitschaft, Gutscheine einzulösen, zusammenzuhängen.

Zwischen den Prädiktorvariablen liegen auch hier keine auffälligen Assoziationen vor. 
;

************************************************;
** 3. Boxplots;
** Ordinale und metrische Daten:;
* Bringe alle Variable auf selbes Einheitsmaß, z-score und vergleiche dann
die verschiedenen Boxplots Seite an Seite.
https://blogs.sas.com/content/iml/2014/09/08/order-variables-by-statistic.html :;
* Standardize Variable in range of [0, 1]:;
proc stdize method=range data=casuser.des_data out=MyData; 
run; 

%let Stat = Median; 
proc means data=MyData &Stat STACKODSOUTPUT; 
ods output Summary=StatOut;
run;

proc sql noprint;                              
 select Variable into :varlist separated by ' '
 from StatOut order by &Stat;
quit;

data Wide / view=Wide;     
retain &varlist;           /* reorder vars by statistic */
set MyData;
obsNum = _N_;              /* add ID for subject (observation) */
keep obsNum &varlist;
run;
 
/* transpose from wide to long data format; VARNAME is a categorical var */
proc transpose data=Wide name=VarName 
               out=Long(rename=(Col1=_Value_) drop=_LABEL_);
by obsNum;
run;

title "Standardisierte Box Plots über die ordinalen und metrischen Variablen";
proc sgplot data=Long;
   label _Value_ = "Standardized Value" VarName="Variable";
   vbox _Value_ / category=VarName;
   xaxis discreteorder=data display=(nolabel);        /* respect ordering */
run;
title;
*
Auffallend ist, dass es für PromSpend, PromTime, DemAffl sehr viele Outlier über der IQR gibt. 
Für PromSpend lässt sich dies so interpretieren, dass die meisten Kunden sich anscheinends noch nicht
an vorangegangen Aktionen beteiligt hatten. 
Auch für PromTime wird deutlich, dass die meisten Kunden Neukunden sind. 
Das könnte als Hinweis dienen, dass die aktuelle Aktion gerade erst anläuft und noch Kunden dazugewinnt.
;

* Boxplots sind nicht geeignet für nominelle Daten.;


************************ Data Preparation for model ******************************;
%macro prepareModelData(data_in, data_out);
* Sampling mit der Strategie, dass Geschlecht
und TargetBuy ebenmäßigere Verteilungen haben;
proc surveyselect noprint data=&data_in.
    out=&data_out.
    method=srs    /*use simple random sampling within strata*/
samprate=1    /* Ziehe 100 % der samples, wenn die Anzahl kleiner gleich nmax*/
nmax=20395           /*Anzahl der Gender M samples*/
    seed=11923286;       /*set seed to make this example reproducible*/
    strata DemGender; /*specify variable to use for stratification*/
run;

proc surveyselect noprint data=&data_out.
    out=&data_out.
    method=srs    /*use simple random sampling within strata*/
samprate=1        
nmax=11753           /*Anzahl der Gender M samples*/
    seed=11923286;       /*set seed to make this example reproducible*/
    strata TargetBuy; /*specify variable to use for stratification*/
run;

data &data_out.;
set &data_out.;
drop DemCluster DemTVReg TargetAmt id SamplingWeight SamplingWeight2;

* ordinal:;
if upcase(PromClass)="" then promClass_ord=.;
else if  upcase(PromClass)="TIN" then promClass_ord=0;
else if  upcase(PromClass)="SILVER" then promClass_ord=1;
else if  upcase(PromClass)="GOLD" then promClass_ord=2;
else if  upcase(PromClass)="PLATINUM" then promClass_ord=3;

*nominal:;
if upcase(DemClusterGroup)="A" then DemClusterGrup_A=1;
else if upcase(DemClusterGroup)="B" then DemClusterGrup_B=1;
else if upcase(DemClusterGroup)="C" then DemClusterGrup_C=1;
else if upcase(DemClusterGroup)="D" then DemClusterGrup_D=1;
else if upcase(DemClusterGroup)="E" then DemClusterGrup_E=1;
else if upcase(DemClusterGroup)="F" then DemClusterGrup_F=1;
else if upcase(DemClusterGroup)="U" then DemClusterGrup_U=1;

if upcase(DemGender)="F" then DemGender_F=1;
else if upcase(DemGender)="M" then DemGender_M=1;
else if upcase(DemGender)="U" then DemGender_U=1;

if upcase(DemReg)="MIDLANDS" then DemReg_M=1;
else if upcase(DemReg)="NORTH" then DemReg_N=1;
else if upcase(DemReg)="SOUTH EAST" then DemReg_E=1;
else if upcase(DemReg)="SOUTH WEST" then DemReg_W=1;
else if upcase(DemReg)="SCOTTISH" then DemReg_S=1;

drop DemClusterGroup PromClass DemGender DemReg;
run;

* for one-hot encoded values replace missing values with 0:;
proc stdize data=&data_out.
	out=&data_out.
	reponly missing=0;
        var DemClusterGrup_A DemClusterGrup_B DemClusterGrup_C DemClusterGrup_D DemClusterGrup_E DemClusterGrup_F DemClusterGrup_U
            DemGender_F DemGender_M DemGender_U
            DemReg_M DemReg_N DemReg_E DemReg_W DemReg_S
;
run;


* replace missing values with median:;
proc stdize data=&data_out.
	out=&data_out.
	reponly method=median;
run;


* Normalize data with z-score:;
proc standard data=&data_out. mean=0 std=1
              out=&data_out.;
var DemAffl; var DemAge; var PromSpend; var PromTime;
* define several var to treat variables independently;
* Ordinal data shall not be normalized!;
run;
%mend;


%prepareModelData(casuser.bigorganics_trn, casuser.data_pre);
************************ Predictive Model **********************************;
************************ Logistic Regression *******************************;
* https://go.documentation.sas.com/doc/en/pgmsascdc/9.4_3.4/statug/statug_logistic_examples.htm ;
* https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_reg_sect007.htm;
* Take numeric values and normalize them:;

title "Auszug vorbereitetes Datenset";
proc print data=casuser.data_pre (OBS=3);
run;
title;

* create model:;
proc logistic data=casuser.data_pre descending outest=learnt_para outmodel=out_data;
model TARGETBUY = DemAffl DemAge PromSpend PromTime promClass_ord 
            DemClusterGrup_A DemClusterGrup_B DemClusterGrup_C DemClusterGrup_D DemClusterGrup_E DemClusterGrup_F DemClusterGrup_U
            DemGender_F DemGender_M DemGender_U
            DemReg_M DemReg_N DemReg_E DemReg_W DemReg_S; 
store my_model;
code file = "/shared/home/k11923286@students.jku.at/casuser/Tasks/ScoreLogik.sas";
run;

* make model predcitions with train set:;
proc score data=casuser.data_pre score=learnt_para type=parms predict out=dataset_with_pred_train;
var DemAffl DemAge PromSpend PromTime promClass_ord 
            DemClusterGrup_A DemClusterGrup_B DemClusterGrup_C DemClusterGrup_D DemClusterGrup_E DemClusterGrup_F DemClusterGrup_U
            DemGender_F DemGender_M DemGender_U
            DemReg_M DemReg_N DemReg_E DemReg_W DemReg_S; 
run;

* make model predcitions with test set:;
%prepareModelData(casuser.bigorganics_tst, casuser.data_pre_test);
proc score data=casuser.data_pre_test score=learnt_para type=parms predict out=dataset_with_pred_test;
var DemAffl DemAge PromSpend PromTime promClass_ord 
            DemClusterGrup_A DemClusterGrup_B DemClusterGrup_C DemClusterGrup_D DemClusterGrup_E DemClusterGrup_F DemClusterGrup_U
            DemGender_F DemGender_M DemGender_U
            DemReg_M DemReg_N DemReg_E DemReg_W DemReg_S; 
 
run;


data dataset_with_pred_test;
set dataset_with_pred_test;
if TargetBuy2 <= 0.5 then TargetBuy2=0;
else TargetBuy2 = 1;
run;

* R^2: ;
* https://support.sas.com/resources/papers/proceedings17/1334-2017.pdf ;

%let true = TargetBuy;
%let pred = TargetBuy2;
%let dataset = dataset_with_pred_test;
proc sql;
select 1-_SSE_/(_SSE_+_SSR_) as _RSQUARE_
from(
select
SUM((A.&pred.-A.&true.)**2) as _SSE_ ,
SUM((A.&pred.-B.Ybar)**2) as _SSR_ ,
SUM((A.&true.-B.Ybar)**2) as _SST_
from
&dataset. as A,
(select MEAN(&true.) as Ybar from &dataset.) as B
) ;
quit;
* R^2=0.472634 for train and 0.479194 for test set;

************************ Ende *******************;
