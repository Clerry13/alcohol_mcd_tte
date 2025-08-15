*generate weights for msm
**note this code was adapted to account for a three category exposure based on the Stata code for "Causal Inference: What If" by Miguel Hernan & Jamie Robins,Dated: 01/21/2022 by Author: Eleanor Murray
* Clear previous weights/predictions if they exist from prior runs
drop pd_qsmk pn_qsmk sw_a

* Define covariates for the IP weight models

* Fit a multinomial logistic model for the denominator of the IP weights
* This models P(cgah_new | covariates)
mlogit cgah_new sex nearestsmk education income ageatsurvey nearestphys marital bmi, base(0)

* Predict conditional probabilities for each category
* pr(0) predicts P(cgah_new=0 | L)
* pr(1) predicts P(cgah_new=1 | L)
* pr(2) predicts P(cgah_new=2 | L)
predict p_cgah_new0 p_cgah_new1 p_cgah_new2

* Fit a multinomial logistic model for the numerator of the IP weights (marginal probabilities)
mlogit cgah_new, base(0)

* Predict marginal probabilities for each category
predict pm_cgah_new0 pm_cgah_new1 pm_cgah_new2

* Generate stabilized weights
gen sw_a = .

* For cgah_new = 0
replace sw_a = pm_cgah_new0 / p_cgah_new0 if cgah_new == 0

* For cgah_new = 1
replace sw_a = pm_cgah_new1 / p_cgah_new1 if cgah_new == 1

* For cgah_new = 2
replace sw_a = pm_cgah_new2 / p_cgah_new2 if cgah_new == 2

* Check distribution of the stabilized weights
summarize sw_a
