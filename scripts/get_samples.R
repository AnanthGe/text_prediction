#' Create Training, Testing and DevTesting Samples
#'
#' We will  consume 70% of data for training,
#' 10% for devtesting & 20% for testing.
#' Since the corpus comes from 3 different sources ,
#' which vary vasty in styles & content, it was decided to go
#' with stratified sampling method, where news, blogs and twitter
#' sources are considered as stratas

source("scripts/globals.R")
set.seed(44444)

## Check if the data files are downloaded and compressed
if(!dir.exists(data.compress.dir)) {
  message("getting data first...")
  source("scripts/get.data.R")
}

if(!dir.exists(data.samples.dir)) {

  ## Create samples directory
  dir.create(data.samples.dir, showWarnings = FALSE, recursive = TRUE)


  ## Create Corpus
    corpus.train <- c()
    corpus.devtest <- c()
    corpus.test <- c()

    ## train, devtest, test percentages
    percent.train <- 0.7
    percent.devtest <- 0.1
    percent.test <- 0.2


    data.files <- list.files(data.compress.dir)

    pbar <- txtProgressBar(min=1, max=length(data.files), style = 3)
    counter <- 1

    print("Creating folds.....")
    foreach(data.file = data.files) %do% {


      corpus <- readRDS(sprintf("%s/%s", data.compress.dir, data.file))
      corpus.length <- length(corpus)

      ## Get sample counts
      train.count <- ceiling(corpus.length*percent.train)
      test.count <- ceiling(corpus.length*percent.test)
      devtest.count <- corpus.length - train.count - test.count

      ## Get sample ids
      ids <- 1:corpus.length
      train.ids <- sample(ids, train.count, replace = FALSE)
      test.ids <- sample(ids[-train.ids],test.count, replace = FALSE)
      devtest.ids <- sample(ids[-c(train.ids, test.ids)],
                              devtest.count, replace = FALSE)

      ## Get Sample Data
      corpus.train <- c(corpus.train, corpus[train.ids])
      corpus.test <- c(corpus.test, corpus[test.ids])
      corpus.devtest <- c(corpus.devtest, corpus[devtest.ids])

      setTxtProgressBar(pbar, counter)
      counter<- counter+1
    }

    #Save train/test/devtest samples
    saveRDS(corpus.train, sprintf("%s/train.rds",data.samples.dir))
    saveRDS(corpus.test, sprintf("%s/test.rds",data.samples.dir))
    saveRDS(corpus.devtest, sprintf("%s/devtest.rds",data.samples.dir))
}


