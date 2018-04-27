#' Data directory structure
#'
#' Below are all the data directories that are
#' created to store data sets of different sizes

locale <- "en_US"
data.raw.dir <- "data/raw"
data.raw.en_US <- "data/raw/final/en_US"
data.compress.dir <- "data/compress"
data.samples.dir <- "data/samples"
data.clean.dir <- "data/clean"
data.temp.dir <- "data/temp"
data.temp.ng.dir <- "data/temp/ng"
model.data.dir <- "model/data"
prediction.data.dir <- "prediction/data"


#' Libraries
#'
#'
#'
suppressPackageStartupMessages(library(doParallel))
suppressPackageStartupMessages(library(tm))
suppressPackageStartupMessages(library(stringi))
suppressPackageStartupMessages(library(multidplyr))
suppressPackageStartupMessages(library(RWeka))


## Set the project home Directory
TXTPROCHOME <- list("HOME" = normalizePath(getwd()))
suppressMessages(attach(TXTPROCHOME))


#' Preparatory activities for parallel processing
#'
#' We'll use n-1 cores for processing in parallel
#'
#'
number.workers <- parallel::detectCores()
## Setup to do parallel processing
clusters <- makeCluster(number.workers)
registerDoParallel(clusters)


#' Serial processing for ngrams
#'
#'

chunk.size <- 5000


