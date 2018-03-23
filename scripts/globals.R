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
data.clean.stage1.dir <- "data/clean/stage1"
data.clean.stage2.dir <- "data/clean/stage2"
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
