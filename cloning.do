*identifying instances where alcohol use threshold changed throughout the study period
tab drinkingstatus cgahf1
*indicating a change in alcohol threshold throughout the study period
gen change = .
replace change = 1 if cgah_new==1 & cgahf1==2
replace change = 1 if cgah_new==1 & cgahf1==3
replace change = 1 if cgah_new==2 & cgahf1==3
replace change = 1 if cgah_new==0 & cgahf1==2
replace change = 1 if cgah_new==10 & cgahf1==3
replace change = 1 if cgah_new==0 & cgahf1==3
replace change = 1 if cgah_new==1 & cgahf1==2
replace change = 1 if cgah_new==2 & cgahf1==2
replace change = 1 if cgah_new==2 & cgahf1==1
replace change = 1 if cgah_new==1 & cgahf2==2
replace change = 1 if cgah_new==1 & cgahf2==3
replace change = 1 if cgah_new==2 & cgahf2==3
replace change = 1 if cgah_new==0 & cgahf2==2
replace change = 1 if cgah_new==10 & cgahf2==3
replace change = 1 if cgah_new==0 & cgahf2==3
replace change = 1 if cgah_new==1 & cgahf2==2
replace change = 1 if cgah_new==2 & cgahf2==2
replace change = 1 if cgah_new==2 & cgahf2==1
expand 2 if change==1, gen(changeclone)
replace change=0 if missing(change)
expand 2 if change==0, gen(originalclone)

*create artificial censor
replace evermcd = 3 if changeclone==1


gen everdiabetes=diabetesf1
replace everdiabetes=diabetesf2
tab everdiabetes
tab everdiabetes diabetesf1
gen evercancer=cancerf1
replace evercancer=cancerf2
tab evercancer
replace everdiabetes=0 if missing(everdiabetes)
replace evercancer=0 if missing(evercancer)
tab evercancer
gen everstroke= strokef1
replace everstroke=strokef2
replace everstroke=0 if missing(everstroke)
replace everheart= heartdiseasef1
gen everheart= heartdiseasef1
replace everheart=heartdiseasef2
replace everheart=0 if missing(everheart)
gen evercopd=copdf1
replace evercopd=copdf2
replace evercopd=0 if missing(evercopd)
replace evercancer = 3 if changeclone==1
replace everdiabetes = 3 if changeclone==1
replace everstroke = 3 if changeclone==1
replace everheart = 3 if changeclone==1
replace evercopd = 3 if changeclone==1
