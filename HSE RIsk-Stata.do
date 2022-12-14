#

cap log close
log using "HSE Risk", replace 

version 17
clear

#step 1: define variable: cooking fuel (cf)
label list HV226
tab hv226
recode hv226 (1 12 = 0) (5 7 8 9 11 = 1) (95 96 = .), gen(cf)
label define CF 0 "Non-smoke-producing Fuels" 1 "Smoke-producing
Fuels"
label values cf CF
label variable cf "HH's Cooking Fuels"
tab cf

#step 2: define variable: cooking place (cp)
label list HV241
tab hv241
recode hv241 (3 = 0) (1 2 = 1) (6 = .), gen(cp)
label define CP 0 "Outdoor Cooking" 1 "Indoor Cooking"
label values cp CP
label variable cp "HH's Cooking Places"
tab cp

#step 3: define variable: smoke-exposure risk (ser)
gen ser = .
replace ser=1 if cf==1 & cp==1
replace ser=2 if cf==1 & cp==0
replace ser=3 if cf==0 & cp==1
replace ser=4 if cf==0 & cp==0
label define SER 1 "High SER" 2 "Medium SER" 3 "Low SER" 4 "Very Low
SER"
label values ser SER
label list SER
label variable ser "HH's SER Levels"
tab ser

log close