*generate weights for msm
**note this code was adapted to account for a three category exposure based on the Stata code for "Causal Inference: What If" by Miguel Hernan & Jamie Robins,Dated: 01/21/2022 by Author: Eleanor Murray
drop pd_qsmk pn_qsmk sw_a

* Define covariates for the IP weight models

* Fit a ordinal model for the denominator of the IP weights
ologit cgah_new sex nearestsmk education income ageatsurvey nearestphys marital bmi, base(0)

* Predict conditional probabilities for each category
* pr(0) predicts P(cgah_new=0 | L)
* pr(1) predicts P(cgah_new=1 | L)
* pr(2) predicts P(cgah_new=2 | L)
predict p_cgah_new0 p_cgah_new1 p_cgah_new2

* Fit an ordinal model for the numerator of the IP weights (marginal probabilities)
ologit cgah_new, base(0)

* Predict marginal probabilities for each category of exposure
predict pm_cgah_new0 pm_cgah_new1 pm_cgah_new2

* Generate stabilized weights
gen sw_a = .

* For cgah_new = 0
replace sw_a = pm_cgah_new0 / p_cgah_new0 if cgah_new == 0

* For cgah_new = 1
replace sw_a = pm_cgah_new1 / p_cgah_new1 if cgah_new == 1

* For cgah_new = 2
replace sw_a = pm_cgah_new2 / p_cgah_new2 if cgah_new == 2

*Check
summarize sw_a

*Normalize
quietly sum sw_a
scalar sum_w  = r(sum)
scalar N      = r(N)
scalar norm_factor = N / sum_w

gen ipw_normalized = sw_a * norm_factor


* Calculate the total sample size (N) and the sum of the truncated weights.
quietly sum ipw_raw
scalar sum_weights = r(sum)
scalar N = r(N)

* Calculate the normalization factor (N / Sum of weights).
scalar norm_factor = N / sum_weights

gen ipw_final = ipw_raw * norm_factor

*truncate at 20%
_pctile ipw_normalized, p(20 80)
scalar p20 = r(r1)
scalar p80 = r(r2)

* Apply truncation
gen ipw_final = ipw_norm
replace ipw_final = p20 if ipw_final < p20
replace ipw_final = p80 if ipw_final > p80



