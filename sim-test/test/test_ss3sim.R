# Test common functionality of the ss3sim package:
# Examples by ss3sim authors.
# This script by Athol Whitten: awhitten@gmail.com

#Load the ss3sim package:
library(ss3sim)

# Create a temporary folder for the output and set the working directory:
setwd('C:/Dropbox/Github/mezo-research/snapper/sims/test')

# Find the data in the ss3sim package:
d <- system.file("extdata", package = "ss3sim")
om <- paste0(d, "/models/cod-om")
em <- paste0(d, "/models/cod-em")
case_folder <- paste0(d, "/eg-cases")

# Without bias adjustment:
run_ss3sim(iterations = 1:1, scenarios = "D0-E0-F0-R0-M0-cod",
  case_folder = case_folder, om_dir = om, em_dir = em)

# Get results and plot from example above:
get_results_all(user_scenarios = "D0-E0-F0-R0-M0-cod")

# Read in the .csv files produced above:
scalar_dat <- read.csv("ss3sim_scalar.csv")
ts_dat <- read.csv("ss3sim_ts.csv")

# Format data for plotting:
scalar_dat_long <- reshape2::melt(scalar_dat[,c("scenario", "D", "E",
                                                "replicate", "max_grad", "steep", "logR0", "depletion", "SSB_MSY",
                                                "SR_sigmaR", "NatM")], id.vars = c("scenario", "D", "E",
                                                                                   "replicate", "max_grad"))
scalar_dat_long <- plyr::rename(scalar_dat_long,
                                c("value" = "relative_error"))

# An example specifying the case files:
run_ss3sim(iterations = 1:1, scenarios = "D0-E0-F0-R0-cod",
  case_folder = case_folder, om_dir = om, em_dir = em,
  case_files = list(F = "F", D = c("index", "lcomp",
      "agecomp"), R = "R", E = "E"))
unlink("D0-E0-F0-R0-cod", recursive = TRUE) # clean up

# With bias adjustment:
# (Note that bias_nsim should be bigger, say 5 or 10, but it is set
# to 2 here so the example runs faster.)
run_ss3sim(iterations = 1:1, scenarios = "D1-E0-F0-R0-M0-cod",
  case_folder = case_folder, om_dir = om, em_dir = em,
  bias_adjust = TRUE, bias_nsim = 2)

# Restarting the previous run using the existing bias-adjustment
# output
run_ss3sim(iterations = 2:3, scenarios = "D1-E0-F0-R0-M0-cod",
  case_folder = case_folder, om_dir = om, em_dir = em,
  bias_adjust = FALSE, bias_already_run = TRUE)
unlink("D1-E0-F0-R0-M0-cod", recursive = TRUE) # clean up

# A run with deterministic process error for model checking:
recdevs_det <- matrix(0, nrow = 100, ncol = 20)
run_ss3sim(iterations = 1:20, scenarios = "D0-E100-F0-R0-M0-cod",
  case_folder = case_folder, om_dir = om, em_dir = em,
  bias_adjust = TRUE, bias_nsim = 2, user_recdevs = recdevs_det)
unlink("D0-E100-F0-R0-M0-cod", recursive = TRUE) # clean up

# An example of a run using parallel processing across 2 cores:
require(doParallel)
registerDoParallel(cores = 2)
require(foreach)
getDoParWorkers() # check how many cores are registered
run_ss3sim(iterations = 1, scenarios = c("D0-E0-F0-R0-M0-cod",
    "D1-E0-F0-R0-M0-cod"), case_folder = case_folder,
  om_dir = om, em_dir = em, parallel = TRUE)
unlink("D0-E0-F0-R0-M0-cod", recursive = TRUE) # clean up
unlink("D1-E0-F0-R0-M0-cod", recursive = TRUE) # clean up

# Return to original working directory:
setwd(wd)

# End of file.