clear all

* 1. CAR33 and CAR55
run "t3_main.do"

* Export 2 regressions
est clear
eststo: quietly reg CAR_33 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country, r
eststo: quietly reg CAR_55 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country, r

esttab using "output/AltCARs.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table --. } {Alternative CARs})

* 2. CAPM with excess returns
run "t6sub01_CAPMexret.do"

* 3. Dimson1979 adjusted
run "t6sub02_Dimson.do"
run "t6sub03_Dimsonexret.do"

* 4. FF3
run "t6sub04_FF3.do"
run "t6sub05_FF3exret.do"

