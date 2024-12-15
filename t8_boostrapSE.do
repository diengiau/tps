* Create the data as main test
clear all
run "t3_main.do"


// **set working directory**
// *use "D:\research\p15_trump\Project 1\Raw Data\df_election_more_tps", clear
// use "D:/research/p15_trump/Project 1/Final Codes/data/trump/CAPM_RBTF10y.dta", clear
//
// format datadate %td
// drop if coef_btf == .
// drop if nobs < 1000
// encode fic, ge(country)
//
// ****remove countries with observations <10
//
// ****1. Remove effect of tiny stocks with total assets less than $100 million****
// gen total_asset=exp(log_asset)
//
// ***log transformation of ME for easy presentation
// gen LNMKTCAP= ln(ME)
//
// *********************2. Prepare data for Basis stat************************
// sort gvkey iid datadate
// ***Before election day
// by gvkey: gen event_window_5_1=1 if dif>=-5 & dif<=-1
// replace event_window_5_1=0 if event_window_5_1==.
// by gvkey: egen CAR_5_1=sum(AR_w) if event_window_5_1==1
//
// ****After election day
// by gvkey: gen event_window15=1 if dif>=1 & dif<=5
// replace event_window15=0 if event_window15==.
// by gvkey: egen CAR15=sum(AR_w) if event_window15==1
//
// ****Surrounding election day
// by gvkey: gen event_window_11=1 if dif>=-1 & dif<=1
// by gvkey: gen event_window_33=1 if dif>=-3 & dif<=3
// by gvkey: gen event_window_55=1 if dif>=-5 & dif<=5
//
// replace event_window_11=0 if event_window_11==.
// replace event_window_33=0 if event_window_33==.
// replace event_window_55=0 if event_window_55==.
//
// by gvkey: egen CAR_11=sum(AR_w) if event_window_11==1
// by gvkey: egen CAR_33=sum(AR_w) if event_window_33==1
// by gvkey: egen CAR_55=sum(AR_w) if event_window_55==1
//
// ****On election day
// by gvkey: gen event_window_0=1 if dif==0
// replace event_window_0=0 if event_window_0==.
// by gvkey: egen CAR_0=sum(AR_w) if event_window_0==1
//
//
// ******************3. Collapse data across observation before regressing*********
// collapse CAR_0 CAR_5_1 CAR_11 CAR_33 CAR_55 CAR15 sale_growth total_asset lev ///
// ME bm roa cash div beta LNMKTCAP log_asset ///
// coef_* (firstnm) *_gdp sic fic country, by(gvkey)
// // (firstnm) sic fic country coef_*, by(gvkey)
//
// // keep if dif==0
// // bysort gvkey: egen maxtotal_asset = max(total_asset)
// // keep if total_asset == total_asset
//
// order gvkey sic fic
// sort gvkey sic fic
//
// ge sic3 = substr(sic, 1, 3)
// ge sic2 = substr(sic, 1, 2)
// destring sic2 sic3 , replace
// order gvkey sic fic sic2 sic3
//
// * encode fic, ge(country)
//
//
//
// ********************4. Generating threat and beneficiary for CAR after Collapse*
// *replace coef_btf = coef_btf/1000
// winsor2 CAR* , cuts(1 99) replace
// winsor2 lev roa beta log_asset bm cash, cuts (1 99) replace
// // winsor2 CAR* coef_btf lev roa beta log_asset bm cash, cuts (1 99) replace
//
//
// gen ABScoef_btf = abs(coef_btf)
// winsor2 ABScoef_btf, cuts(1 99) replace

*********************TABLE . BOOTSTRAPED STANDARD ERRORS**************

***Model 1-4: CAR(-1 days, 1 days) TPS with i.industry2 & i.country
est clear
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev roa beta i.sic2 i.country, r
eststo: bootstrap, reps(1000) strata(sic2 country): quietly reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash i.sic2 i.country, r

***Output CAR_11 Results:
esttab using "output/BootstrapMain.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
drop(*sic2* *country*) ///
title({\b Table . } {Bootstrap SE})
