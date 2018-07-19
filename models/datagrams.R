#' This generates the ngrams for the text corpus
#'
#'
#' This implements the application layer over the text mining layer used
#' for preprocessing. We explore the unigrams, bigrams, trigrams and
#' eventually ngrams
#'
#'


source("scripts/globals.R")
source("helper/helper.R")


get.file.chunks <- function(txt, file.name) {

  #' @param txt data to be broken into chunks
  #' @file.name Name forchank files
  #' @return file chunks in temp folder

  print("Creating temp directory....")
  if(!dir.exists(data.temp.dir)) dir.create(data.temp.dir, showWarnings = FALSE)

  number.files <- round(length(txt)/chunk.size, digits = 0)

  ids <- get.group.numbers(number.files, length(txt))

  corpus <- as.data.frame(cbind(id,txt))

  print("Starting to create chunks....")
  for(iter in 1:max(ids)) {

      write.csv(subset(corpus, id == iter),
              sprintf("%s/%s_%d.csv", data.temp.dir, file.name, iter),
              row.names = FALSE)

  if(((round(iter/max(ids), digits = 2)*100) %% 25) < 2)
        print(sprintf(" about %f percent complete..", round(iter/max(ids), digits = 2)*100 ))
  }

}


get.ngram.chunks <- function(ng, file.name) {

  #'@param ng number of tokens
  #'@param file.name name of the ngram file

  if(!dir.exists(data.temp.ng.dir)) dir.create(data.temp.ng.dir, showWarnings = FALSE)

  list.files <- list.files(data.temp.dir, pattern = "*.csv")


  for(iter in 1:length(list.files)) {

    print(sprintf("Starting to process %d /%d file", iter, length(list.files) ))
    temp <- read.csv(paste("./", data.temp.dir, "/", list.files[iter], sep=""))

    temp.ngrams <- NULL

    for(line in 1:nrow(temp)) {

      temp.ngrams <- c(temp.ngrams, t(temp$txt[line], ng))

    }

    saveRDS(temp.ngrams, sprintf("%s/%s_%d_gram_%d_chunk.rds", data.temp.ng.dir,file.name,ng, iter ))

  }

}





































#' Generate Tokens
#'
#' It takes in a line of text and the ngram detail to give you
#' the parsed string

t <- function(text, ndg){

  #' @param txt line of text to split
  #' @param n number of words you want(ngram)

  tokens <- RWeka::NGramTokenizer(text,
                                      RWeka::Weka_control(min = ndg,
                                                          max = ndg,
                                                          delimiters = " \\r\\n\\t"))
  return(tokens)

}
