***Repeat Main Data**
******************** 1. Filter data
clear all
run "t3_main.do"


sort fic
merge fic using "D:\research\p15_trump\Project 1\Raw Data\country_control.dta"
tab _m
drop if _m == 2
drop _m

sort fic
merge fic using "D:\research\p15_trump\Project 1\Raw Data\political_institutions.dta"
tab _m
drop if _m == 2
drop _m
count 

*********************TABLE 6. Trump Policy Effect on Stock Returns**************

***Model 1-4: CAR(-1 days, 1 days) PUS i.industry2 i.country
global xvar lev roa beta log_asset bm cash
est clear

eststo: qui reg CAR_11 coef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp i.sic2 , r
eststo: qui reg CAR_11 coef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate i.sic2 , r
eststo: qui reg CAR_11 coef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate renewable_energy_consumption kyoto_commitment i.sic2 , r
eststo: qui reg CAR_11 coef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate renewable_energy_consumption kyoto_commitment male_president new_president election party_orientation i.sic2 , r
eststo: qui reg CAR_11 coef_btf lev roa beta log_asset bm cash immigration tax_rate renewable_energy_consumption kyoto_commitment import_us_gdp export_us_gdp election party_orientation male_president new_president i.sic2 , r

eststo: qui reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp i.sic2 , r
eststo: qui reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate i.sic2 , r
eststo: qui reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate renewable_energy_consumption kyoto_commitment i.sic2 , r
eststo: qui reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash import_us_gdp export_us_gdp immigration tax_rate renewable_energy_consumption kyoto_commitment male_president new_president election party_orientation i.sic2 , r
eststo: qui reg CAR_11 ABScoef_btf lev roa beta log_asset bm cash immigration tax_rate renewable_energy_consumption kyoto_commitment import_us_gdp export_us_gdp election party_orientation male_president new_president i.sic2 , r


***Output CAR_11 Results:
esttab using "output/Robust_more_country_controls.csv", replace modelwidth(10) varwidth(20) se ar2(4) ///
b(4) label varlabels(_cons Constant) star(* 0.10 ** 0.05 *** 0.01) compress ///
title({\b Table 5. } {Trump's policy effect on stock returns}) drop(*sic*)

* Updating Summary statistics to "stat01.doc"
asdoc su immigration tax_rate renewable_energy_consumption kyoto_commitment import_us_gdp export_us_gdp election party_orientation male_president new_president, stat(mean sd p25 p50 p75) dec(4) save(output/stat01.doc)
