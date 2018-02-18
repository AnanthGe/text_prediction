#' Globals File
#'
#'

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

## Set the project home Directory
TXTPROCHOME <- list("HOME" = normalizePath(getwd()))
suppressMessages(attach(TXTPROCHOME))

## Discover how many clusters are possible
local_clusters <- detectCores() - 1
suppressMessages(attach(list("CLUSTERS" = local_clusters)))
registerDoParallel(local_clusters)
