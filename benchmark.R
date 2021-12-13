# benchmark.R
# Author: Joshua Simon
# Date: 08.12.2021
# ---------------------------------------------------- #
# This R script contains a benchmark implementation to 
# check the performance for single and multithreaded 
# workloads. The results are printed to the console. 
# To run this script open an R session an type
# source("<filepath to this script>").
# ---------------------------------------------------- #

if (!require("parallel")) install.packages("parallel")
if (!require("doParallel")) install.packages("doParallel")
library(parallel)
library(doParallel)


timer <- function(test_runs, func, data, max_iter, ...) {
  time_taken <- numeric(test_runs)
  for (run in 1:test_runs) {
    start_time <- Sys.time()

    func(data, max_iter, ...)
    
    end_time <- Sys.time()
    time_taken[run] <- difftime(end_time, start_time, units = "secs")
  }
  return (mean(time_taken))
}


singlethreaed_benchmark <- function(data, max_iter) {
  model <- vector(mode = "list", length = max_iter)
  for (i in 1:max_iter) {
    model[i] <- lm(formula = Petal.Width ~ ., data = data)$df.residual
  }
}  

multithreaed_benchmark <- function(data, max_iter, threads) {
  cores <- threads
  cl <- makeCluster(cores[1]) 
  registerDoParallel(cl)

  model <- foreach (i=1:max_iter) %dopar% {
    lm(formula = Petal.Width ~ ., data = data)$df.residual
  }

  stopCluster(cl)
}  


main <- function() {
  # Load up some test data.
  data(iris)

  # Set parameters for the benchmark runs.
  test_runs <- 5
  max_iter <- 2e4
  
  # Run the singlethreaded benchmark.
  print("Starting singlethreaded run...")
  single_time <- timer(test_runs = test_runs, func = singlethreaed_benchmark,
                       data = iris, max_iter = max_iter)
  print(paste0("Runtime on ", 1, " threds took ", round(single_time, 3), " seconds in average."))
  
  # Run the multithreaed on 4 cores benchmark.
  if (detectCores() >= 4) {
      print("Starting multithreaded run...")
      multi_time <- timer(test_runs = test_runs, func = multithreaed_benchmark,
                       data = iris, max_iter = max_iter, threads = 4)
      print(paste0("Runtime on ", 4, " threds took ", round(multi_time, 3), " seconds in average."))
  }
  
  # Run the multithreaed on all cores benchmark.
  print("Starting multithreaded run...")
  multi_time <- timer(test_runs = test_runs, func = multithreaed_benchmark,
                       data = iris, max_iter = max_iter, threads = detectCores())
  print(paste0("Runtime on ", detectCores(), " threds took ", round(multi_time, 3), " seconds in average."))
}


main()