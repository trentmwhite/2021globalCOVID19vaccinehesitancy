/* Table 1, 2*/
proc surveyfreq data = all;
by country;
weight WEIGHTS;
tables Age_Groups q28 Education q30 q23 q18 q19 q20 q21 q22;
run;

/* Figure 1*/
/* panel a*/
data all; set all; 
q78hes=.;
IF (q7=2) and (q8>=3) THEN q78hes = 1; 
IF (q7=1) or (q8<3) THEN q78hes = 0;
run; 
data all; set all; 
q78hes2=.;
IF (q7=2) and (q8>=3) THEN q78hes2 = 1; 
IF (q7=1)  THEN q78hes2 = 2;
IF (q7=2) and (q8<3) THEN q78hes2 = 3;
run;
proc surveyfreq data = all;
by country;
weight WEIGHTS;
tables q78hes q78hes2;
run;
/* panel b*/
proc surveyfreq data = all;
by country;
weight WEIGHTS;
tables q10 q11;
run;
/* panel c*/
proc surveyfreq data = all;
by country;
where q78hes=1; 
weight WEIGHTS;
tables q10 q11;
run;
proc surveyfreq data = all;
by country;
where q78hes2=3; 
weight WEIGHTS;
tables q10 q11;
run;
/* Figure 3*/
proc surveyfreq data = all;
by country;
where q9<6;
weight WEIGHTS;
tables q9;
run;
proc surveyfreq data = all;
by country;
where q9<6 and q78hes2=2 ;
weight WEIGHTS;
tables q9;
run;
proc surveyfreq data = all;
by country;
where q9<6 and q78hes2=3 ;
weight WEIGHTS;
tables q9;
run;
proc surveyfreq data = all;
by country;
where q9<6 and q78hes2=1 ;
weight WEIGHTS;
tables q9;
run;
/* Figure 4*/
proc surveylogistic data = all;
by country;
weight WEIGHTS;
class Education (ref='No University Degree')q28rec (ref='Female')
q30 (ref='Yes, my monthly income is more than Countries Median Income') 
q1920 (ref='None') q18(ref='No') ;
model q782 (desc) = q27 Education q28rec q30 q1920 q18; 
ods output oddsratios=oracceptdemo;
run;
/* Figure 5*/
proc surveylogistic data = all;
by country;
weight WEIGHTS;
class Education (ref='No University Degree')q28rec (ref='Female')
q30 (ref='Yes, my monthly income is more than Countries Median Income') 
q1920 (ref='None') q18(ref='No') 
q24 (ref='No')q25(ref='No')
q21rec (ref='Rarely/Some')q22rec(ref='Rarely/Some');
model q782 (desc) = q27 Education q28rec q30 q1920 q18 q2rec q4rec q6rec q24 q25 q21rec q22rec; 
ods output oddsratios=oracceptdemo;
run;
/* Table 3*/
proc surveyfreq data = all;
tables q23;
run;
proc surveyfreq data = all;
where  q23=4;/* q23=2 q23=3 q23=4*/
tables  q78hes q78hes2;
run;

proc genmod data = all;
class country Education (ref='No University Degree')q28rec (ref='Female')
q30 (ref='Yes, my monthly income is more than Countries Median Income') q1920 (ref='None')q18(ref='No')
q23rec (ref='Physician, Nurse, Community Health Worker, Other healthcare worker') ; 
 model q782  = q23rec q27 Education q28rec q30 q1920 q18/ dist = binomial link = log;
 repeated subject = country/ type = cs;
run;
/*Figure 6*/
/* panel a*/
proc surveyfreq data = all;
by country;
weight WEIGHTS;
tables q12 q13 q14 q15 q16 q17;
run;
/* panel b*/
proc surveyfreq data = all;
by country;
where q78hes=1;
weight WEIGHTS;
tables q12 q13 q14 q15 q16 q17;
run;
/* end*/


