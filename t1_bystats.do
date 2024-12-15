***Repeat Main Data**
******************** 1. Filter data
clear all
run "t3_main.do"

*********** Create variables for Panel A of Table 1***********
egen obs = count(gvkey), by(fic)

egen negativeCAR_0 = count(gvkey) if CAR_0<0, by(fic)

egen negativeCAR_11 = count(gvkey) if CAR_11<0, by(fic)

gen PercentnegCAR_0 = negativeCAR_0/obs*100

gen PercentnegCAR_11 = negativeCAR_11/obs*100


asdoc tabstat obs ABScoef_btf CAR_0 PercentnegCAR_0 CAR_11 PercentnegCAR_11, by(fic) save(output/negative_car.doc) dec(4) replace // Copy and Paste results to excel file



*********** Create variables for Panel B of Table 1***********
***Panel B: By Industry

gen industry2 = sic2

gen Industry2class=""

replace Industry2class = "Agriculture_Forestry_Fishing" if industry2==1 | industry2==2 | industry2==7 | industry2==8 | industry2==9


replace Industry2class = "Mining" if industry2==10 | industry2==12 | industry2==13 | industry2==14


replace Industry2class = "Construction" if industry2==15 | industry2==16 | industry2==17


replace Industry2class = "Manufacturing" if industry2==20 | industry2==21 | industry2==22 | industry2==23 | industry2==24 ///
| industry2==25 | industry2==26 | industry2==27 | industry2==28 | industry2==29 | industry2==30 | industry2==31 ///
| industry2==32 | industry2==33 | industry2==34 | industry2==35 | industry2==36 | industry2==37 | industry2==38 ///
| industry2==39


replace Industry2class = "Transportation_PublicUtilities" if industry2==40 | industry2==41 | industry2==42 | industry2==44 | industry2==45 ///
| industry2==46 | industry2==47 | industry2==48 | industry2==49


replace Industry2class = "Wholesale Trade" if industry2==50 | industry2==51


replace Industry2class = "RetailTrade" if industry2==52 | industry2==53 | industry2==54 | industry2==55 | industry2==56 ///
| industry2==57 | industry2==58 | industry2==59


replace Industry2class = "Finance_Insurance_RealEstate" if industry2==60 | industry2==61 | industry2==62 | industry2==63 | industry2==64 ///
| industry2==65 | industry2==67


replace Industry2class = "Services" if industry2==70 | industry2==72 | industry2==73 | industry2==75 | industry2==76 ///
| industry2==78 | industry2==79 | industry2==80 | industry2==81 | industry2==82 | industry2==83 | industry2==84 ///
| industry2==86 | industry2==87| industry2==89


replace Industry2class = "Others" if industry2==99 | industry2==.


egen INDobs = count(gvkey), by(Industry2class) 

egen INDnegativeCAR_0 = count(gvkey) if CAR_0<0, by(Industry2class)

egen INDnegativeCAR_11 = count(gvkey) if CAR_11<0, by(Industry2class)

gen INDPercentnegCAR_0 = INDnegativeCAR_0/INDobs*100

gen INDPercentnegCAR_11 = INDnegativeCAR_11/INDobs*100 


asdoc tabstat INDobs ABScoef_btf CAR_0 INDPercentnegCAR_0 CAR_11 INDPercentnegCAR_11, by(Industry2class) save(output/by_industry.doc) dec(4) replace // Copy and Paste results to excel file


