**examples of variable recoding

**drinking categories
generate cgah_new = .
replace cgah_new = 1 if adj_weeklydrinks > 6
replace cgah_new = 2 if adj_weeklydrinks > 2 & adj_weeklydrinks <= 6
replace cgah_new = 3 if adj_weeklydrinks > 0 & adj_weeklydrinks <= 2

label define cgah_labels 1 "> 6 drinks/week" 2 "> 2 to 6 drinks/week" 3 "> 0 to 2 drinks/week" 
label values cgah_new cgah_labels

tabulate cgah_new adj_weeklydrinks
mean adj_weeklydrinks, over(cgah_new)


**categorizing outcome variables
use "/Users/clairebenny/CLSA/clsa dataset missing trackfollow2.dta"
gen heartdiseasef1 =. 
replace heartdiseasef1 =1 if cct_heart_trf1
drop heartdiseasef1
gen heartdiseasef1 =. 
replace heartdiseasef1 =1 if cct_heart_trf1
drop heartdiseasef1
gen heartdiseasef1 =. 
replace heartdiseasef1 =1 if cct_heart_trf1==1
replace heartdiseasef1 =1 if ccc_heart_cof1==1
encode ccc_heart_cof1, gen(heart_cof1)
replace heartdiseasef1 =1 if heart_cof1==1
replace heartdiseasef1 =0 if missing(heartdiseasef1)
tab heartdiseasef1
melogit heartdisease weeklyd
melogit heartdiseasef1 i.weeklyd
melogit heartdiseasef1 weeklyd
gen heartdiseasef2 =. 
replace heartdiseasef1 =1 if cct_heart_trf2
encode ccc_heart_cof2, gen(heart_cof2)
replace heartdiseasef1 =1 if ccc_heart_cof2==1
drop heartdiseasef1
gen heartdiseasef1 =. 
replace heartdiseasef1 =1 if cct_heart_trf1==1
replace heartdiseasef1 =1 if heart_cof1==1
gen heartdiseasef2 =. 
replace heartdiseasef2 =1 if ccc_heart_cof2==1
melogit heartdiseasef1 weeklyd
melogit heartdiseasef2 weeklyd
replace heartdiseasef1 =0 if missing(heartdiseasef1)
save "/Users/clairebenny/CLSA/clsa dataset missing trackfollow2.dta", replace
melogit heartdiseasef1 highrisk
tab highrisk
tab highrisk heartdiseasef1
tab highrisk heartdiseasef2
save "/Users/clairebenny/CLSA/clsa dataset missing trackfollow2.dta", replace
gen copdf1=. 
replace copdf1 if ccc_copd_cof1==1
encode ccc_copd_cof1, gen(copd_cof1)
replace copdf1 if copd_cof1==1
replace copdf1=1 if ccc_copd_cof1==1
replace copdf1=1 if copd_cof1==1
replace copdf1=1 if cct_copd_trf1 == 1
replace copdf1 =0 if missing(copdf1)
gen diabetesf1 =.
replace diabetesf1 =1 if cct_diab_trf1==1
replace diabetesf1 =1 if ccc_diab_cof1==1
replace diabetesf1 =1 if dia_diab_cof1==1
encode dia_diab_cof1, gen(diab_cof1)
replace diabetesf1 =1 if diab_cof1==1

replace diabetesf1=0 if missing(diabetesf1)
gen strokef1 =. 
replace strokef1 = 1 if missing cct_tia_trf1==1
replace strokef1 = 1 if cct_tia_trf1==1
encode ccc_tia_cof1, gen(tia_cof1)
replace strokef1 = 1 if tia_cof1==1
replace strokef1 =0 if missing(strokef1)
gen cancerf1 =. 
replace cancerf1=1 if cct_canc_trf1==1
replace amif1 =. 
gen amif1=.
replace amif1=1 if cct_ami_trf1==1
encode ccc_ami_cof1, gen (ami_cof1)
replace amif1 = 1 if ami_cof1==1
replace amif1 = 0 if missing(amif1)
replace cvaf1 =. 
gen cvaf1=.
replace cvaf1 = 1 if cct_cva_trf1=11
replace cvaf1 = 1 if cct_cva_trf1=1
replace cvaf1 = 1 if cct_cva_trf1==1
replace cvaf1 = 1 if cct_cvafx_trf1==1
encode ccc_cva_cof1, gen(cva_cof1)
replace cvaf1 = 1 if cva_cof1==1
replace cvaf1 =0 if missing(cvaf1)
tab cvaf1
save "/Users/clairebenny/CLSA/clsa dataset missing trackfollow2.dta", replace

replace heartdiseasef2 =1 if cct_heart_trf2==1
replace heartdiseasef2 = 0 if missing(heartdisease)
drop heartdiseasef2
gen heartdiseasef2 =. 
replace heartdiseasef2 =1 if ccc_heart_cof2==1
replace heartdiseasef2 =1 if ccc_heart_cof2==1
replace heartdiseasef2 =1 if cct_heart_trf2==1
replace heartdiseasef2 = 0 if missing(heartdisease)
drop heartdiseasef2
gen heartdiseasef2 =. 
replace heartdiseasef2 =1 if ccc_heart_cof2==1
replace heartdiseasef2 =1 if ccc_heart_cof2==1
replace heartdiseasef2 =1 if cct_heart_trf2==1
replace heartdiseasef2 = 0 if missing(heartdiseasef2)
save "/Users/clairebenny/Desktop/Pabayo lab work/Postdoctoral Fellowship/clsa dataset oct 25 2023.dta", replace

browse
tab amif2
gen amif2=.
replace amif2 = 1 if ccc_ami_cof2==1
replace amif2 =1 if cct_ami_trf2==1
replace amif2 = 0 if missing(amif2)
gen copdf2=. 
replace copdf2=1 if ccc_copd_cof2==1
replace copdf2=1 if cct_copd_trf2==1
gen diabetesf2=.
gen strokef2=.
gen cancerf2=.
replace strokef2=1 if ccc_cva_cof2==1
replace strokef2=1 if cct_cva_trf2==1
replace diabetesf2 =1 if dia_diab_cof2==1
replace daibetesf2=1 if cct_diab_trf2==1
replace diabetesf2=1 if cct_diab_trf2==1
replace cancerf2=1 if cct_canc_trf2==1
replace cancerf2=1 if ccc_canc_cof2==1
tab cancerf2
replace cancerf2=0 if missing(cancerf2)
replace strokef2 = 0 if missing(strokef2)
replace diabetesf2=0 if missing(diabetes)
replace copdf2=0 if missing(copdf2)

**generate time-to variables
gen startdate = startdate_trm
tab startdate
replace startdate = startdate_com if missing(startdate)
tab startdate
summ startdate
save "/Users/clairebenny/CLSA/clsa dataset nov 6.dta"
misstable summarize startdate
browse
help datetime
gen new_date = dofc(startdate)
tab startdate
details startdate
summ stardate
summ startdate
 generate eventdate = date(startdate, "DMY")
 rename eventdate surveydate
 tab age_nmbr_trm
 gen ageatsurvey = age_nmbr_trm
 replace ageatsurvey = age_nmbr_com if missing(ageatsurvey)
 tab ageatsurvey
 gen agetocancer = cancerage - ageatsurvey
 tab agetocancer
 gen agetostroke = strokeage - ageatsurvey
 tab agetostroke
 gen agetoheartdisease = heartdiseaseage - ageatsurvey
 browse
 gen agetoheartdisease = heartage - ageatsurvey
 tab agetoheartdisease
 replace heartage = . if heartage>=9000
 gen agetodiabetes = diabetesage - ageatsurvey
 tab agetodiabetes
 browse
 gen agetocopd = copdage - ageatsurvey
 tab agetocopd
 save "/Users/clairebenny/CLSA/clsa dataset nov 6.dta", replace
