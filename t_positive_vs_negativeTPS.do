* Exclude China

clear all
run "t3_main.do"

* Positive vs Negative TPS
est clear
eststo: quietly reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country if coef_btf>0, r
eststo: quietly reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country if coef_btf<0, r
eststo: quietly reg CAR_11 coef_btf lev roa beta log_asset bm cash i.sic2 i.country if coef_btf>0, r
eststo: quietly reg CAR_11 coef_btf lev roa beta log_asset bm cash i.sic2 i.country if coef_btf<0, r

* Interaction with a dummy of positive TPS
ge positiveTPS = 1 if coef_btf>0 & coef_btf!=.
replace positiveTPS = 0 if coef_btf<0 & coef_btf!=.

eststo: quietly reg CAR_11 c.ABScoef_btf##i.positiveTPS lev roa beta log_asset bm cash i.sic2 i.country, r
eststo: quietly reg CAR_11 c.coef_btf##i.positiveTPS lev roa beta log_asset bm cash i.sic2 i.country, r


* export results
esttab using "output/Robust_PosNegTPS.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table --. } {Positive vs Negative TPS})
