#' Globals File
#'
#'

#' Libraries
#'
#'
#'

suppressPackageStartupMessages(library(doParallel))
suppressPackageStartupMessages(library(tm))

## Set the project home Directory
TXTPROCHOME <- list("HOME" = normalizePath(getwd()))
suppressMessages(attach(TXTPROCHOME))

