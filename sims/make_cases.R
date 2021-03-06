## This file uses R to write the case files. It's a bit awkward but is
## reproducible and easily maintainable.

## Write the F trajectory, basing this on approximate fishing levels from
## assessment
case.dir <- "cases/"
Fvals100 <- c(0, 0.45, 0.52, 0.63, 0.54, 0.62, 0.48, 0.5, 0.45, 0.46, 0.47,
           0.47, 0.69, 0.57, 0.58, 0.62, 0.86, 0.91, 0.89, 0.93, 0.77,
           0.71, 0.73, 0.58, 0.71, 0.74, 0.64, 0.57, 0.59, 0.55, 0.61, 0.6,
           0.62, 0.66, 0.63, 0.61, 0.56, 0.49)
Fcase100 <- c("years; c(1976:2013)",
           "years_alter; c(1976:2013)",
           paste0("fvals; c(", paste(Fvals100, collapse=","), ")"))
writeLines(Fcase100, paste0(case.dir, "F100-sna.txt"))
## Repeat but with .9 after 1995 and .4 after 1995
Fvals101 <- c(Fvals100[1:19], rep(.95, len=length(Fvals100)-19))
Fcase101 <- c("years; c(1976:2013)",
           "years_alter; c(1976:2013)",
           paste0("fvals; c(", paste(Fvals101, collapse=","), ")"))
writeLines(Fcase101, paste0(case.dir, "F101-sna.txt"))
Fvals102 <- c(Fvals100[1:19], rep(.4, len=length(Fvals100)-19))
Fcase102 <- c("years; c(1976:2013)",
           "years_alter; c(1976:2013)",
           paste0("fvals; c(", paste(Fvals102, collapse=","), ")"))
writeLines(Fcase102, paste0(case.dir, "F102-sna.txt"))

## Write data files:
index100 <- c("fleets; c(1,2)", "sds_obs;list(.05,.05)",
              "years;list(seq(1978,2013, by=2),seq(1978,2013, by=2))",
            "cpar;c(1,1)")
writeLines(index100, paste0(case.dir, "index100-sna.txt"))
lcomp100 <- c("fleets; c(1,2)", "Nsamp; list(50,200)",
              "years;list(seq(1978,2013, by=2),seq(1978,2013, by=2))",
            "cpar;c(1,1)", "lengthbin_vector;NULL")
writeLines(lcomp100, paste0(case.dir, "lcomp100-sna.txt"))
agecomp100 <- c("fleets; c(1,2)", "Nsamp; list(50,200)",
              "years;list(seq(1978,2013, by=2),seq(1978,2013, by=2))",
            "cpar;c(1,1)", "agebin_vector;NULL")
writeLines(agecomp100, paste0(case.dir, "agecomp100-sna.txt"))
## one with slightly less data
index101 <- c("fleets; c(1,2)", "sds_obs;list(.1,.1)",
              "years;list(seq(1978,2013, by=4),seq(1978,2013, by=4))",
            "cpar;c(1,1)")
writeLines(index101, paste0(case.dir, "index101-sna.txt"))
lcomp101 <- c("fleets; c(1,2)", "Nsamp; list(50,100)",
              "years;list(seq(1978,2013, by=4),seq(1978,2013, by=4))",
            "cpar;c(1,1)", "lengthbin_vector;NULL")
writeLines(lcomp101, paste0(case.dir, "lcomp101-sna.txt"))
agecomp101 <- c("fleets; c(1,2)", "Nsamp; list(50,100)",
              "years;list(seq(1978,2013, by=4),seq(1978,2013, by=4))",
            "cpar;c(1,1)", "agebin_vector;NULL")
writeLines(agecomp101, paste0(case.dir, "agecomp101-sna.txt"))

## DONT NEED THIS??
## ## Write a base M case. TODO: shoudl be able to delete this in new package.
## Mcase <- c("function_type; change_tv", "param; NatM_p_1_Fem_GP_1",
##   "dev; rep(0, 38)")
## writeLines(Mcase, paste0(case.dir, "M0-sna.txt"))

Ecase <- c("natM_type; 1Parm ", "natM_n_breakpoints; NULL ", "natM_lorenzen; NULL ",
  "natM_val; c(NA, NA) ",
  "par_name; c('L_at_Amin', 'L_at_Amax', 'VonBert_K', 'CV_young', 'CV_old')",
  "par_int; rep(NA, 5) ", "par_phase; rep(-1, 5) ", "forecast_num; 0 ",
  "run_change_e_full; TRUE ")
writeLines(Ecase, paste0(case.dir, "E0-sna.txt"))
