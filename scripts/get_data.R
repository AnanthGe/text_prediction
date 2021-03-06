#' Download and store data files in an optimal format
#'
#' Data:
#' https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
#'

#' Research the RDF/XML format
#' https://en.wikipedia.org/wiki/Resource_Description_Framework

source("scripts/globals.R")

setwd(HOME)

if(!dir.exists("data")) {
  print("Downloading Data files...")
  ## Create directories to store raw data
  dir.create(data.raw.dir, showWarnings = FALSE, recursive = TRUE)

  file_name <- "./data/raw/Coursera-SwiftKey.zip"
  data_url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

  download.file(url = data_url, destfile = file_name,
                method = "auto", quiet = FALSE)

  unzip(zipfile = file_name, exdir = "data/raw")
}

#' Compress input files and save. It can be noticed that .Rds format
#' is the fastest and most efficient format for storing data.
#' readRDS is ~ 18 times faster than read.csv(). Please refer to the below:
#' https://csgillespie.github.io/efficientR/efficient-inputoutput.html
#'

if(!dir.exists(data.compress.dir)) {

  print("Extracting data in parallel....")
  ## Create the directory
  dir.create(data.compress.dir, showWarnings = FALSE)

      ## Read the data files in english locale
      data_en_files <- list.files(path = data.raw.en_US)

      ## Read/Save all the files in the directory, parallelly

      foreach(data_file = data_en_files) %dopar% {
        ## Read Data
        file_name <- paste("data/raw/final/en_US/",data_file,sep="")

        dat <- readLines(con = file(file_name, "r"),
                         encoding = "UTF-8",
                         skipNul = TRUE)

        #' Compress & Save. Did not observe major difference
        #' with /w/o using the compress switch

        saveRDS(object = dat, file = paste("data/compress/",
                                           strsplit(data_file, ".txt"),
                                           ".rds", sep = ""),
                ascii = FALSE, compress = TRUE)

      }

      print("Extraction Complete...")
}

