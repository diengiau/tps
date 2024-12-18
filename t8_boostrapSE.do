* Create the data as main test
clear all
run "t3_main.do"


// **set working directory**


*********************TABLE . BOOTSTRAPED STANDARD ERRORS**************

***Model 1-4: CAR(-1 days, 1 days) TPS with i.industry2 & i.country
est clear
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev roa i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country, r

***Output CAR_11 Results:
esttab using "output/BootstrapMain.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table . } {Bootstrap SE})

