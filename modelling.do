** load dataset
**clsa dataset tte analysis file august 12

**set survival time for major chronic disease category
stset timetomcd [pweight=ipw_final], failure(evermcd==1) scale(1)

	*where ipw_final = truncated weights
	*evermcd==1 = diagnosis of major chronic disease
	*timetomcd = number of years between baseline and diagnosis of major chronic disease

stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(evermcd==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

	*where evermcd==2 = instances of death in the study period
	*where cgah_new = alcohol use categories adjusted for underreporting via alcohol sales 
**sub-analysis by sex
stcreg i.cgah_new ageatsurvey edu marital nutrition bmi alchistory if sex==1, compete(evermcd==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)
stcreg i.cgah_new ageatsurvey edu marital nutrition bmi alchistory if sex==2, compete(evermcd==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

**for cancer
stset agetocancer [pweight=ipw_final], failure(evercancer==1) scale(1)
stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(evercancer==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

**for heart disease
stset agetoheart [pweight=ipw_final], failure(everheart==1) scale(1)
stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(everheart==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

**for stroke
stset agetostroke [pweight=ipw_final], failure(everstroke==1) scale(1)
stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(everstroke==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

**for diabetes
stset agetodiab [pweight=ipw_final], failure(everdiab==1) scale(1)
stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(everdiab==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)

**for copd
stset agetocopd [pweight=ipw_final], failure(evercopd==1) scale(1)
stcreg i.cgah_new ageatsurvey sex edu marital nutrition bmi alchistory, compete(evercopd==2) tvc(nearestsmk nearestinc nearestphys) texp(_t)
