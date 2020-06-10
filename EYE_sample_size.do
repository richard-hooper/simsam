version 14
set seed 261018
set maxiter 20
simsam s_frailtycoxdrop_varsizeuni ncluspergrp,  ///
    det(frate1(0.25) frate2(0.15)) null(frate1(0.25) frate2(0.25))  ///
    assuming(rratemin(35) rratemax(60) drate(0.1) rtime(1) ftime(1)  ///
    icc(0.05)) p(.9) a(0.03) inc(1) prec(0.01) start(10)
