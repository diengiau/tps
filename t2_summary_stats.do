
clear all
run "t3_main.do"

*********** Create variables for Table 2***********
***Panel A: Summary Statistics
* Main variables
asdoc su coef_btf ABScoef_btf CAR_11 CAR_33 CAR_55 CAR_5_1 CAR15 lev roa beta log_asset bm cash, stat(mean sd p25 p50 p75) replace dec(4) save(output/stat01.doc)
* Other control variables: will be updated automatically after run t4 & t5 & t7 do files


*** Panel B: t-tests
egen gr_abstps = xtile(ABScoef_btf) if CAR_11!=. | ABScoef_btf!=. , nq(3)
tabulate gr_abstps, summarize(CAR_11)
tabulate gr_abstps, summarize(CAR_33)
tabulate gr_abstps, summarize(CAR_55)


asdoc ttest CAR_11 if gr_abstps!=3, by(gr_abstps) save(output/ttest.doc) dec(4) replace
asdoc ttest CAR_11 if gr_abstps!=1, by(gr_abstps) save(output/ttest.doc) dec(4)
asdoc ttest CAR_11 if gr_abstps!=2, by(gr_abstps) save(output/ttest.doc) dec(4) 

asdoc ttest CAR_33 if gr_abstps!=3, by(gr_abstps) save(output/ttest.doc) dec(4) 
asdoc ttest CAR_33 if gr_abstps!=1, by(gr_abstps) save(output/ttest.doc) dec(4) 
asdoc ttest CAR_33 if gr_abstps!=2, by(gr_abstps) save(output/ttest.doc) dec(4) 

asdoc ttest CAR_55 if gr_abstps!=3, by(gr_abstps) save(output/ttest.doc) dec(4) 
asdoc ttest CAR_55 if gr_abstps!=1, by(gr_abstps) save(output/ttest.doc) dec(4) 
asdoc ttest CAR_55 if gr_abstps!=2, by(gr_abstps) save(output/ttest.doc) dec(4) 

*** Appendix - Correlation matrix ****
********************** Correlation Matrix*********************************
est clear
estpost correlate ABScoef_btf CAR_11 CAR_33 CAR_55 ///
lev roa beta ME log_asset bm cash, matrix listwise

****6. output result to excel file
esttab using "output/MainVarCorelationMatrix.csv", replace ///
b(4) unstack not ///
star (* 0.1 ** 0.05 *** 0.01) ///
compress ///
nonumbers ///
modelwidth(8) varwidth(10) ///
title({\b Table Appendix A2. } {Correlation Matrix})