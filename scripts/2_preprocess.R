#' Clean the data sets
#'
#'* normalization
# * remove non ascii characters: apostrophes, quotes, punctuation, etc.
# * introduce end of sentence marks
# * replace numbers, dates, times, emails, urls, hashtags with special marks
# * remove genitive marks, but let 's for verbs

source("scripts/globals.R")
source("preprocess/preprocess.R")
source("helper/helper.R")

data.samples <- c("devtest", "test", "train")

foreach(data.file = data.samples) %do% {

  sprintf("Started Processing the %s data set", data.file)

  raw.data <- readRDS(sprintf("%s/%s.rds", data.samples.dir, data.file))

  t1 <- Sys.time() # Start cleaning

  clean.data <- clean.corpus(raw.data)

  t2 <- Sys.time() # End of cleaning

  saveRDS(clean.data$cleantxt, sprintf("%s/%s.clean.rds",data.clean.dir,data.file))

  sprintf("%s has been cleaned in %f",data.file, t2-t1 )

}

