#' Create Training, Testing and DevTesting Samples
#'
#' We will  consume 70% of data for training,
#' 10% for devtesting & 20% for testing.
#' Since the corpus comes from 3 different sources ,
#' which vary vasty in styles & content, it was decided to go
#' with stratified sampling method, where news, blogs and twitter
#' sources are considered as stratas

source("scripts/globals.R")

## Check if the data files are downloaded and compressed
if(!dir.exists(data.compress.dir)) {
  message("getting data first...")
  source("scripts/get_data.R")
}

if(!dir.exists(data.samples.dir)) {

  ## Create samples directory
  dir.create(data.samples.dir, showWarnings = FALSE, recursive = TRUE)


  ## Create Corpus
    corpus.train <- c()
    corpus.devtest <- c()
    corpus.test <- c()

    ## train, devtest, test percentages
    percent_train <- 0.7
    percent_devtest <- 0.1
    percent_test <- 0.2


    data_files <- list.files(data.compress.dir)

    foreach(data_file = data_files) %do% {

      message(paste("Processing File:", data_file, sep = ''))
      corpus <- readRDS(sprintf("%s/%s", data.compress.dir, data_file))
      corpus_length <- length(corpus)

      ## Get sample counts
      train_count <- ceiling(corpus_length*percent_train)
      test_count <- ceiling(corpus_length*percent_test)
      devtest_count <- corpus_length - train_count - test_count

      ## Get sample ids
      ids <- 1:corpus_length
      train_ids <- sample(ids, train_count, replace = FALSE)
      test_ids <- sample(ids[-train_ids],test_count, replace = FALSE)
      devtest_ids <- sample(ids[-c(train_ids, test_ids)],
                              devtest_count, replace = FALSE)

      ## Get Sample Data
      corpus.train <- c(corpus.train, corpus[train_ids])
      corpus.test <- c(corpus.test, corpus[test_ids])
      corpus.devtest <- c(corpus.devtest, corpus[devtest_ids])

    }

    #Save train/test/devtest samples
    saveRDS(corpus.train, sprintf("%s/train.rds",data.samples.dir))
    saveRDS(corpus.test, sprintf("%s/test.rds",data.samples.dir))
    saveRDS(corpus.devtest, sprintf("%s/devtest.rds",data.samples.dir))
}


