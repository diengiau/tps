cd "D:\research\p15_trump\Project 1\Final Codes"
* Run tables one by one
* Summary statistics and univariate test
run "t1_bystats.do" 
run "t2_summary_stats.do"

* Main results
* Table 3:
run "t3_main.do"

* Table 4: 
run "t4_more_country_controls.do"
* Table 5:
run "t5_longterm.do"

* Robustness
run "t6_alter_CARs.do"
run "t7_alterTPS.do"
run "t8_boostrapSE.do"

* Additional evidence
* Positive and negative TPS
run "t_positive_vs_negativeTPS.do"
* Exclude China
run "t_excludeChina.do"

