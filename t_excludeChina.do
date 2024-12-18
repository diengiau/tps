* Exclude China

clear all
run "t3_main.do"

* find statistics of firm total asset
reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country if fic!="CHN"
su log_asset if e(sample), de

reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country if fic=="CHN"
su log_asset if e(sample), de


* Exclude China

est clear
eststo: quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country if fic!="CHN", r
eststo: quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2  if fic=="CHN", r
eststo: quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2 i.country if fic!="CHN" & log_asset>= 3.184823, r
eststo: quietly reg CAR_11 ABScoef_btf lev roa log_asset bm cash i.sic2  if fic=="CHN" & log_asset>= 5.514225, r
esttab using "output/Robust_ExcChina.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table --. } {Exclude China})
