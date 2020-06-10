program define s_frailtycoxdrop_varsizeuni, rclass
	version 12.0
	syntax, RRATEMIN(real) RRATEMAX(real) DRATE(real) RTIME(real)  ///
FTIME(real) ICC(real) FRATE1(real) FRATE2(real)  ///
NCLUSPERGRP(integer)
	drop _all
	scalar dlambda=-ln(1-`drate')
	scalar lambda1=-ln(1-`frate1')
	scalar lambda2=-ln(1-`frate2')
	set obs `=2*`ncluspergrp''
	gen group=mod(_n,2)
	gen frailty=rgamma(1/`icc',`icc')
	gen hazard=(lambda1+group*(lambda2-lambda1))*frailty
	gen clusid=_n
	gen clussize=(runiform()*(`rratemax’-`rratemin’)+`rratemin’)*`rtime’
	expand clussize
	sort clusid
	by clusid: gen time=`ftime'+`rtime'*_n/clussize
	gen ttf=rexponential(1/hazard)
	gen ttd=rexponential(1/dlambda)
	gen y=(ttf<time) & (ttf<ttd)
	replace time=min(ttf, time, ttd)
	stset time, failure(y)
	capture noisily {
		stcox group, shared(clusid)
		scalar pvalue=2*normal(-abs(_b[group]/_se[group]))
	}
	* If Cox regression fails to converge try parametric regression
	if _rc~=0 {
		capture noisily {
			streg group, dist(exp) frailty(gamma) shared(clusid)
			scalar pvalue=2*normal(-abs(_b[group]/_se[group]))
		}
	}
	return scalar p=pvalue
end
