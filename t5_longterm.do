* run main do file to restore data
clear all
run "t3_main.do"

sort gvkey
merge gvkey using "D:\research\p15_trump\Project 1\Raw Data\ContCret.dta"
tab _m
keep if _m == 3
drop _m

winsor2 r_*, cuts(1 99) replace

* Regressions
est clear
eststo: reg r_21 coef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_63 coef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_126 coef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_252 coef_btf lev roa beta log_asset bm cash i.sic2 i.country, 

eststo: reg r_21 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_63 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_126 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country, 
eststo: reg r_252 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country, 

esttab * using "output/LongTermReturns.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
title({\b Table 5. } {Long term returns}) drop(*sic2* *country*)

* SUMMARY STATISTICS
*global xvar r_21 r_63 r_126 r_252
*outreg2 using "output/LongTermReturnsStat.doc", replace sum(detail) keep($xvar) eqkeep(N mean sd p25 p50 p75)
asdoc su r_21 r_63 r_126 r_252, stat(mean sd p25 p50 p75) dec(4) save(output/stat01.doc)

