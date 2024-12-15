clear
run "t3_main.do"

* The results without control for beta
est clear
eststo: quietly reg CAR_11 ABScoef_btf i.sic2 i.country, r
eststo: quietly reg CAR_11 ABScoef_btf lev i.sic2 i.country, r
eststo: quietly reg CAR_11 ABScoef_btf lev roa i.sic2 i.country, r
eststo: quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country, r
esttab using "output/Robust_AbsTPS_NoBeta.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table 5. } {Trump's policy effect on stock returns})