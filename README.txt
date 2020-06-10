The Early Youth Engagement in first episode psychosis (EYE-2) study: pragmatic cluster 
randomised controlled trial of implementation, effectiveness & cost effectiveness of a team-
based motivational intervention to improve engagement

DETAILS OF SAMPLE SIZE JUSTIFICATION


Pre-study sample size justification submitted to funder:

Time to disengagement will be analysed using frailty analysis to adjust for clustering by 
service. Simulation confirms that 10 clusters per arm (n=950) will achieve 90% power to 
detect a difference corresponding to 12 month disengagement rates of 25% (standard 12-month 
disengagement rate from EIP service)[1-3] vs 15%, assuming time to disengagement has 
exponential distribution; intracluster correlation 0.05;[4] drop-out rate 10% per year; 
conservative significance level 3% to correct for inflation of Type I error due to small 
cluster numbers; variable cluster size modelled as a uniform random variable between 35 and 
60; recruitment at referral; 12 months recruitment plus 12 months followup. Simulations 
conducted using the SimSam package in Stata 14.[5]

[1] Doyle R, Turner N, Fanning F et al. First episode psychosis and disengagament from
treatment: A systematic review. Psychiatric services 2014;65(5): 603-611
[2] Turner M, Smith-Hamel C, Mulder R. Prediction of twelve-month service disengagement
from an early intervention in psychosis service. Early Intervention in Psychiatry 2007;1:
276-281
[3] Conus P, Lambert M, Cotton S, Bonsack C, McGorry PD, Schimmelmann BG. Rate and 
predictors of service disengagement in an epidemiological first-episode psychosis cohort. 
Schizophrenia Research 2010;118:256-263
[4] Jeong JH & Jung SH. Rank tests for clustered survival data when dependent subunits are 
randomized. Statistics in Medicine 2006;25:361-373
[5] Hooper. Versatile sample size calculation using simulation. Stata Journal 2013;13(1):
21-38


How the sample size was calculated:

We used the simsam package for Stata. You will need to have installed Stata v14 or higher to
run the code in this repository. You will also need to have installed the simsam package: to 
do this enter the command "findit simsam" in Stata, click on the link to "st0282 SJ13-1 
Versatile sample size calculation using simulation", and then click on "Install".

The simsam package calculates sample size to achieve given power, for any analaysis and any
data generating model that can be programmed in Stata. A separate Stata programme must be
defined for generating and analysing a model dataset of a given size. The file 
"s_frailtycoxdrop_varsizeuni.ado" in this repository contains Stata code for a programme 
that generates and anaylises a model EYE-2 dataset. Once you have run this code, or saved it
with your other ado files, you can calculate sample size with simsam. We used the following 
code (which is also saved in this repository as "EYE2_sample_size.do"):

 version 14
 set seed 261018
 set maxiter 20
 simsam s_frailtycoxdrop_varsizeuni ncluspergrp,  ///
     detect(frate1(0.25) frate2(0.15)) null(frate1(0.25) frate2(0.25))  /// 
     assuming(rratemin(35) rratemax(60) drate(0.1) rtime(1) ftime(1)  ///
     icc(0.05)) p(.9) a(0.03) inc(1) prec(0.01) start(10)

This produces the following output:

 ------------------------------------------------------
 iteration nclusp~p              power (99% CI)
 ------------------------------------------------------
         1       10 ........... 0.9300 (0.8372, 0.9792)
         2        9 ........... 0.8830 (0.8545, 0.9078)
         3       10 ........... 0.9182 (0.9087, 0.9271)
         4        9 ........... 0.8931 (0.8825, 0.9032)
 ------------------------------------------------------
      null       10 ........... 0.0471 (0.0356, 0.0610)
 ------------------------------------------------------

    ncluspergrp = 10
         achieves 91.82% power (99% CI 90.87, 92.71)
           at the 3% significance level
     to detect
         frate1 = 0.25
         frate2 = 0.15
      assuming
       rratemin = 35
       rratemax = 60
          drate = 0.1
          rtime = 1
          ftime = 1
            icc = 0.05

      under null:  4.71% power (99% CI  3.56,  6.10)

 If continuing, use prec/inc < 1.5e-02


This confirms the 10 clusters per arm quoted in the sample size justification text above 
(see this text for details of other assumptions made, which are also reported in the 
output).
